import 'package:easysave/manager/remote_db_manager.dart';
import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/repository/database_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../manager/local_db_manager.dart';

///this file contains a class that holds the declaration of functions
///this functions are used during the authentication of a user
class AuthenticationRepository {
  DatabaseRepository dbRepo = DatabaseRepository();

  Future<String> login(String email, String password) async {
    return await RemoteDbManager().login(email, password);  ///called on login
  }

  Future<String> logout(String email, String password) async {
    return await RemoteDbManager().logout(email, password); ///called on logout
  }

  Future<UserCredential> signUp(String email, String? password,
      String createdAt, String firstName, String lastName) async {
    return await RemoteDbManager()
        .signUp(email, password, createdAt, firstName, lastName); ///called on signup
  }

  saveUserToDb(ATSaveUser user) async {
    return await LocalDbManager().saveUser(user); ///saves a new user to isar
  }
}
