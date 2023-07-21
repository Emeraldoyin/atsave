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
  final List<SavingsGoals> availableGoals;

  const LoginSuccessState({required this.user, required this.availableGoals});

  @override
  List<Object> get props => [];
}

class LogoutSuccessState extends AuthenticationState {

}

class SignupSuccessState extends AuthenticationState {}
