import 'dart:developer';

import 'package:easysave/model/atsave_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/savings_goals.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/database_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authRepo = AuthenticationRepository();
  DatabaseRepository dbRepo = DatabaseRepository();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignInEvent>((event, emit) => _login(event, emit));
    on<SignUpEvent>((event, emit) => _signUp(event, emit));
    on<LogoutEvent>((event, emit) => _syncData(event, emit));
  }
  late ATSaveUser newUser;
  late List<SavingsGoals> userGoals;

  _login(SignInEvent event, emit) async {
    emit(AuthLoadingState());

    try {
      final userId = await authRepo.login(event.email, event.password);
      final data =
          await FirebaseDatabase.instance.ref().child('User/$userId').get();

      final datamap = data.value as Map<Object?, Object?>?;
      if (data.exists) {
        log(data.value.toString(), name: 'data from remote');
        newUser = ATSaveUser.fromJson(datamap!);
        String displayName = '${newUser.firstName} ${newUser.lastName}';
        final user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName(displayName);
        await user.reload();
        await authRepo.saveUserToDb(newUser);
        userGoals = await dbRepo.fSavingGoals(userId);

        log(userGoals.toString(), name: 'incoming goals');
        await dbRepo.updateGoalsInLocalDB(userGoals);
      } else {
        log('login user just added to realtime db', name: 'Admin');
        await FirebaseDatabase.instance.ref().child('User/$userId').set({});
      }

      emit(LoginSuccessState(user: newUser, availableGoals: userGoals));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'auth error');
      emit(AuthErrorState(error: e.message.toString()));
    } on FirebaseException catch (e) {
      log(e.message.toString(), name: 'firebase error');
    }
  }

  _signUp(SignUpEvent event, emit) async {
    emit(AuthLoadingState());
    try {
      await authRepo.signUp(event.email, event.password, event.createdAt,
          event.firstName, event.lastName);

      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'auth error');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  _syncData(LogoutEvent event, emit) async {
    emit(AuthLoadingState());
    try {
      final presentGoals = await dbRepo.iSavingsGoals();
      final incomingGoals = await dbRepo.fSavingGoals(event.uid);
      log(incomingGoals.toString(), name: 'from firebase');
      if (presentGoals != incomingGoals) {
        dbRepo.updateSavingsGoals(incomingGoals);
        log('done');
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
      await FirebaseAuth.instance.signOut();
      await dbRepo.closeDB();
      emit(LogoutSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
