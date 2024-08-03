import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final UserRepository userRepository;
  final ProductRepository productRepository;

  WishlistBloc({required this.userRepository, required this.productRepository}) : super(WishlistInitial()) {
    on<LoadWishlistEvent>(_onLoadWishlistEvent);
    on<AddToWishlistEvent>(_onAddToWishlistEvent);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlistEvent);
  }

  void _onLoadWishlistEvent(LoadWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      final wishlistIds = await userRepository.getWishlist(event.userId);
      final wishlist = await Future.wait(
        wishlistIds.map((productId) => productRepository.getProductById(productId)),
      );
      emit(WishlistLoaded(wishlist: wishlist));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  void _onAddToWishlistEvent(AddToWishlistEvent event, Emitter<WishlistState> emit) async {
    try {
      await userRepository.addToWishlist(event.userId, event.productId);
      add(LoadWishlistEvent(userId: event.userId));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  void _onRemoveFromWishlistEvent(RemoveFromWishlistEvent event, Emitter<WishlistState> emit) async {
    try {
      await userRepository.removeFromWishlist(event.userId, event.productId);
      add(LoadWishlistEvent(userId: event.userId));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }
}
