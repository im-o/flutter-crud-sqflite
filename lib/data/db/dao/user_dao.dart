import 'package:crud_sqlite_sqflite/data/db/database_helper.dart';
import 'package:crud_sqlite_sqflite/data/models/user.dart';

class UserDao {
  final dbHelper = DatabaseHelper.dbHelper;

  Future<List<User>> getUsers() async {
    final db = await dbHelper.database;
    var users = await db.query('users', orderBy: 'name');
    List<User> userList =
        users.isNotEmpty ? users.map((e) => User.fromMap(e)).toList() : [];
    return userList;
  }

  Future<int> add(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<int> remove(int id) async {
    final db = await dbHelper.database;
    return await db.delete("users", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    final db = await dbHelper.database;
    return await db.update(
      "users",
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
