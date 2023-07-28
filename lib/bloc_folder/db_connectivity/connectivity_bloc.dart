import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/savings_transactions.dart';
import '/repository/database_repository.dart';
import '../../model/category.dart';
import '../../model/savings_goals.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  DatabaseRepository dbRepo = DatabaseRepository();
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
      // final presentTransactions = await dbRepo.iSavingsTransactions();
      // final incomingTransactions = await dbRepo.fSavingTxns();
      // if (presentTransactions != incomingTransactions) {
      //   dbRepo.updateSavingsTransactions(incomingTransactions);
      // }
      // final presentExpenses = await dbRepo.iExpenses();
      // final incomingExpenses = await dbRepo.fExpenses();

      // if (presentExpenses != incomingExpenses) {
      //   await dbRepo.updateExpenses(presentExpenses);
      // }

      emit(DbSuccessState(
        availableSavingsGoals: presentGoals,
        availableCategories: incomingCategories,
        // availableExpenses: presentExpenses,
        // availableSavingsTransactions: presentTransactions
      ));
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
    emit(DbSuccessState(
        availableSavingsGoals: goals, availableCategories: presentCategories));
  }

  _updateCurrentAmount(UpdateCurrentAmountEvent event, emit) async {
    emit(DbLoadingState());
    final presentCategories = await dbRepo.iCategories();
    try {
      List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
      await dbRepo.updateCurrentAmount(event.addedAmount, event.goal.id!);

      emit(DbSuccessState(
          availableCategories: presentCategories,
          availableSavingsGoals: goals));
    } catch (e) {
      log(e.toString(), name: 'error');
      emit(DbErrorState(error: e.toString()));
    }
  }

  _editGoal(EditGoalEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());

    // try {
    await dbRepo.updateSavingsGoalById(event.goal);
    await dbRepo.addSavingsTxn(event.txn);
    final List<Category> presentCategories = await dbRepo.iCategories();
    final List<SavingsGoals> goals = await dbRepo.iSavingsGoals();
    emit(DbSuccessState(
        availableCategories: presentCategories, availableSavingsGoals: goals));
    // }
    //  catch (e) {
    //   log(e.toString(), name: 'error');
    //   emit(DbErrorState(error: e.toString()));
    // }
  }
}
