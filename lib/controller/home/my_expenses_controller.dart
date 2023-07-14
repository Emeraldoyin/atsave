import 'package:easysave/controller/home/home_controller.dart';
import 'package:flutter/material.dart';

class MyExpenses extends StatefulWidget {
  //static const routeName = Strings.SCREEN_BLANK;

  const MyExpenses({Key? key}) : super(key: key);

  @override
  MyExpensesController createState() => MyExpensesController();
}

class MyExpensesController extends State<MyExpenses> {
  //... //Initialization code, state vars etc, all go here

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Home();
}
