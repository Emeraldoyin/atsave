import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_savings_goal_event.dart';
part 'add_savings_goal_state.dart';

class AddSavingsGoalBlocBloc extends Bloc<AddSavingsGoalEvent, AddSavingsGoalState> {
  AddSavingsGoalBlocBloc() : super(AddSavingsGoalBlocInitial()) {
    on<AddSavingsGoalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
