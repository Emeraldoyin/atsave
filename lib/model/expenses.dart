
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expenses.g.dart';

@collection
@JsonSerializable()
class Expenses {
  Id? id;
  final String date;
  final double amountSpent;
  final int savingsId;
  final String uid;

  Expenses(
      {
        required this.amountSpent, required this.date, required this.savingsId, required this.uid});

  factory Expenses.fromJson(Map<Object?, Object?> json) =>
      _$ExpensesFromJson(json);

  /// Connect the generated [_$ExpensesToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$ExpensesToJson(this);
}
