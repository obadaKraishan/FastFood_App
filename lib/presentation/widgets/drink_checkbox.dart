// lib/presentation/widgets/drink_checkbox.dart
import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/drink_model.dart';

class DrinkCheckbox extends StatelessWidget {
  final DrinkModel drink;
  final bool isChecked;
  final Function(bool?)? onChanged;

  DrinkCheckbox({
    required this.drink,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        children: [
          SizedBox(width: 8),
          Text(drink.name, style: TextStyle(color: Colors.white)),
          Spacer(),
          Text('\$${drink.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white70)),
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