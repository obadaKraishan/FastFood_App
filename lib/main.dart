import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/config/app_router.dart';
import 'package:fastfood_app/config/theme.dart';
import 'package:fastfood_app/presentation/screens/home/home_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: appTheme,
        onGenerateRoute: _appRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
