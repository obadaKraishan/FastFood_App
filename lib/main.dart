import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/data/repositories/ingredient_repository.dart';
import 'package:fastfood_app/data/repositories/addon_repository.dart';
import 'package:fastfood_app/data/repositories/drink_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart'; // Add this import
import 'package:fastfood_app/config/app_router.dart';
import 'package:fastfood_app/config/theme.dart';
import 'package:fastfood_app/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        RepositoryProvider<UserRepository>( // Add the UserRepository provider
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>( // Add the UserBloc provider
            create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
          ),
          // Add other BlocProviders if necessary
        ],
        child: MaterialApp(
          title: 'Food Delivery App',
          theme: appTheme,
          onGenerateRoute: _appRouter.generateRoute,
          home: CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}
