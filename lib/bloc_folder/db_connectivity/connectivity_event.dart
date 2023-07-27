part of 'connectivity_bloc.dart';

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

class EditGoalsEvent extends ConnectivityEvent {
  final SavingsGoals goal;
  //final SavingsTransactions txn;

  const EditGoalsEvent({required this.goal});

  @override
  List<Object> get props => [goal,];
}