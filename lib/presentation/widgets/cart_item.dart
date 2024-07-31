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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              cartItem.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("\$${cartItem.price.toStringAsFixed(2)}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                        icon: Icon(Icons.remove),
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
