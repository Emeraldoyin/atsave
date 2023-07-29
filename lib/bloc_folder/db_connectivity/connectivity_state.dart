part of 'connectivity_bloc.dart';

///the classes that represent the possible states to be emitted on connectivity bloc events
abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class DbLoadingState extends ConnectivityState {}

class DbSuccessState extends ConnectivityState {
   List<Expenses>? availableExpenses;
  final List<SavingsGoals> availableSavingsGoals;
  final List<Category> availableCategories;
  //final List<SavingsGoals>? pinnedGoals;
  List<SavingsTransactions>? availableSavingsTransactions;

  DbSuccessState({
    this.availableSavingsTransactions,
    required this.availableSavingsGoals,
    required this.availableCategories,
    // this.pinnedGoals
    this.availableExpenses,
  });

  @override
  List<Object> get props => [
        availableSavingsGoals,
        availableCategories,
        availableSavingsTransactions!
      ];
}

class DbErrorState extends ConnectivityState {
  final String error;

  const DbErrorState({
    required this.error,
  });
}
