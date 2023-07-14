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
  List<Object> get props => [];
}

class ErrorState extends DatabaseState {
  final String error;

  const ErrorState({
    required this.error,
  });
}
