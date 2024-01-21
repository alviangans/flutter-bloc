import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:newscatalog/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<InitLogin>(_initLogin);
    on<ProsesLogin>(_prosesLogin);
    on<ProsesLogout>(_prosesLogout);
  }

  _initLogin(InitLogin event, Emitter<LoginState> emit) async {
    //nanti cehck session disini
    emit(LoginLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('session') ?? "";
    if (sessionToken == "") {
      emit(LoginInitial());
    } else {
      bool result = await loginRepository.checkSession(sessionToken);
      if (result == true) {
        emit(LoginSucces(sessionToken: sessionToken));
      } else {
        emit(LoginInitial());
      }
    }
  }

  _prosesLogout(ProsesLogout event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await loginRepository.logout();
    emit(LoginInitial());
  }

  _prosesLogin(ProsesLogin event, Emitter<LoginState> emit) async {
    log("MASUK BLOC PROSES LOGIN");
    String username = event.username;
    String password = event.password;
    log("EVENT USERNAME PASSWORD $password");
    emit(LoginLoading());
    log("MASUK LOADING");
    Map res =
        await loginRepository.login(username: username, password: password);
    log("CEK RES DARI BLOC $res");
    if (res['status'] == true) {
      emit(LoginSucces(sessionToken: res['data']['session_token']));
    } else {
      emit(LoginFailure(error: 'Login Failed: ${res['data']['message']}'));
    }
  }
}
