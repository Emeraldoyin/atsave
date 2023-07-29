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

///the class is used to manage states for adding new objects into the collections like [SavingsGoals] and [Expenses]
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
      int? id = await dbRepo.saveGoal(event.goal);
      event.goal.id = id ?? 1;
      await dbRepo.saveSavingsGoalsToServer(event.goal);
      event.txn.savingsId = event.goal.id!;
      int? txid = await dbRepo.saveTransaction(event.txn);
      event.txn.savingsId = event.goal.id!;
      event.txn.id = txid ?? 1;
      await dbRepo.saveSavingsTransactionsToServer(event.txn);

      emit(SavingsGoalAddedState(goal: event.goal, txn: event.txn));
    } catch (e) {
      log(e.toString(), name: 'auth error');
      emit(ErrorState(error: e.toString()));
    }
  }
}
