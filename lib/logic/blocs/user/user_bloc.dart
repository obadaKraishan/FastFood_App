import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/data/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is AddUser) {
      yield* _mapAddUserToState(event);
    }
  }

  Stream<UserState> _mapAddUserToState(AddUser event) async* {
    try {
      yield UserLoading();
      await _userRepository.addUser(event.user);
      yield UserAdded();
    } catch (_) {
      yield UserError();
    }
  }
}
