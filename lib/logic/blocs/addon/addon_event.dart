import 'package:equatable/equatable.dart';

abstract class AddonEvent extends Equatable {
  const AddonEvent();

  @override
  List<Object> get props => [];
}

class LoadAddons extends AddonEvent {}

class LoadAddonsByProduct extends AddonEvent {
  final List<String> addonIds;

  const LoadAddonsByProduct({required this.addonIds});

  @override
  List<Object> get props => [addonIds];
}
