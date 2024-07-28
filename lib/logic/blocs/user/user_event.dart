import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends UserEvent {
  final UserModel user;
  final String password;

  RegisterUser({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  UpdateUser({required this.user});

  @override
  List<Object> get props => [user];
}

class LoadUser extends UserEvent {
  final String userId;

  LoadUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LogoutUser extends UserEvent {}