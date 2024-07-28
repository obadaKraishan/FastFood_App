import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/user_model.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is RegisterUser) {
      yield UserLoading();
      try {
        await userRepository.registerUser(event.user, event.password);
        yield UserLoaded(user: event.user);
      } catch (e) {
        yield UserError(message: e.toString());
      }
    } else if (event is LoginUser) {
      yield UserLoading();
      try {
        await userRepository.loginUser(event.email, event.password);
        UserModel? user = await userRepository.getUser(FirebaseAuth.instance.currentUser!.uid);
        if (user != null) {
          yield UserLoaded(user: user);
        } else {
          yield UserError(message: "User not found");
        }
      } catch (e) {
        yield UserError(message: e.toString());
      }
    } else if (event is LoadUser) {
      yield UserLoading();
      try {
        UserModel? user = await userRepository.getUser(event.userId);
        if (user != null) {
          yield UserLoaded(user: user);
        } else {
          yield UserError(message: "User not found");
        }
      } catch (e) {
        yield UserError(message: e.toString());
      }
    } else if (event is UpdateUser) {
      yield UserLoading();
      try {
        await userRepository.updateUser(event.user);
        yield UserLoaded(user: event.user);
      } catch (e) {
        yield UserError(message: e.toString());
      }
    } else if (event is LogoutUser) {
      yield UserLoading();
      try {
        await userRepository.logoutUser();
        yield UserInitial();
      } catch (e) {
        yield UserError(message: e.toString());
      }
    }
  }
}
