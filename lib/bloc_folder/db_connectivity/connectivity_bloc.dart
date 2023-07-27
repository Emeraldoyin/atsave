import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  }

  _retrieveData(
      RetrieveDataEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    try {
      final presentGoals = await dbRepo.iSavingsGoals();
      final incomingGoals = await dbRepo.fSavingGoals(event.uid);
      log(event.uid.toString(), name: 'event uid');
      log(incomingGoals.toString(), name: 'from firebase');
      if (presentGoals != incomingGoals) {
        dbRepo.updateGoalsInLocalDB(incomingGoals);
      }
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
        availableSavingsGoals: incomingGoals,
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
}
