import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOut extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;

  AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}
