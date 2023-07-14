part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthLoadingState extends AuthenticationState {}

class AuthErrorState extends AuthenticationState {
  final String error;

  const AuthErrorState({
    required this.error,
  });
}

class LoginSuccessState extends AuthenticationState {
  final ATSaveUser user;

  const LoginSuccessState({required this.user});

  @override
  List<Object> get props => [];
}

class LogoutSuccessState extends AuthenticationState {
  final String uid;

  const LogoutSuccessState({required this.uid});

  @override
  List<Object> get props => [];
}

class SignupSuccessState extends AuthenticationState {}
