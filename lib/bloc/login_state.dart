part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucces extends LoginState {
  final String sessionToken;
  LoginSucces({required this.sessionToken});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
