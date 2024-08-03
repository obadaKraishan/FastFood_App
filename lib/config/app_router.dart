import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/order_model.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'package:fastfood_app/logic/blocs/order/order_bloc.dart';
import 'package:fastfood_app/presentation/screens/auth/register_screen.dart';
import 'package:fastfood_app/presentation/screens/auth/login_screen.dart';
import 'package:fastfood_app/presentation/screens/categories/categories_screen.dart';
import 'package:fastfood_app/presentation/screens/checkout/add_payment_method_screen.dart';
import 'package:fastfood_app/presentation/screens/products/products_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/order_details_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/orders_screen.dart';
import 'package:fastfood_app/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:fastfood_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:fastfood_app/presentation/screens/home/home_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/profile_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/edit_profile_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/notifications_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/security_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/language_screen.dart';
import 'package:fastfood_app/presentation/screens/search/search_screen.dart';
import 'package:fastfood_app/presentation/screens/search/filter_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';
import 'package:fastfood_app/presentation/screens/home/nearby_restaurants_screen.dart';
import 'package:fastfood_app/presentation/screens/cart/cart_screen.dart';
import 'package:fastfood_app/presentation/screens/payment/payment_screen.dart';
import 'package:fastfood_app/presentation/screens/home/product_details_screen.dart';
import 'package:fastfood_app/presentation/screens/checkout/checkout_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => CustomBottomNavigationBar());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/edit_profile':
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case '/security':
        return MaterialPageRoute(builder: (_) => SecurityScreen());
      case '/language':
        return MaterialPageRoute(builder: (_) => LanguageScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/filter':
        return MaterialPageRoute(builder: (_) => FilterScreen());
      case '/popular':
        return MaterialPageRoute(builder: (_) => PopularScreen(
          incrementCartItemCount: () {
            print("Cart item count incremented");
          },
        ));
      case '/nearby':
        return MaterialPageRoute(builder: (_) => NearbyRestaurantsScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case '/payment':
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case '/add-payment-method':
        return MaterialPageRoute(builder: (_) => AddPaymentMethodScreen());
      case '/products':
        return MaterialPageRoute(builder: (_) => ProductsScreen(
          incrementCartItemCount: () {
            print("Cart item count incremented");
          },
        ));
      case '/categories':
        return MaterialPageRoute(builder: (_) => CategoriesScreen(
          incrementCartItemCount: () {
            print("Cart item count incremented");
          },
        ));
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/orders':
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case '/order-details':
        final arguments = settings.arguments as Map<String, dynamic>;
        final orderId = arguments['orderId'] as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<OrderBloc>(_),
            child: OrderDetailsScreen(orderId: orderId),
          ),
        );
      case '/product-details':
        final arguments = settings.arguments as Map<String, dynamic>;
        final productId = arguments['productId'] as String;
        final incrementCartItemCount = arguments['incrementCartItemCount'] as Function;
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(
          productId: productId,
          incrementCartItemCount: incrementCartItemCount,
        ));
      default:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
    }
  }
}
