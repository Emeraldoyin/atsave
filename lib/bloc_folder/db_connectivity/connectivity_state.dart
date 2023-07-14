part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class DbLoadingState extends ConnectivityState {}

class DbSuccessState extends ConnectivityState {
  //final List<Category> availableCategories;
  final List<SavingsGoals> availableSavingsGoals;
  //final List<Topic> availableTopics;
  //final List<LeaderBoardEntry> availableEntries;
  // final List<Quiz> quizQuestions;

 const DbSuccessState({
    //required this.availableCategories,
    required this.availableSavingsGoals,
    // required this.availableTopics,
    //required this.availableEntries,
    //required this.quizQuestions,
  });

  @override
  List<Object> get props => [availableSavingsGoals];
}

class DbErrorState extends ConnectivityState {
  final String error;

  const DbErrorState({
    required this.error,
  });
}
