import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/home/home_controller.dart';
import '../../model/category.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/comma_formatter.dart';
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
          username: controller.user!.displayName,
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
        if (State is DbLoadingState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 100.h),
                child: Image.asset('assets/images/Piggy bank with coins.png'),
              ),
              const CircularProgressIndicator(),
            ],
          );
        }
        if (state is DbSuccessState &&
            state.availableCategories.isNotEmpty |
                state.availableSavingsGoals.isNotEmpty) {
          String user = controller.user!.displayName!;
          List<SavingsGoals> goals = state.availableSavingsGoals;
          List<Category> categories = state.availableCategories;
          List<double> targetAmounts =
              goals.map((goal) => goal.targetAmount.toDouble()).toList();
          List<double> currentAmounts =
              goals.map((goal) => goal.currentAmount.toDouble()).toList();
          List<double> progressPercentages =
              goals.map((goal) => goal.progressPercentage).toList();
          double totalProgressSum =
              progressPercentages.reduce((value, element) => value + element);
          double totalProgress =
              totalProgressSum / (progressPercentages.length * 100) * 100;
          //log(totalProgress.toString(), name: 'tp');
          double totalCurrentAmount =
              currentAmounts.reduce((value, element) => value + element);
          double totalTarget =
              targetAmounts.reduce((value, element) => value + element);
          double totalSaved = totalCurrentAmount;
          List<DropdownMenuItem<String>> dropdownItems =
              categoryList.map((category) {
            return DropdownMenuItem<String>(
              value: category.name,
              child: Text(category.name),
            );
          }).toList();
          List<PieData> getPieData() {
            double remainingAmount = totalTarget - totalSaved;
            return [
              PieData('Already Saved', totalSaved),
              PieData('Remaining', remainingAmount),
            ];
          }

          List<PieData> data = getPieData();

          return SingleChildScrollView(
              child: SafeArea(
                  child: Margin(
            margin: EdgeInsets.all(16.r),
            child: Column(children: [
              addVerticalSpace(32.h),
              SizedBox(
                  width: 70.w,
                  child: const ChoiceChip(
                      label: Text('All Goals'), selected: false)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 150.h,
                            padding: EdgeInsets.only(left: 8.h),
                            child: Column(
                              children: [
                                addVerticalSpace(8.h),
                                Text(
                                  'Hi, $user',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                addVerticalSpace(8.h),
                                Text('Total Savings Goals:',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('\$${formatDoubleWithComma(totalTarget)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                                Text('Already Saved:',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text('\$${formatDoubleWithComma(totalSaved)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                                Text(
                                  '${totalProgress.toStringAsFixed(0)}% progress made',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )
                              ],
                            ),
                          ),
                          addHorizontalSpace(8.w),
                          Expanded(
                            child: SizedBox(
                              height: 150.h,
                              // width: 120.w,
                              child: SfCircularChart(
                                margin: EdgeInsets.only(bottom: 4.w, top: 4.h),
                                legend: const Legend(
                                    isVisible: true,
                                    height: '12%',
                                    position: LegendPosition.top),
                                series: <PieSeries<PieData, String>>[
                                  PieSeries<PieData, String>(
                                    dataSource: data,
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
                      (totalSaved * 100) / totalTarget > 50 &&
                              (totalSaved * 100) / totalTarget != 100
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Great job! You are beyond halfway there already!',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          // )
                          : (totalSaved * 100) / totalTarget == 100
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Amazing Work, $user! You aced all your savings goals!',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Let\'s get you closer to your target, $user. You can do this!',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                      //  addVerticalSpace(4.h)
                    ],
                  )),
              addVerticalSpace(32.h),
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
                        foregroundColor: MaterialStatePropertyAll(Colors.grey)),
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
                          selectionColor: APPBAR_COLOR1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              addVerticalSpace(16.h),
              ListView.builder(
                itemCount: goals.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return SavingsGoalCard(goal: goal, categories: categories);
                },
              ),
            ]),
          )));
        } else if (state is DbSuccessState &&
            state.availableCategories.isEmpty ==
                true | state.availableSavingsGoals.isEmpty) {
          SingleChildScrollView(
            child: SafeArea(
              child: Margin(
                margin: EdgeInsets.all(8.r),
                child: Column(
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
              ),
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Piggy bank with coins.png'),
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
