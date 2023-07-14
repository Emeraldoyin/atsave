import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseRepository dbRepo = DatabaseRepository();

  DatabaseBloc() : super(DatabaseInitial()) {
    on<AddSavingsGoalsEvent>((event, emit) => _add(event, emit));
  }

  _add(AddSavingsGoalsEvent event, emit) async {
    emit(DatabaseLoadingState());

    try {
      await dbRepo.saveGoal(event.goal);
      dbRepo.saveSavingsGoalsToServer(event.goal);

      emit(SavingsGoalAddedState(goal: event.goal));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'auth error');
      emit(ErrorState(error: e.message.toString()));
    }
  }
}
