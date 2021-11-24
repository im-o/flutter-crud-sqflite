part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded({required this.users});
}

class UserViewUpdated extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}

class UserAdded extends UserState {}
