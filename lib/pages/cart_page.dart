import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/cart_model.dart';
import 'package:mini_grocery_store/models/item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My cart')),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          List<Item> items = value.cartItems;

          Map<String, int> itemCount = {};

          for (var item in items) {
            itemCount.update(item.name, (value) => value + 1,
                ifAbsent: () => 1);
          }

          return Column(
            children: [
              Expanded(
                child: value.cartItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: itemCount.length,
                        itemBuilder: (context, index) {
                          String itemName = itemCount.keys.elementAt(index);
                          int count = itemCount[itemName]!;
                          String price = items
                              .firstWhere((item) => item.name == itemName)
                              .price;
                          double subtotal = double.parse(price) * count;

                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Image.asset(items
                                    .firstWhere((item) => item.name == itemName)
                                    .imagePath),
                                title: Text("$itemName x$count"),
                                subtitle:
                                    Text("฿ ${subtotal.toStringAsFixed(2)}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    // value.removeItemFromCart(item);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Cart is empty'),
                      ),
              ),

              // show total price
              Padding(
                padding: const EdgeInsets.all(36),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "฿ ${value.calculateTotal()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Row(
                            children: [
                              Text(
                                "Check out",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  // void getItemCounts(List<Item> cartItems) {
  //   Map<String, int> itemCounts = {};
  //   Map<String, double> itemPrices = {};

  //   itemCounts.clear();
  //   for (final item in cartItems) {
  //     if (itemCounts.containsKey(item)) {
  //       itemCounts[item.name] += 1;
  //     } else {
  //       itemCounts[item.name] = 1;
  //     }
  //   }

  //   double total = 0;
  //   itemCounts.forEach((item, count) {
  //     total += itemPrices[item]! * count;
  //   });
  // }
}
