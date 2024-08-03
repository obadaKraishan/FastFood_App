import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/models/addon_model.dart';
import 'package:fastfood_app/data/models/drink_model.dart';
import 'package:fastfood_app/data/models/ingredient_model.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/repositories/addon_repository.dart';
import 'package:fastfood_app/data/repositories/cart_repository.dart';
import 'package:fastfood_app/data/repositories/drink_repository.dart';
import 'package:fastfood_app/data/repositories/ingredient_repository.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';
import 'package:fastfood_app/logic/blocs/ingredient/ingredient_bloc.dart';
import 'package:fastfood_app/logic/blocs/ingredient/ingredient_event.dart';
import 'package:fastfood_app/logic/blocs/ingredient/ingredient_state.dart';
import 'package:fastfood_app/logic/blocs/addon/addon_bloc.dart';
import 'package:fastfood_app/logic/blocs/addon/addon_event.dart';
import 'package:fastfood_app/logic/blocs/addon/addon_state.dart';
import 'package:fastfood_app/logic/blocs/drink/drink_bloc.dart';
import 'package:fastfood_app/logic/blocs/drink/drink_event.dart';
import 'package:fastfood_app/logic/blocs/drink/drink_state.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/presentation/widgets/quantity_button.dart';
import 'package:fastfood_app/presentation/widgets/ingredient_checkbox.dart';
import 'package:fastfood_app/presentation/widgets/addon_checkbox.dart';
import 'package:fastfood_app/presentation/widgets/drink_checkbox.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final Function incrementCartItemCount;

  ProductDetailsScreen({required this.productId, required this.incrementCartItemCount});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  double _totalPrice = 0.0;
  List<String> _selectedIngredients = [];
  List<String> _selectedAddons = [];
  List<String> _selectedDrinks = [];

  double? _basePrice;
  List<IngredientModel> _ingredients = [];
  List<AddonModel> _addons = [];
  List<DrinkModel> _drinks = [];
  bool _isWishlistItem = false;

  bool _isProductLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isProductLoaded) {
        _updateTotalPrice();
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _updateTotalPrice();
      });
    }
  }

  void _updateTotalPrice() {
    if (_basePrice == null) return;

    double price = _basePrice!;

    for (var addonId in _selectedAddons) {
      price += _addons.firstWhere((addon) => addon.id == addonId).price;
    }

    for (var drinkId in _selectedDrinks) {
      price += _drinks.firstWhere((drink) => drink.id == drinkId).price;
    }

    setState(() {
      _totalPrice = price * _quantity;
    });
    print('Total price updated: $_totalPrice');
  }

  void _toggleWishlist(String userId) {
    setState(() {
      _isWishlistItem = !_isWishlistItem;
    });

    if (_isWishlistItem) {
      context.read<WishlistBloc>().add(AddToWishlistEvent(userId: userId, productId: widget.productId));
    } else {
      context.read<WishlistBloc>().add(RemoveFromWishlistEvent(userId: userId, productId: widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())
            ..add(LoadProduct(productId: widget.productId)),
        ),
        BlocProvider(
          create: (context) => IngredientBloc(ingredientRepository: context.read<IngredientRepository>()),
        ),
        BlocProvider(
          create: (context) => AddonBloc(addonRepository: context.read<AddonRepository>()),
        ),
        BlocProvider(
          create: (context) => DrinkBloc(drinkRepository: context.read<DrinkRepository>()),
        ),
        BlocProvider(
          create: (context) => CartBloc(cartRepository: context.read<CartRepository>()),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(
            userRepository: context.read<UserRepository>(),
            productRepository: context.read<ProductRepository>(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF1C2029),
        appBar: AppBar(
          backgroundColor: Color(0xFF1C2029),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Product Details', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            if (user != null)
              IconButton(
                icon: Icon(
                  _isWishlistItem ? Icons.favorite : Icons.favorite_border,
                  color: _isWishlistItem ? Colors.red : Colors.white,
                ),
                onPressed: () => _toggleWishlist(user.uid),
              ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded && state.product != null) {
              final product = state.product!;
              if (!_isProductLoaded) {
                _basePrice = product.price;
                _isProductLoaded = true;

                // Check if the product is in the wishlist
                if (user != null) {
                  context.read<WishlistBloc>().add(LoadWishlistEvent(userId: user.uid));
                }

                // Call _updateTotalPrice after the first frame is built to avoid calling setState during build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _updateTotalPrice();
                });
              }

              context.read<IngredientBloc>().add(LoadIngredientsByProduct(ingredientIds: product.ingredientIds));
              context.read<AddonBloc>().add(LoadAddonsByProduct(addonIds: product.addonIds));
              context.read<DrinkBloc>().add(LoadDrinksByProduct(drinkIds: product.drinkIds));

              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.imageUrl,
                              height: 380,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${_totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < product.rating.round() ? Icons.star : Icons.star_border,
                                  color: Colors.yellow,
                                  size: 20,
                                );
                              }),
                            ),
                            Text(
                              '(${product.reviews} reviews)',
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: 22, color: Colors.white70),
                        ),
                        SizedBox(height: 16),
                        BlocBuilder<IngredientBloc, IngredientState>(
                          builder: (context, ingredientState) {
                            if (ingredientState is IngredientLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (ingredientState is IngredientLoaded) {
                              _ingredients = ingredientState.ingredients;
                              _selectedIngredients = _ingredients.where((ingredient) => ingredient.isMandatory).map((ingredient) => ingredient.id).toList();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ingredients',
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  ..._ingredients.map((ingredient) {
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: IngredientCheckbox(
                                        ingredient: ingredient,
                                        isChecked: _selectedIngredients.contains(ingredient.id),
                                        onChanged: ingredient.isMandatory
                                            ? null
                                            : (checked) {
                                          setState(() {
                                            if (checked == true) {
                                              _selectedIngredients.add(ingredient.id);
                                            } else {
                                              _selectedIngredients.remove(ingredient.id);
                                            }
                                            _updateTotalPrice();
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ],
                              );
                            }
                            return Center(child: Text('Error loading ingredients', style: TextStyle(color: Colors.white)));
                          },
                        ),
                        SizedBox(height: 16),
                        BlocBuilder<AddonBloc, AddonState>(
                          builder: (context, addonState) {
                            if (addonState is AddonLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (addonState is AddonLoaded) {
                              _addons = addonState.addons;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add-ons',
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  ..._addons.map((addon) {
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: AddonCheckbox(
                                        addon: addon,
                                        isChecked: _selectedAddons.contains(addon.id),
                                        onChanged: (checked) {
                                          setState(() {
                                            if (checked == true) {
                                              _selectedAddons.add(addon.id);
                                            } else {
                                              _selectedAddons.remove(addon.id);
                                            }
                                            _updateTotalPrice();
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ],
                              );
                            }
                            return Center(child: Text('Error loading add-ons', style: TextStyle(color: Colors.white)));
                          },
                        ),
                        SizedBox(height: 16),
                        BlocBuilder<DrinkBloc, DrinkState>(
                          builder: (context, drinkState) {
                            if (drinkState is DrinkLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (drinkState is DrinkLoaded) {
                              _drinks = drinkState.drinks;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Drinks',
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  ..._drinks.map((drink) {
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: DrinkCheckbox(
                                        drink: drink,
                                        isChecked: _selectedDrinks.contains(drink.id),
                                        onChanged: (checked) {
                                          setState(() {
                                            if (checked == true) {
                                              _selectedDrinks.add(drink.id);
                                            } else {
                                              _selectedDrinks.remove(drink.id);
                                            }
                                            _updateTotalPrice();
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ],
                              );
                            }
                            return Center(child: Text('Error loading drinks', style: TextStyle(color: Colors.white)));
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityButton(
                              icon: Icons.remove,
                              onPressed: _decrementQuantity,
                            ),
                            Text(
                              '$_quantity',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            QuantityButton(
                              icon: Icons.add,
                              onPressed: _incrementQuantity,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final cartItem = CartItem(
                                id: widget.productId,
                                productId: widget.productId,
                                name: product.name,
                                price: _totalPrice,
                                quantity: _quantity,
                                imageUrl: product.imageUrl,
                                addons: _selectedAddons,
                                drinks: _selectedDrinks,
                              );
                              context.read<CartBloc>().add(AddToCart(item: cartItem));

                              widget.incrementCartItemCount();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Item Added to Cart"),
                                    content: Text("${product.name} has been added to your cart."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Continue Shopping"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/cart');
                                        },
                                        child: Text("Go to Cart"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Add to Cart (\$${_totalPrice.toStringAsFixed(2)})',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(child: Text('Product not found', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
