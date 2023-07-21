part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}



class RetrieveDataEvent extends ConnectivityEvent {
  final String uid;
  const RetrieveDataEvent({required this.uid});

  @override
  List<Object> get props => [uid];
}
