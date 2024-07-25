import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:fastfood_app/presentation/screens/home/home_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/profile_screen.dart';
import 'package:fastfood_app/presentation/screens/search/search_screen.dart';
import 'package:fastfood_app/presentation/screens/search/filter_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';
import 'package:fastfood_app/presentation/screens/home/nearby_restaurants_screen.dart';
import 'package:fastfood_app/presentation/screens/cart/cart_screen.dart';
import 'package:fastfood_app/presentation/screens/payment/payment_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/filter':
        return MaterialPageRoute(builder: (_) => FilterScreen());
      case '/popular':
        return MaterialPageRoute(builder: (_) => PopularScreen());
      case '/nearby':
        return MaterialPageRoute(builder: (_) => NearbyRestaurantsScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/payment':
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      default:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
    }
  }
}
