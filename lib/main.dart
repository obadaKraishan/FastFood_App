import 'package:fastfood_app/data/repositories/auth_repository.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/data/repositories/ingredient_repository.dart';
import 'package:fastfood_app/data/repositories/addon_repository.dart';
import 'package:fastfood_app/data/repositories/drink_repository.dart';
import 'package:fastfood_app/config/app_router.dart';
import 'package:fastfood_app/config/theme.dart';
import 'package:fastfood_app/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:fastfood_app/presentation/screens/app_entry_point.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Activate App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );

  // Uncomment the following line if you need to use a debug token
  // FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirestoreProvider>(
          create: (context) => FirestoreProvider(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepository(firestoreProvider: context.read<FirestoreProvider>()),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(firestoreProvider: context.read<FirestoreProvider>()),
        ),
        RepositoryProvider<IngredientRepository>(
          create: (context) => IngredientRepository(firestoreProvider: context.read<FirestoreProvider>()),
        ),
        RepositoryProvider<AddonRepository>(
          create: (context) => AddonRepository(firestoreProvider: context.read<FirestoreProvider>()),
        ),
        RepositoryProvider<DrinkRepository>(
          create: (context) => DrinkRepository(firestoreProvider: context.read<FirestoreProvider>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Food Delivery App',
          theme: appTheme,
          onGenerateRoute: _appRouter.generateRoute,
          home: AppEntryPoint(),
        ),
      ),
    );
  }
}
