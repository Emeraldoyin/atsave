import 'dart:developer';

import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/category.dart';
import 'package:easysave/utils/helpers/session_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/expenses.dart';
import '../../model/savings_goals.dart';
import '../../model/savings_transactions.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/database_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// This file and others in the [bloc_folder] library contains all the BLoC classes used for managing the business logic
/// of the application.
/// The BLoC pattern is used for separating the business logic from the UI,
/// making the code more organized and maintainable.
///
///This class is A BLoC that handles authentication-related logic.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  ///defining all necessary properties for this bloc including the object of the [ATSaveUser], the available repository and included models
  AuthenticationRepository authRepo = AuthenticationRepository();
  DatabaseRepository dbRepo = DatabaseRepository();
  SessionManager manager = SessionManager();
  late ATSaveUser newUser;
  late List<SavingsGoals> userGoals;
  late List<Expenses> expenses;
  late List<Category> categories;
  late List<SavingsTransactions> transactions;

  ///Handling what happens on each of the bloc events
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignInEvent>((event, emit) => _login(event, emit));
    on<SignUpEvent>((event, emit) => _signUp(event, emit));
    on<LogoutEvent>((event, emit) => _syncData(event, emit));
  }

  ///the[_login] function is called on event of [SignInEvent]
  ///it ensures all user data are fetched from the remote server and saved in local storage on login
  _login(SignInEvent event, emit) async {
    emit(AuthLoadingState());

    try {
      final userId = await authRepo.login(event.email, event.password);
      final data =
          await FirebaseDatabase.instance.ref().child('User/$userId').get();

      final datamap = data.value as Map<Object?, Object?>?;
      if (data.exists) {
        newUser = ATSaveUser.fromJson(datamap!);
        String displayName = '${newUser.firstName} ${newUser.lastName}';
        manager.saveUsername(newUser.firstName);
        final user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName(displayName);
        await user.reload();
        await authRepo.saveUserToDb(newUser);
        userGoals = await dbRepo.fSavingGoals(userId);
        categories = await dbRepo.fCategories();
        expenses = await dbRepo.fExpenses(userId);
        transactions = await dbRepo.fSavingTxns(userId);

        await dbRepo.updateExpenses(expenses, userId);
        await dbRepo.updateGoalsInLocalDB(userGoals);
        await dbRepo.updateTransactions(transactions);
        await dbRepo.updateCategories(categories);
      } else {
        await FirebaseDatabase.instance.ref().child('User/$userId').set({});
      }
      String deviceToken = await manager.retrieveMessagingToken();
      String username = await manager.getUsername();
      String title = 'Save today, spend comfortably later';
      String body =
          'Hi there, $username!. Let\'s get you started on your savings goals today';
      await dbRepo.sendNotification(deviceToken, title, body);
      emit(LoginSuccessState(
          user: newUser,
          availableGoals: userGoals,
          availableExpenses: expenses,
          availableCategories: categories,
          availableTransactions: transactions));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'auth error');
      emit(AuthErrorState(error: e.message.toString()));
    } on FirebaseException catch (e) {
      log(e.message.toString(), name: 'firebase error');
    }
  }

  ///the[_signUp] function is called on event of [SignUpEvent]
  _signUp(SignUpEvent event, emit) async {
    emit(AuthLoadingState());
    try {
      await authRepo.signUp(event.email, event.password, event.createdAt,
          event.firstName, event.lastName);
      manager.saveUsername(event.firstName);
      String deviceToken = await manager.retrieveMessagingToken();
      String username = await manager.getUsername();
      String title = 'WELCOME TO ATSave, \'$username\'';
      String body =
          'We know you want to ace your savings goals. Let\'s get you started on your saving journey today';
      await dbRepo.sendNotification(deviceToken, title, body);
      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  ///the[_syncData] function is called on event of [LogoutEvent]
  ///it ensures that the data of the user is effectively backedup on the firebase server as the user logs out
  _syncData(LogoutEvent event, emit) async {
    emit(AuthLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    try {
      final presentGoals = await dbRepo.iSavingsGoals();
      final incomingGoals = await dbRepo.fSavingGoals(event.uid);

      if (presentGoals != incomingGoals) {
        dbRepo.updateSavingsGoalsInServer(presentGoals, user!.uid);
      }
      final presentTransactions = await dbRepo.iSavingsTransactions();
      final incomingTransactions = await dbRepo.fSavingTxns(user!.uid);
      if (presentTransactions != incomingTransactions) {
        // dbRepo.updateSavingsTransactionsInServer(presentTransactions, user.uid);
      }
      final presentExpenses = await dbRepo.iExpenses();
      final incomingExpenses = await dbRepo.fExpenses(user.uid);

      if (presentExpenses != incomingExpenses) {
        await dbRepo.updateExpensesInServer(presentExpenses, user.uid);
      }
      await FirebaseAuth.instance.signOut();
      await dbRepo.closeDB();
      emit(LogoutSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
