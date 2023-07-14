part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleEvent extends AuthenticationEvent {
  

  const SignInWithGoogleEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  String? uid;
  final String createdAt;
  SignUpEvent({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.uid,
    required this.password,
    required this.createdAt,
  });

  @override
  List<Object> get props => [email, firstName, lastName, createdAt];
}
