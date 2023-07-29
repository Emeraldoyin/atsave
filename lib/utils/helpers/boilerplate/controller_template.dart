import 'package:flutter/material.dart';

import 'view_template.dart';

///a template for controllers
class Blank extends StatefulWidget {
  const Blank({Key? key}) : super(key: key);

  @override
  BlankController createState() => BlankController();
}

class BlankController extends State<Blank> {
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
  Widget build(BuildContext context) => BlankView(this);
}
