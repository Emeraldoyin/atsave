import 'package:flutter/material.dart';

///the major class used by other screens to implement their controller 
abstract class StatelessView<T1, T2> extends StatelessWidget {
  final T2 controller;

  T1 get widget => (controller as State).widget as T1;

  const StatelessView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}