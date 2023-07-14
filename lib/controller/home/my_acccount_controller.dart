import 'package:flutter/material.dart';

import 'home_controller.dart';

class MyAccount extends StatefulWidget {
  //static const routeName = Strings.SCREEN_BLANK;

  const MyAccount({Key? key}) : super(key: key);

  @override
  MyAccountController createState() => MyAccountController();
}

class MyAccountController extends State<MyAccount> {
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
