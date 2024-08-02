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
    try {
      print('Adding item to cart: ${event.item.toMap()}');
      await cartRepository.addItemToCart(event.item);
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      print('Failed to add item to cart: $e');
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await cartRepository.removeItemFromCart(event.productId);
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      print('Failed to remove item from cart: $e');
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        await cartRepository.updateCartItem(event.item);
        final cart = await cartRepository.getCart();
        emit(CartLoaded(cart: cart));
      } catch (e) {
        print('Failed to update cart item: $e');
        emit(CartError(message: e.toString()));
      }
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        await cartRepository.clearCart((state as CartLoaded).cart.userId);
        emit(CartLoaded(cart: Cart(userId: (state as CartLoaded).cart.userId, items: [], tax: 0.0, deliveryFee: 0.0)));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }
}
