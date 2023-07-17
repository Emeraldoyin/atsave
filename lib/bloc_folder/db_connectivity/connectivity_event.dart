part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class SyncDataEvent extends ConnectivityEvent {
   final String uid;
  const SyncDataEvent({required this.uid});

  @override
  List<Object> get props => [uid];
}

class RetrieveDataEvent extends ConnectivityEvent {
  final String uid;
  const RetrieveDataEvent({required this.uid});

  @override
  List<Object> get props => [uid];
}
