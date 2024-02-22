import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_grocery_store/components/item_tile.dart';
import 'package:mini_grocery_store/components/my_floating_button.dart';
import 'package:mini_grocery_store/models/cart_model.dart';
import 'package:mini_grocery_store/pages/item_detail.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // get items
    final cart = context.read<CartModel>();
    final items = cart.items;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // greetig
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text('👋 Good morning,'),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Let's order fresh item for you",
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "You are what you eat ✌️",
              ),
            ),

            const SizedBox(height: 10),

            // item grid
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                ),
                itemBuilder: (context, index) {
                  return ItemTile(
                    item: items[index],
                    onPressed: () {
                      cart.addItemToCart(items[index], 1);

                      SnackBar mySnackBar = SnackBar(
                        content: Text("${items[index].name} added"),
                        duration: const Duration(seconds: 1),
                      );

                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                    },
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ItemDetailPage(item: items[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: MyFloatingButton(
        onPressed: () => Navigator.pushNamed(context, '/cartpage'),
      ),
    );
  }
}
