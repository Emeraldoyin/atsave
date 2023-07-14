import 'package:bloc/bloc.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/expenses.dart';
import '../../model/savings_goals.dart';
import '/repository/database_repository.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  DatabaseRepository dbRepo = DatabaseRepository();
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<RetrieveDataEvent>((event, emit) {
      return _retrieveData(event, emit);
    });
  }

  _retrieveData(
      RetrieveDataEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    try {
      final presentGoals = await dbRepo.iSavingsGoals();
      final incomingGoals = await dbRepo.fSavingGoals();
      if (presentGoals != incomingGoals) {
        dbRepo.updateSavingsGoals(incomingGoals);
      }
      final presentTransactions = await dbRepo.iSavingsTransactions();
      final incomingTransactions = await dbRepo.fSavingTxns();
      if (presentTransactions != incomingTransactions) {
        dbRepo.updateSavingsTransactions(incomingTransactions);
      }
      final presentExpenses = await dbRepo.iExpenses();
      final incomingExpenses = await dbRepo.fExpenses();

      if (presentExpenses != incomingExpenses) {
        await dbRepo.updateExpenses(presentExpenses);
      }
      await FirebaseAuth.instance.signOut();
       emit(DbSuccessState(
        availableSavingsGoals: presentGoals,
        availableExpenses: presentExpenses,
        availableSavingsTransactions: presentTransactions));
    } on FirebaseAuthException catch (e) {
      emit(DbErrorState(error: e.toString()));
    }
   
  }
  // final quizQuestions = await dbRepo.getAllQuizQuestions();

  // final presentLessons = await dbRepo.iLessons();
  // final incomingLessons = await dbRepo.fLessons();

  // if (presentLessons != incomingLessons) {
  //   await dbRepo.updateLessons(incomingLessons);
  // }
  // final presentTopics = await dbRepo.iTopics();

  // final incomingTopics = await dbRepo.fTopics();

  // if (presentTopics != incomingTopics) {
  //   await dbRepo.updateTopics(incomingTopics);
  // }

  // final incomingLeaderBoardEntries = await dbRepo.fEntries();
  // final presentLeaderBoardEntries = await dbRepo.iEntries();

  // if (presentLeaderBoardEntries != incomingLeaderBoardEntries) {
  //   await dbRepo.updateLeaderBoardEntries(incomingLeaderBoardEntries);
  // }

  //   var allSelectedLessons = await dbRepo.getAllSelectedLessons();

  //   await RemoteDbManager().saveAllSelectedLessons(allSelectedLessons);

  //   //  final presentUser = await dbRepo.getCurrentUser(event.user);

  //   if (presentTopics != incomingTopics) {
  //     await dbRepo.updateTopics(incomingTopics);
  //   }
}
