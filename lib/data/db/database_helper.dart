import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';

final userTABLE = "users";
final userDatabase = "users.db";

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();
  static final DatabaseHelper dbHelper = DatabaseHelper();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db
        .execute('''CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)''');
  }
}
