import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUser extends UserEvent {
  final UserModel user;

  AddUser({required this.user});

  @override
  List<Object> get props => [user];
}
