part of 'connectivity_bloc.dart';

///the classes that represents events in the connectivity bloc
abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class DeleteSavingsGoalsEvent extends ConnectivityEvent {
  final SavingsGoals goal;

  const DeleteSavingsGoalsEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}

class WithdrawEvent extends ConnectivityEvent {
  final SavingsGoals goal;
  final Expenses expense;
  final SavingsTransactions txn;

  const WithdrawEvent({required this.goal, required this.expense, required this.txn});

  @override
  List<Object> get props => [goal, expense, txn];
}

class PinSavingsGoalEvent extends ConnectivityEvent {
  final SavingsGoals goal;

  const PinSavingsGoalEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}

class RetrieveDataEvent extends ConnectivityEvent {
  final String uid;
  const RetrieveDataEvent({required this.uid});

  @override
  List<Object> get props => [uid];
}

class UpdateCurrentAmountEvent extends ConnectivityEvent {
  final SavingsGoals goal;
  final double addedAmount;
  //final SavingsTransactions txn;

  const UpdateCurrentAmountEvent(
      {required this.goal, required this.addedAmount});

  @override
  List<Object> get props => [goal, addedAmount];
}

class EditGoalEvent extends ConnectivityEvent {
  final SavingsGoals goal;
  final SavingsTransactions txn;

  const EditGoalEvent({required this.goal, required this.txn});

  @override
  List<Object> get props => [goal, txn];
}
