part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class AddSavingsGoalsEvent extends DatabaseEvent {
  final SavingsGoals goal;

  const AddSavingsGoalsEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}


class SaveTransactionEvent extends DatabaseEvent {
  final SavingsTransactions txn;

  const SaveTransactionEvent({required this.txn});

  @override
  List<Object> get props => [txn];
}

class EditGoalsEvent extends DatabaseEvent {
  final SavingsGoals goal;
  final SavingsTransactions txn;

  const EditGoalsEvent({required this.goal, required this.txn});

  @override
  List<Object> get props => [goal, txn];
}

class SpendFromSavingsEvent extends DatabaseEvent {
  final SavingsGoals goal;
  final SavingsTransactions txn;
  final Expenses exp;

  const SpendFromSavingsEvent(
      {required this.goal, required this.txn, required this.exp});

  @override
  List<Object> get props => [goal, txn, exp];
}
