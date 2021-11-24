import 'package:crud_sqlite_sqflite/app.dart';
import 'package:flutter/material.dart';

import 'data/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(repository: UserRepository()));
}
