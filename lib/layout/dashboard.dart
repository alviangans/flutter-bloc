// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String sessionToken;

  const WelcomeScreen({required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!'),
            Text('Session Token: $sessionToken'),
            ElevatedButton(
              onPressed: () {
                //dispatch logout event to Bloc
                context.read<LoginBloc>().add(ProsesLogout());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
