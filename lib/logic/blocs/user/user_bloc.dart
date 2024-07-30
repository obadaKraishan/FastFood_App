import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/user_model.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<LogoutUser>(_onLogoutUser);
  }

  void _onRegisterUser(RegisterUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.registerUser(event.user, event.password);
      emit(UserLoaded(user: event.user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.loginUser(event.email, event.password);
      UserModel? user = await userRepository.getUser(FirebaseAuth.instance.currentUser!.uid);
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserError(message: "User not found"));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      UserModel? user = await userRepository.getUser(event.userId);
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserError(message: "User not found"));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.updateUser(event.user);
      emit(UserLoaded(user: event.user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.logoutUser();
      emit(UserInitial());
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
