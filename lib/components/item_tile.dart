import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/cart_model.dart';
import 'package:mini_grocery_store/models/item.dart';
import 'package:mini_grocery_store/services/firestore.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final void Function()? onPressed;
  final void Function()? ontap;

  const ItemTile({
    super.key,
    required this.item,
    required this.onPressed,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    Color color = firestoreService.getColorFromString(item.color);

    return Consumer<CartModel>(
      builder: (context, value, child) => GestureDetector(
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(75),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  value.images
                      .firstWhere((element) => element.name == item.name)
                      .imagePath,
                  height: 64,
                ),
                Text(item.name),
                MaterialButton(
                  onPressed: onPressed,
                  color: color,
                  child: Text(
                    "฿ ${double.parse(item.price).toStringAsFixed(1)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
