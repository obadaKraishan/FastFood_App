import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User? user;

  AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user!];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {}
