import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavingsGoalCard extends StatelessWidget {
  final String? goalName;
  final double goalAmount;
  final DateTime completionDate;

  const SavingsGoalCard({
    super.key,
    required this.goalName,
    required this.goalAmount,
    required this.completionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goalName!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Savings Goal Amount: \$${goalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completion Date: ${DateFormat('MMM dd, yyyy').format(completionDate)}',
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
