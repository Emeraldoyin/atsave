part of 'add_savings_goal_bloc.dart';

abstract class AddSavingsGoalState extends Equatable {
  const AddSavingsGoalState();
  
  @override
  List<Object> get props => [];
}

class AddSavingsGoalBlocInitial extends AddSavingsGoalState {}
