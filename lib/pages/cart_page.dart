import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_grocery_store/services/firestore.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('My cart')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getCart(),
        builder: (context, snapshot) {
          // count items in cart
          Map<String, int> itemCount = {};

          if (snapshot.hasData) {
            for (var item in snapshot.data!.docs) {
              itemCount.update(item['name'], (value) => value + 1,
                  ifAbsent: () => 1);
            }
          }

          // calculate total price
          double totalPrice = 0;

          if (snapshot.hasData) {
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              totalPrice += double.parse(snapshot.data!.docs[i]['price']);
            }
          }

          return Column(
            children: [
              Expanded(
                child: snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        itemCount: itemCount.length,
                        itemBuilder: (context, index) {
                          String itemName = itemCount.keys.elementAt(index);
                          int count = itemCount[itemName]!;

                          // destructuring data from firestore
                          final items = snapshot.data!.docs;
                          String price = items.firstWhere(
                              (item) => item['name'] == itemName)['price'];
                          double subtotal = double.parse(price) * count;

                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  items.firstWhere((item) =>
                                      item['name'] == itemName)['imagePath'],
                                ),
                                title: Text("$itemName x$count"),
                                subtitle:
                                    Text("฿ ${subtotal.toStringAsFixed(2)}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    firestore.removeFromCart(
                                      items.firstWhere((element) =>
                                          element['name'] == itemName)['name'],
                                    );
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
                            "฿ ${totalPrice.toStringAsFixed(2)}",
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
}
