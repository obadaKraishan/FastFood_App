import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/addon_model.dart';

abstract class AddonState extends Equatable {
  const AddonState();

  @override
  List<Object> get props => [];
}

class AddonInitial extends AddonState {}

class AddonLoading extends AddonState {}

class AddonLoaded extends AddonState {
  final List<AddonModel> addons;

  const AddonLoaded({required this.addons});

  @override
  List<Object> get props => [addons];
}

class AddonError extends AddonState {}
