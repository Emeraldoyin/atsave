import 'package:easysave/controller/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/helpers/session_manager.dart';

class MyGoals extends StatefulWidget {
  const MyGoals({Key? key}) : super(key: key);

  @override
  MyGoalsController createState() => MyGoalsController();
}

class MyGoalsController extends State<MyGoals> {
  //... //Initialization code, state vars etc, all go here
  final user = FirebaseAuth.instance.currentUser;
  String? username;

//dont firget to change this shared preference
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SessionManager manager = SessionManager();
      manager.hasUserAddedGoal(false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? getUsername() {
    username = user!.displayName;
    return username;
  }

  //List<Expenses> getExpenses() {
  final List expenses = [];
  // final List<Expenses> expenses =
  //  [
  //   Expenses(amountSpent: 20000, date: 'August', color: Colors.blue),
  //   Expenses(amountSpent: 20000, date: 'September', amountSp, savingsId: null),
  //   Expenses(amountSpent: 10, date: 'May', color: Colors.orange),
  //   Expenses(amountSpent: 20000, date: 'June', color: Colors.green),
  //   Expenses(amountSpent: 20000, date: 'January', color: Colors.yellow),
  // ];
  // return expenses;
  //}

  @override
  Widget build(BuildContext context) => const Home();
}
