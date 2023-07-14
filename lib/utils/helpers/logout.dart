import 'package:easysave/controller/signin/signin_controller.dart';
import 'package:easysave/utils/helpers/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../repository/database_repository.dart';
import '../../view/widgets/show_snackbar.dart';

onLogout(context) {
  
  DatabaseRepository dbRepo = DatabaseRepository();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    SessionManager manager = SessionManager();
    try {

      await FirebaseAuth.instance.signOut();
    } catch (e) {
      showSnackBar(
        context,
        'Error signing out. Try again.', Colors.red
      );
    }
    manager.loggedIn(false);
    dbRepo.closeDb();
  });
  Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) => const SignIn()));
}
