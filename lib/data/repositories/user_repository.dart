import 'package:crud_sqlite_sqflite/data/db/dao/user_dao.dart';
import 'package:crud_sqlite_sqflite/data/models/user.dart';

class UserRepository {
  final userDao = UserDao();

  Future<List<User>> getUsers() => userDao.getUsers();

  Future<int> addUser({required User user}) => userDao.add(user);

  Future<int> removeUser({required int id}) => userDao.remove(id);

  Future<int> updateUser({required User user}) => userDao.update(user);
}
