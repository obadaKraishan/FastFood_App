import 'package:equatable/equatable.dart';

abstract class AddonEvent extends Equatable {
  const AddonEvent();

  @override
  List<Object> get props => [];
}

class LoadAddonsByProduct extends AddonEvent {
  final String productId;

  const LoadAddonsByProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}
