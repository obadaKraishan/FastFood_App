part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWishlistEvent extends WishlistEvent {
  final String userId;

  const LoadWishlistEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddToWishlistEvent extends WishlistEvent {
  final String userId;
  final String productId;

  const AddToWishlistEvent({required this.userId, required this.productId});

  @override
  List<Object> get props => [userId, productId];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String userId;
  final String productId;

  const RemoveFromWishlistEvent({required this.userId, required this.productId});

  @override
  List<Object> get props => [userId, productId];
}
