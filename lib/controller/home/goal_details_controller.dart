import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/view/pages/goal_details_page.dart';
import 'package:flutter/material.dart';

class GoalDetails extends StatefulWidget {
  //static const routeName = Strings.SCREEN_GoalDetails;
  final SavingsGoals goal;
  const GoalDetails({Key? key, required this.goal}) : super(key: key);

  @override
  GoalDetailsController createState() => GoalDetailsController();
}

class GoalDetailsController extends State<GoalDetails> {
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
  Widget build(BuildContext context) => GoalDetailsPage(this, widget.goal);
}
