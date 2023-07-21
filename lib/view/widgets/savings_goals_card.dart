import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../controller/home/goal_details_controller.dart';

class SavingsGoalCard extends StatelessWidget {
  final SavingsGoals goal;

  const SavingsGoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(goal.endDate);
    double val = goal.progressPercentage / 100;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(goal.goalNotes!,
                    style: Theme.of(context).textTheme.displayMedium),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoalDetails(goal: goal)));
                    },
                    child: const Text('view'))
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200.w,
              height: 8.h,
              child: LinearProgressIndicator(
                value: val,
                backgroundColor: APPBAR_COLOR1,
                color: APPBAR_COLOR2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Savings Goal Amount: \$${goal.targetAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Proposed Completion Date: $formattedDate',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
