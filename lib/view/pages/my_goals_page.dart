import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../widgets/combined_progress_chart.dart';
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
    return Scaffold(
      body: myGoals(
          username: controller.user!.displayName,
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
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState) {
          List<SavingsGoals> goals = state.availableSavingsGoals;
          List<double> progressPercentages =
              goals.map((goal) => goal.progressPercentage).toList();
          List<double> targetAmounts =
              goals.map((goal) => goal.targetAmount.toDouble()).toList();
List<ChartData> chartData = List.generate(goals.length, (index) {
  return ChartData(
    targetAmounts[index],
    progressPercentages[index],
    goals[index].goalNotes!, // Include goalNotes in the ChartData object
  );
});
       
          return SingleChildScrollView(
              child: SafeArea(
            child: goals.isNotEmpty
                ? Column(children: [
                    addVerticalSpace(8.h),
                    const Text('Total Savings Goals Progress'),
                    CombinedProgressChart(
                      chartData: chartData,
                    ),
                    SizedBox(
                      height: 650.h,
                      width: 350.w,
                      child: ListView.builder(
                        itemCount: goals.length,
                        itemBuilder: (context, index) {
                          final goal = goals[index];
                          return SavingsGoalCard(
                            goal: goal,
                          );
                        },
                      ),
                    ),
                  ])
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: majorCard(
                          controller: controller,
                          username: username,
                        ),
                      ),
                      SizedBox(
                        child: Image.asset('assets/images/onboard_img2.png'),
                      )
                    ],
                  ),
          ));
        }
        return Container();
      },
    );
  }
}
