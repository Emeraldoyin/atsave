import 'dart:developer';


import 'package:easysave/model/expenses.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/savings_transactions.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseRepository dbRepo = DatabaseRepository();

  DatabaseBloc() : super(DatabaseInitial()) {
    on<AddSavingsGoalsEvent>((event, emit) => _addGoal(event, emit));
    on<SaveTransactionEvent>(
      (event, emit) => _addTxn(event, emit),
    );
  }

  _addTxn(SaveTransactionEvent event, emit) async {
    emit(DatabaseLoadingState());
    try {
      await dbRepo.saveTransaction(event.txn);
      await dbRepo.saveSavingsTransactionsToServer(event.txn);
      emit(SaveTransactionsSuccessState(txn: event.txn));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(error: e.message.toString()));
    }
  }

  _addGoal(AddSavingsGoalsEvent event, emit) async {
    emit(DatabaseLoadingState());

    try {
      await dbRepo.saveGoal(event.goal);

      await dbRepo.saveSavingsGoalsToServer(event.goal);

      emit(SavingsGoalAddedState(goal: event.goal,));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'auth error');
      emit(ErrorState(error: e.message.toString()));
    }
  }
}
