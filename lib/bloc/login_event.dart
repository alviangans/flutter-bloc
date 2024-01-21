part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class InitLogin extends LoginEvent {

  @override
  List<Object> get props => [];
}

class ProsesLogin extends LoginEvent {
  final String username;
  final String password;
  ProsesLogin({this.username = "", this.password = ""});

  @override
  List<Object> get props => [username, password];
}

class ProsesLogout extends LoginEvent {

  @override
  List<Object> get props => [];
}
