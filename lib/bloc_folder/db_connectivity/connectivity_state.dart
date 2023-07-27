part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class DbLoadingState extends ConnectivityState {}

class DbSuccessState extends ConnectivityState {
  // final List<Expenses> availableExpenses;
  final List<SavingsGoals> availableSavingsGoals;
  final List<Category> availableCategories;
  //final List<SavingsGoals>? pinnedGoals;
  // final List<SavingsTransactions> availableSavingsTransactions;

  const DbSuccessState(
      {
      //required this.availableSavingsTransactions,
      required this.availableSavingsGoals,
      required this.availableCategories,
     // this.pinnedGoals
      //required this.availableExpenses,
      });

  @override
  List<Object> get props => [availableSavingsGoals, availableCategories];
}

class DbErrorState extends ConnectivityState {
  final String error;

  const DbErrorState({
    required this.error,
  });
}
