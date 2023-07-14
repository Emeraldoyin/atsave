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
  final double startAmount;
  final DateTime endDate;
  final double progressPercentage;

  SavingsGoals(
      {required this.uid,
      required this.targetAmount,
      this.goalNotes,
      required this.categoryId,
      required this.startAmount,
      required this.endDate,
      required this.progressPercentage});

  factory SavingsGoals.fromJson(Map<Object?, Object?> json) =>
      _$SavingsGoalsFromJson(json);

  /// Connect the generated [_$SavingsGoalsToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$SavingsGoalsToJson(this);
}