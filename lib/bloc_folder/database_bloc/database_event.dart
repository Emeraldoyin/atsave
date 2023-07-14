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