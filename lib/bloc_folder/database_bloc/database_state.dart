part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoadingState extends DatabaseState {}

class SavingsGoalAddedState extends DatabaseState {
  final SavingsGoals goal;
  const SavingsGoalAddedState({required this.goal});

  @override
  List<Object> get props => [goal];
}

class SavingsGoalDeletedState extends DatabaseState {
 final List<SavingsGoals> goals;
  const SavingsGoalDeletedState({required this.goals});

  @override
  List<Object> get props => [goals];
}

class SaveTransactionsSuccessState extends DatabaseState {
   final SavingsTransactions txn;
  

  const SaveTransactionsSuccessState({required this.txn});

  @override
  List<Object> get props => [txn];
}
 


class SpendFromSavingsState extends DatabaseState {
  final SavingsGoals goal;
  final SavingsTransactions txn;
  final Expenses exp;

  const SpendFromSavingsState(
      {required this.goal, required this.txn, required this.exp});

  @override
  List<Object> get props => [];
}

class EditSavingsGoalState extends DatabaseState {
  final SavingsGoals goal;
  final SavingsTransactions txn;

  const EditSavingsGoalState({required this.goal, required this.txn});

  @override
  List<Object> get props => [];
}

class ErrorState extends DatabaseState {
  final String error;

  const ErrorState({
    required this.error,
  });
}
