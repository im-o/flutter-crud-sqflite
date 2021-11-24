import 'package:crud_sqlite_sqflite/themes/app_theme.dart';
import 'package:crud_sqlite_sqflite/views/page_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';
import 'data/repositories/user_repository.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.repository}) : super(key: key);
  final UserRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => UserCubit(repository),
        child: PageHome(),
      ),
    );
  }
}
