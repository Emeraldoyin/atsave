import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:flutter/material.dart';

import '../../controller/home/goal_details_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';


class GoalDetailsPage extends StatelessView<GoalDetails, GoalDetailsController> {
  const GoalDetailsPage(GoalDetailsController controller, SavingsGoals goal, {Key? key}) : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: body(context)
        );
  }
  Widget body(context) {
    return const SizedBox();
  }
}
 