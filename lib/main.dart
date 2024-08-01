import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/cart_model.dart';
import 'package:fastfood_app/data/repositories/auth_repository.dart';
import 'package:fastfood_app/data/repositories/cart_repository.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:fastfood_app/presentation/utils/theme_provider.dart';
import 'package:fastfood_app/presentation/screens/app_entry_point.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/blocs/user/user_bloc.dart';
import 'services/stripe_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Activate App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );

  // Initialize Stripe
  StripeService.init();

  // Uncomment the following line if you need to use a debug token
  // FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
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
              RepositoryProvider<CartRepository>(
                create: (context) => CartRepository(firestore: context.read<FirestoreProvider>().firestore, firebaseAuth: FirebaseAuth.instance),
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
                BlocProvider(
                  create: (context) => CartBloc(cartRepository: context.read<CartRepository>()),
                ),
              ],
              child: MaterialApp(
                title: 'Food Delivery App',
                theme: lightTheme, // Define lightTheme in your theme configuration
                darkTheme: darkTheme, // Define darkTheme in your theme configuration
                themeMode: themeProvider.currentTheme, // Apply the theme mode
                onGenerateRoute: _appRouter.generateRoute,
                home: AppEntryPoint(),
              ),
            ),
          );
        },
      ),
    );
  }
}
