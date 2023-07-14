import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@collection
@JsonSerializable()
class Transaction {
  Id? id;
  final String uid;
  final DateTime timeStamp;
  final int savingsId;
  double? amountSaved;
  double? amountExpended;

  Transaction(
      {required this.savingsId,
      required this.amountExpended,
      required this.amountSaved,
      required this.timeStamp,
      required this.uid});

  factory Transaction.fromJson(Map<Object?, Object?> json) =>
      _$TransactionFromJson(json);

  /// Connect the generated [_$TransactionToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$TransactionToJson(this);
}
