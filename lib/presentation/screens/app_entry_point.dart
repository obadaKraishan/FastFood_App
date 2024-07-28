import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_state.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:fastfood_app/presentation/screens/home/home_screen.dart';
import 'package:fastfood_app/presentation/screens/onboarding/onboarding_screen.dart';

class AppEntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          context.read<UserBloc>().add(LoadUser(userId: state.user!.uid));
          return HomeScreen();
        } else if (state is AuthUnauthenticated) {
          return OnboardingScreen();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
