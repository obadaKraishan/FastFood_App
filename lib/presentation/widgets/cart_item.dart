import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<Map<String, dynamic>> _fetchAddonAndDrinkDetails(List<String> addonIds, List<String> drinkIds) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Map<String, dynamic> details = {};

    // Fetch addon details
    for (String addonId in addonIds) {
      DocumentSnapshot doc = await firestore.collection('addons').doc(addonId).get();
      if (doc.exists) {
        details[addonId] = doc.data();
      }
    }

    // Fetch drink details
    for (String drinkId in drinkIds) {
      DocumentSnapshot doc = await firestore.collection('drinks').doc(drinkId).get();
      if (doc.exists) {
        details[drinkId] = doc.data();
      }
    }

    return details;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchAddonAndDrinkDetails(cartItem.addons, cartItem.drinks),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error loading details');
        } else {
          final details = snapshot.data!;
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
                  Image.network(
                    cartItem.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItem.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text("\$${cartItem.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, color: Colors.red)),
                        ...details.entries.map((entry) {
                          final detail = entry.value;
                          return Text(
                            "${detail['name']} - \$${(detail['price'] as num).toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 14, color: Colors.white70),
                          );
                        }).toList(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                            ),
                            Text(cartItem.quantity.toString(), style: TextStyle(color: Colors.white)),
                            IconButton(
                              onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                              icon: Icon(Icons.add),
                              color: Colors.white,
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
      },
    );
  }
}
