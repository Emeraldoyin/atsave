import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/card_shape.dart';
import 'package:easysave/utils/helpers/date_diff_calculator.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:easysave/view/widgets/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../model/category.dart';
import '../../utils/helpers/comma_formatter.dart';

class SavingsGoalCard extends StatelessWidget {
  final SavingsGoals goal;
  final List<Category> categories;

  const SavingsGoalCard({
    super.key,
    required this.goal,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    int daysLeft = calculateDaysLeft(goal.endDate);
    String formattedDate = DateFormat('MMM d, yyyy').format(goal.endDate);
    double amountRemaining = goal.targetAmount - goal.currentAmount;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: SizedBox(
        height: 170.h,
        width: 350.w,
        child: Card(
            shape: CustomCardShape(),
            elevation: 2,
            child: Margin(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(goal.goalNotes!,
                              style: Theme.of(context).textTheme.displayLarge),
                        ),
                        Positioned(
                          top: 20,
                          child: Text(
                              '${goal.progressPercentage.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: APPBAR_COLOR2,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const Positioned(top: 70, child: Text('Complete')),
                        Positioned(
                          top: 90,
                          child: Row(
                            children: [
                              Text(
                                  '\$${formatDoubleWithComma(amountRemaining)}',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const Text(
                                ' LEFT',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 29, 81, 124)),
                              )
                            ],
                          ),
                        ),
                        addVerticalSpace(4.h),
                        Positioned(
                          top: 120,
                          child: Text('Target Date: $formattedDate',
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ]),
                    ),
                  ),
                  //  addHorizontalSpace(16.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        right: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40.w, top: 0),
                            child: Text(
                              '${daysLeft.toString()} days left',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          addVerticalSpace(12.h),
                          CircularProgressBar(
                              progressPercentage: goal.progressPercentage),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
