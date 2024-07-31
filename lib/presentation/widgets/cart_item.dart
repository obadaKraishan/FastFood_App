// lib/presentation/widgets/cart_item.dart

import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onRemove,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A313F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cartItem.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("\$${cartItem.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, color: Colors.redAccent)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                        icon: Icon(Icons.remove, color: Colors.white),
                      ),
                      Text(cartItem.quantity.toString(), style: TextStyle(color: Colors.white)),
                      IconButton(
                        onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                        icon: Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
