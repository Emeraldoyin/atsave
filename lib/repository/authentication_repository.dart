
import 'package:easysave/model/atsave_user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


import '../manager/local_db_manager.dart';

class AuthenticationRepository {
  Future<String> login(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  // Future<User?> signInWithGoogle() async =>
  //     RemoteDbManager().googlesignIn();

  Future<UserCredential> signUp(String email, String? password,
      String createdAt, String firstName, String lastName) async {
    final UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password!);
    final databaseReference = FirebaseDatabase.instance.ref();
    // await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    await databaseReference.child('User').child(credential.user!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "uid": credential.user!.uid,
      'createdAt': DateTime.now().toIso8601String(),
    });
    return credential;
  }

  saveUserToDb(ATSaveUser user) async {
    return await LocalDbManager().saveUser(user);
  }
}
