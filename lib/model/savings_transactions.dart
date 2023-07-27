import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'savings_transactions.g.dart';

@collection
@JsonSerializable()
class SavingsTransactions {
  Id? id;
  final String uid;
  final DateTime timeStamp;
  final int savingsId;
  double? amountSaved;
  double? amountExpended;

  SavingsTransactions({

        required this.savingsId,
      required this.amountExpended,
      this.amountSaved,
      required this.timeStamp,
      required this.uid});

  factory SavingsTransactions.fromJson(Map<Object?, Object?> json) =>
      _$SavingsTransactionsFromJson(json);

  /// Connect the generated [_$SavingsTransactionsToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$SavingsTransactionsToJson(this);
}
