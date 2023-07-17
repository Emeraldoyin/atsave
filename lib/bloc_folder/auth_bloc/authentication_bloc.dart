import 'dart:developer';

import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
  }
  late ATSaveUser newUser;

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
        String displayName = newUser.firstName;
        final user = FirebaseAuth.instance.currentUser;
        String uid = user!.uid;
        await user.updateDisplayName(displayName);
        await user.reload();
        await authRepo.saveUserToDb(newUser);
        final userGoals = await dbRepo.fSavingGoals(uid);
        await dbRepo.updateGoalsInLocalDB(userGoals);
      } else {
        log('login user just added to realtime db', name: 'Admin');
        await FirebaseDatabase.instance.ref().child('User/$userId').set({});
      }

      emit(LoginSuccessState(user: newUser));
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
}
