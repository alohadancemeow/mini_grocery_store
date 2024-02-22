import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/item.dart';

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
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: item.color.withAlpha(75),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                item.imagePath,
                height: 64,
              ),
              Text(item.name),
              MaterialButton(
                onPressed: onPressed,
                color: item.color,
                child: Text(
                  "฿ ${item.price}",
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
    );
  }
}
