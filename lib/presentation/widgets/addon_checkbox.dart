// lib/presentation/widgets/addon_checkbox.dart
import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/addon_model.dart';

class AddonCheckbox extends StatelessWidget {
  final AddonModel addon;
  final bool isChecked;
  final Function(bool?)? onChanged;

  AddonCheckbox({
    required this.addon,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        children: [
          Text(addon.name, style: TextStyle(color: Colors.white)),
          Spacer(),
          Text('\$${addon.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white70)),
        ],
      ),
      value: isChecked,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.redAccent,
      checkColor: Colors.white,
    );
  }
}
