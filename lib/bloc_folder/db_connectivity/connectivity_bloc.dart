import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easysave/utils/helpers/comma_formatter.dart';
import 'package:easysave/utils/helpers/session_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/repository/database_repository.dart';
import '../../model/category.dart';
import '../../model/expenses.dart';
import '../../model/savings_goals.dart';
import '../../model/savings_transactions.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

///This is file that contains the bloc that handles all the connectivity of the application to remote and local database...ensuring proper synchronisation
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  DatabaseRepository dbRepo = DatabaseRepository();
  SessionManager manager = SessionManager();
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<RetrieveDataEvent>((event, emit) {
      return _retrieveData(event, emit);
    });
    on<DeleteSavingsGoalsEvent>(
      (event, emit) => _deleteGoal(event, emit),
    );
    on<UpdateCurrentAmountEvent>(
      (event, emit) => _updateCurrentAmount(event, emit),
    );
    on<EditGoalEvent>(
      (event, emit) => _editGoal(event, emit),
    );
    on<WithdrawEvent>((event, emit) => _withdraw(event, emit));
  }

  _retrieveData(
      RetrieveDataEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    try {
      final presentGoals = await dbRepo.iSavingsGoals();
      // final incomingGoals = await dbRepo.fSavingGoals(event.uid);

      // if (presentGoals != incomingGoals) {
      //   dbRepo.updateGoalsInLocalDB(incomingGoals);
      // }
      final presentCategories = await dbRepo.iCategories();
      final incomingCategories = await dbRepo.fCategories();
      final presentTransactions = await dbRepo.iSavingsTransactions();
      final incomingTransactions = await dbRepo.fSavingTxns(event.uid);
      if (presentTransactions != incomingTransactions) {
        dbRepo.updateTransactions(incomingTransactions);
      }
      final presentExpenses = await dbRepo.iExpenses();
      final incomingExpenses = await dbRepo.fExpenses(event.uid);

      if (presentExpenses != incomingExpenses) {
        await dbRepo.updateExpenses(incomingExpenses, event.uid);
      }

      if (presentCategories != incomingCategories) {
        await dbRepo.updateCategories(incomingCategories);
      }

      emit(
        DbSuccessState(
          availableSavingsGoals: presentGoals,
          availableCategories: presentCategories,
          availableExpenses: presentExpenses,
          availableSavingsTransactions: incomingTransactions,
        ),
      );
      log(presentExpenses.toString(), name: 'expenses');
      log(presentCategories.toString(), name: 'categories');
      log(presentGoals.toString(), name: 'all goals!');
      log(incomingTransactions.toString(), name: 'incoming transactions');
    } on FirebaseAuthException catch (e) {
      emit(DbErrorState(error: e.toString()));
    }
  }

  _deleteGoal(DeleteSavingsGoalsEvent event, emit) async {
    emit(DbLoadingState());

    await dbRepo.deleteGoalFromLocalDB(event.goal);
    await dbRepo.deleteGoalFromServer(event.goal);
    final presentCategories = await dbRepo.iCategories();

    List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
    String deviceToken = await manager.retrieveMessagingToken();
    String username = await manager.getUsername();
    String title = 'Savings Goal \'${event.goal.goalNotes}\' deleted';
    String body =
        'Dear $username, you just deleted your savings of \'${event.goal.currentAmount}\' for \'${event.goal.goalNotes}\'. We hope it\'s for a greater good';
    await dbRepo.sendNotification(deviceToken, title, body);
    emit(DbSuccessState(
      availableSavingsGoals: goals,
      availableCategories: presentCategories,
    ));
  }

  _updateCurrentAmount(UpdateCurrentAmountEvent event, emit) async {
    emit(DbLoadingState());
    final presentCategories = await dbRepo.iCategories();

    try {
      List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
      await dbRepo.updateCurrentAmount(event.addedAmount, event.goal.id!);
      await dbRepo.saveTransaction(event.txn);
      await dbRepo.saveSavingsTransactionsToServer(event.txn);
      String deviceToken = await manager.retrieveMessagingToken();
      String username = await manager.getUsername();
      String title = 'Way to go, $username';
      String body =
          'You have successfully added ${event.addedAmount} to you savings goal of ${event.goal.targetAmount} for ${event.goal.goalNotes}';
      await dbRepo.sendNotification(deviceToken, title, body);
      emit(DbSuccessState(
          availableCategories: presentCategories,
          availableSavingsGoals: goals));
    } catch (e) {
      log(e.toString(), name: 'error');
      emit(DbErrorState(error: e.toString()));
    }
  }

  _withdraw(WithdrawEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    await dbRepo.saveExpenses(event.expense);
    await dbRepo.updateCurrentAmountWithDeduction(
        event.expense.amountSpent, event.goal.id!);
    await dbRepo.saveExpensesToServer(event.expense);
    int? id = await dbRepo.saveTransaction(event.txn);
    event.txn.id = id ?? 1;
    await dbRepo.saveSavingsTransactionsToServer(event.txn);
    final List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
    final List<Category> presentCategories = await dbRepo.iCategories();
    final List<SavingsTransactions> transactions =
        await dbRepo.iSavingsTransactions();
    final List<Expenses> exp = await dbRepo.iExpenses();
    String deviceToken = await manager.retrieveMessagingToken();
    String username = await manager.getUsername();
    String title = 'Withdrawal from your savings';
    String body =
        'Dear $username, Your withdrawal of \'${formatDoubleWithComma(event.expense.amountSpent)}\' from your savings for \'${event.goal.goalNotes}\' was successful';
    await dbRepo.sendNotification(deviceToken, title, body);
    emit(DbSuccessState(
        availableSavingsGoals: goals,
        availableCategories: presentCategories,
        availableSavingsTransactions: transactions,
        availableExpenses: exp));
  }

  _editGoal(EditGoalEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    // try {
    await dbRepo.updateSavingsGoalById(event.goal);
    int? id = await dbRepo.saveTransaction(event.txn);
    event.txn.id = id ?? 1;
    await dbRepo.saveSavingsTransactionsToServer(event.txn);
    final List<Category> presentCategories = await dbRepo.iCategories();
    final List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
    final List<SavingsTransactions> transactions =
        await dbRepo.iSavingsTransactions();
    emit(DbSuccessState(
        availableCategories: presentCategories,
        availableSavingsGoals: goals,
        availableSavingsTransactions: transactions));
    // }
    //  catch (e) {
    //   log(e.toString(), name: 'error');
    //   emit(DbErrorState(error: e.toString()));
    // }
  }
}
