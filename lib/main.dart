import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newscatalog/repository/login_repository.dart';

import 'bloc/login_bloc.dart';

import 'layout/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginBloc(loginRepository: context.read<LoginRepository>())
                  ..add(InitLogin()),
          ),
        ],
        child: MaterialApp(home: HomePage()),
      ),
    );
  }
}
