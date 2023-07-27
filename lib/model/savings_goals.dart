import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'savings_goals.g.dart';

@collection
@JsonSerializable()
class SavingsGoals {
  Id? id;
  final String uid;
  final double targetAmount;
  String? goalNotes;
  final int categoryId;
 double currentAmount;
  final DateTime endDate;
 double progressPercentage;

  SavingsGoals(
      {this.id,
      required this.uid,
      required this.targetAmount,
      this.goalNotes,
      required this.categoryId,
      required this.currentAmount,
      required this.endDate,
      required this.progressPercentage});

  factory SavingsGoals.fromJson(Map<Object?, Object?> json) =>
      _$SavingsGoalsFromJson(json);

  /// Connect the generated [_$SavingsGoalsToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$SavingsGoalsToJson(this);

  @override
  String toString() {
    return 'SavingsGoals{uid: $uid, targetAmount: $targetAmount, goalNotes: $goalNotes, categoryId: $categoryId, startAmount: $currentAmount, progressPercentage: $progressPercentage, endDate: $endDate}';
  }
}
