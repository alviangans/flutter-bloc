import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import 'login.dart';
import 'loading.dart';
import 'dashboard.dart';
import 'error_message.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return LoginForm();
        } else if (state is LoginLoading) {
          return LoadingIndicator();
        } else if (state is LoginSucces) {
          return WelcomeScreen(sessionToken: state.sessionToken);
        } else if (state is LoginFailure) {
          return ErrorMessage(message: state.error);
        }
        return Container();
      },
    );
  }
}
