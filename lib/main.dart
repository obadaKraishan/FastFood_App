import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fastfood_app/config/theme.dart';
import 'package:fastfood_app/config/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: appTheme,
      onGenerateRoute: _appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
