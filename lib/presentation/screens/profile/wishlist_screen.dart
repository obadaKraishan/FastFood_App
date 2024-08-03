import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/presentation/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
          backgroundColor: Color(0xFF1C2029),
        ),
        body: Center(
          child: Text(
            'Please log in to view your wishlist.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: BlocProvider(
        create: (context) => WishlistBloc(
          userRepository: context.read<UserRepository>(),
          productRepository: context.read<ProductRepository>(),
        )..add(LoadWishlistEvent(userId: user.uid)),
        child: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WishlistLoaded) {
              final wishlist = state.wishlist;
              if (wishlist.isEmpty) {
                return Center(
                  child: Text(
                    'No items in your wishlist.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: wishlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  final product = wishlist[index];
                  return ProductCard(product: product);
                },
              );
            } else if (state is WishlistError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
