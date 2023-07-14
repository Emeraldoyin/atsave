import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/savings_goals.dart';
import '/repository/database_repository.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  DatabaseRepository dbRepo = DatabaseRepository();
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<RetrieveDataEvent>((event, emit) {
      return _retrieveData(event, emit);
    });
  }

  _retrieveData(
      RetrieveDataEvent event, Emitter<ConnectivityState> emit) async {
    emit(DbLoadingState());
    final present = await dbRepo.iSavingsGoals();
    final incoming = await dbRepo.fSavingGoals();
    if (present != incoming) {
      await dbRepo.updateSavingsGoals(present);
    }
     emit(DbSuccessState(
      availableSavingsGoals: present
    ));
  }
    // final quizQuestions = await dbRepo.getAllQuizQuestions();

    // final presentLessons = await dbRepo.iLessons();
    // final incomingLessons = await dbRepo.fLessons();

    // if (presentLessons != incomingLessons) {
    //   await dbRepo.updateLessons(incomingLessons);
    // }
    // final presentTopics = await dbRepo.iTopics();

    // final incomingTopics = await dbRepo.fTopics();

    // if (presentTopics != incomingTopics) {
    //   await dbRepo.updateTopics(incomingTopics);
    // }

    // final incomingLeaderBoardEntries = await dbRepo.fEntries();
    // final presentLeaderBoardEntries = await dbRepo.iEntries();

    // if (presentLeaderBoardEntries != incomingLeaderBoardEntries) {
    //   await dbRepo.updateLeaderBoardEntries(incomingLeaderBoardEntries);
    // }

  //   var allSelectedLessons = await dbRepo.getAllSelectedLessons();

  //   await RemoteDbManager().saveAllSelectedLessons(allSelectedLessons);

  //   //  final presentUser = await dbRepo.getCurrentUser(event.user);

  //   if (presentTopics != incomingTopics) {
  //     await dbRepo.updateTopics(incomingTopics);
  //   }
   
}
