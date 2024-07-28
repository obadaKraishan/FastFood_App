import 'package:fastfood_app/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
    on<AuthSignUp>(_onSignUp);
    on<AuthSignOut>(_onSignOut);
    on<AuthUserChanged>(_onUserChanged);

    _authRepository.user.listen((user) {
      add(AuthUserChanged(user: user));
    });
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } catch (_) {
      emit(AuthFailure());
    }
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.signUpWithEmailAndPassword(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } catch (_) {
      emit(AuthFailure());
    }
  }

  void _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(user: event.user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
