import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/cart_model.dart';
import 'package:provider/provider.dart';

class MyFloatingButton extends StatelessWidget {
  final void Function()? onPressed;

  const MyFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, value, child) {
        return FittedBox(
          child: Stack(
            alignment: const Alignment(1.4, -1.5),
            children: [
              FloatingActionButton(
                onPressed: onPressed,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.shopping_bag),
              ),

              // show badge
              value.cartItems.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      constraints: const BoxConstraints(
                        minHeight: 30,
                        minWidth: 30,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue, // This would be color of the Badge
                      ),
                      child: Center(
                        child: Text(
                          "${value.cartItems.length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
