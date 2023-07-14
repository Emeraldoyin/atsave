import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../widgets/major_card.dart';
import '../widgets/savings_goals_card.dart';

class MyGoalsPage extends StatelessView<Home, HomePageController> {
  const MyGoalsPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: body(context));
  }

  Widget body(context) {
    String? username = controller.getUsername();
    return Scaffold(
      body: myGoals(
          username: username,
          controller: controller,
          allGoals: controller.allGoals),
    );
  }
}

class myGoals extends StatelessWidget {
  myGoals(
      {super.key,
      required this.username,
      required this.controller,
      required this.allGoals});

  final String? username;
  final HomePageController controller;
  List<SavingsGoals?> allGoals;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: controller.allGoals.isNotEmpty
          ? SizedBox(
              height: 250.h,
              width: 130.w,
              child: ListView.builder(
                itemCount: controller.allGoals.length,
                itemBuilder: (context, index) {
                  final goal = controller.allGoals[index];
                  return SavingsGoalCard(
                    goalName: goal.goalNotes,
                    goalAmount: goal.targetAmount,
                    completionDate: goal.endDate.toIso8601String(),
                  );
                },
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: majorCard(username: username, controller: controller),
                ),
                SizedBox(
                  child: Image.asset('assets/images/onboard_img2.png'),
                )
              ],
            ),
    ));
  }
}
