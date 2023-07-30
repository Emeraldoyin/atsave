import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/controller/home/goal_details_controller.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../consts/app_colors.dart';
import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';
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
      body: MyGoals(
          username: controller.username,
          controller: controller,
          allGoals: controller.allGoals),
    );
  }
}

class MyGoals extends StatelessWidget {
  const MyGoals(
      {super.key,
      required this.username,
      required this.controller,
      required this.allGoals});

  final String? username;
  final HomePageController controller;
  final List<SavingsGoals?> allGoals;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState && state.availableSavingsGoals.isEmpty) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Margin(
                margin: EdgeInsets.all(8.r),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MajorCard(
                        controller: controller,
                        username: username,
                        actionWord: 'You do not have any savings goals yet.',
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(image2),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        if (state is DbSuccessState && state.availableSavingsGoals.isNotEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: 380.w,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 10, spreadRadius: 1)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [APPBAR_COLOR1, BACKGROUND_COLOR1])),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.w,
                              padding: EdgeInsets.only(left: 8.h),
                              child: Column(
                                children: [
                                  addVerticalSpace(8.h),
                                  Text(
                                    'Hi, $username',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  addVerticalSpace(8.h),
                                  Text('Total Savings Goals:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text(
                                      '\$${controller.getTotalTargetAmount(state.availableSavingsGoals)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                  Text('Already Saved:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text(
                                      '\$${controller.getAlreadySaved(state.availableSavingsGoals)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                  Text(
                                    '${controller.getProgressMade(state.availableSavingsGoals)}% progress made',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            ),
                            addHorizontalSpace(8.w),
                            Expanded(
                              child: SizedBox(
                                height: 130.h,
                                // width: 120.w,
                                child: SfCircularChart(
                                  margin:
                                      EdgeInsets.only(bottom: 4.w, top: 4.h),
                                  legend: const Legend(
                                      isVisible: true,
                                      height: '12%',
                                      position: LegendPosition.top),
                                  series: <PieSeries<PieData, String>>[
                                    PieSeries<PieData, String>(
                                      dataSource: controller.getPieData(),
                                      xValueMapper: (PieData data, _) =>
                                          data.category,
                                      yValueMapper: (PieData data, _) =>
                                          data.value,
                                      // Display data labels outside the pie chart
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        (controller.alreadySaved * 100) /
                                        controller.totalAmount >
                                    50 &&
                                (controller.alreadySaved * 100) /
                                        controller.totalAmount !=
                                    100
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Great job! You are beyond halfway there already!',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                            // )
                            : (controller.alreadySaved * 100) /
                                        controller.totalAmount ==
                                    100
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Amazing Work, ${controller.username}! You aced all your goals!',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Let\'s get you closer to your target, ${controller.username}.',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Goals',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(APPBAR_COLOR1),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      onPressed: () {
                        controller.gotoAdd();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            size: 15,
                          ),
                          Text(
                            'ADD GOAL',
                            style: Theme.of(context).textTheme.bodySmall,
                            selectionColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                addVerticalSpace(8.h),
                ListView.builder(
                  itemCount: state.availableSavingsGoals.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final goal = state.availableSavingsGoals[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoalDetails(
                                    goal: goal,
                                    categories: state.availableCategories)));
                      },
                      child: SavingsGoalCard(
                          goal: goal, categories: state.availableCategories),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image23),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}

class PieData {
  final String category;
  final double value;

  PieData(this.category, this.value);
}
