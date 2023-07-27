import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/card_shape.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:easysave/view/widgets/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../controller/home/goal_details_controller.dart';

class SavingsGoalCard extends StatelessWidget {
  final SavingsGoals goal;

  const SavingsGoalCard({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(goal.endDate);
    double amountRemaining = goal.targetAmount - goal.currentAmount;
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GoalDetails(goal: goal)));
          },
          child: SizedBox(
            height: 180.h,
            child: Card(
                shape: CustomCardShape(),
                elevation: 2,
                child: Margin(
                  margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(goal.goalNotes!,
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
                              Text(
                                  '${goal.progressPercentage.toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: APPBAR_COLOR2,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const Text('Complete'),
                              addVerticalSpace(4.h),
                              Row(
                                children: [
                                  Text('\$$amountRemaining',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const Text(
                                    ' LEFT',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                              addVerticalSpace(4.h),
                              Text('Target Date: $formattedDate',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ]),
                      ),
                      //  addHorizontalSpace(16.h),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 32.h,
                            right: 16.w,
                          ),
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                addVerticalSpace(32.h),
                                SizedBox(
                                  width: 100.w,
                                  height: 70.h,
                                  child: CircularProgressBar(
                                      progressPercentage:
                                          goal.progressPercentage),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
