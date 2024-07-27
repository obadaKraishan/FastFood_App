// lib/presentation/widgets/ingredient_checkbox.dart
import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/ingredient_model.dart';

class IngredientCheckbox extends StatelessWidget {
  final IngredientModel ingredient;
  final bool isChecked;
  final Function(bool?)? onChanged;

  IngredientCheckbox({
    required this.ingredient,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(ingredient.name, style: TextStyle(color: Colors.white)),
      value: isChecked,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.redAccent,
      checkColor: Colors.white,
    );
  }
}
