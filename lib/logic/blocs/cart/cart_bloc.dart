import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/cart_model.dart';
import 'package:fastfood_app/data/repositories/cart_repository.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      Cart cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final cart = (state as CartLoaded).cart;
        final updatedItems = List<CartItem>.from(cart.items)..add(event.item);
        final updatedCart = Cart(userId: cart.userId, items: updatedItems);

        await cartRepository.updateCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final cart = (state as CartLoaded).cart;
        final updatedItems = cart.items.where((item) => item.productId != event.productId).toList();
        final updatedCart = Cart(userId: cart.userId, items: updatedItems);

        await cartRepository.updateCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final cart = (state as CartLoaded).cart;
        final updatedItems = cart.items.map((item) {
          return item.productId == event.item.productId ? event.item : item;
        }).toList();
        final updatedCart = Cart(userId: cart.userId, items: updatedItems);

        await cartRepository.updateCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final cart = (state as CartLoaded).cart;
        final updatedCart = Cart(userId: cart.userId, items: []);

        await cartRepository.updateCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }
}
