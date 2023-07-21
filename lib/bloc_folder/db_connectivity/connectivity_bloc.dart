import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/repository/database_repository.dart';
import '../../model/savings_goals.dart';

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
      final incomingGoals = await dbRepo.fSavingGoals(event.uid);
      log(event.uid.toString(), name: 'event uid');
      log(incomingGoals.toString(), name: 'from firebase');
      if (presentGoals != incomingGoals) {
        dbRepo.updateSavingsGoals(incomingGoals);
      }
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
        // availableExpenses: presentExpenses,
        // availableSavingsTransactions: presentTransactions
      ));
    } on FirebaseAuthException catch (e) {
      emit(DbErrorState(error: e.toString()));
    }
  }
}
