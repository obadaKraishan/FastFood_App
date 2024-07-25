import 'package:fastfood_app/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignIn) {
      yield* _mapSignInToState(event);
    } else if (event is AuthSignUp) {
      yield* _mapSignUpToState(event);
    } else if (event is AuthSignOut) {
      yield* _mapSignOutToState();
    }
  }

  Stream<AuthState> _mapSignInToState(AuthSignIn event) async* {
    try {
      yield AuthLoading();
      final user = await _authRepository.signInWithEmailAndPassword(event.email, event.password);
      yield AuthAuthenticated(user: user);
    } catch (_) {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _mapSignUpToState(AuthSignUp event) async* {
    try {
      yield AuthLoading();
      final user = await _authRepository.signUpWithEmailAndPassword(event.email, event.password);
      yield AuthAuthenticated(user: user);
    } catch (_) {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _mapSignOutToState() async* {
    await _authRepository.signOut();
    yield AuthUnauthenticated();
  }
}
