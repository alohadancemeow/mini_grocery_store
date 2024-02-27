import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_grocery_store/models/cart_model.dart';
import 'package:mini_grocery_store/models/item.dart';
import 'package:mini_grocery_store/services/firestore.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int quantityCount = 1;

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
        quantityCount--;
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void addToCart() {
    context.read<CartModel>().addItemToCart(widget.item, quantityCount);
    setState(() {
      quantityCount = 1;
    });

    SnackBar mySnackBar = SnackBar(
      content: Text("${widget.item.name} added"),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(mySnackBar);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final estimatedPrice = double.parse(widget.item.price) * quantityCount;

    final firestoreService = FirestoreService();
    Color color = firestoreService.getColorFromString(widget.item.color);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.item.name} details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    Image.asset(
                      value.images
                          .firstWhere(
                              (element) => element.name == widget.item.name)
                          .imagePath,
                      height: 200,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      widget.item.name,
                      style: GoogleFonts.notoSerif(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),

            // price and quantity
            Container(
              color: color.withOpacity(0.8),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ $estimatedPrice.0',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: decrementQuantity,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                quantityCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: incrementQuantity,
                            ),
                          )
                        ],
                      ),
                      MaterialButton(
                        onPressed: addToCart,
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.green.shade100),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[900],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Row(
                            children: [
                              Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
