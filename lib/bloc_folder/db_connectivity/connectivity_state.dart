part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class DbLoadingState extends ConnectivityState {}

class DbSuccessState extends ConnectivityState {
  final List<Expenses> availableExpenses;
  final List<SavingsGoals> availableSavingsGoals;
  final List<SavingsTransactions> availableSavingsTransactions;
  //final List<LeaderBoardEntry> availableEntries;
  // final List<Quiz> quizQuestions;

 const DbSuccessState({
    required this.availableSavingsTransactions,
    required this.availableSavingsGoals,
   required this.availableExpenses,
    //required this.availableEntries,
    //required this.quizQuestions,
  });

  @override
  List<Object> get props => [availableSavingsGoals, availableExpenses, availableSavingsTransactions];
}

class DbErrorState extends ConnectivityState {
  final String error;

  const DbErrorState({
    required this.error,
  });
}
