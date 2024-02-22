import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/item.dart';

class CartModel extends ChangeNotifier {
  // items
  final List<Item> _items = [
    Item(
      name: 'Apple',
      price: '15.0',
      imagePath: 'lib/images/apple.png',
      color: Colors.red,
    ),
    Item(
      name: 'Blue Berry',
      price: '15.0',
      imagePath: 'lib/images/blueberry.png',
      color: Colors.purple,
    ),
    Item(
      name: 'Coconut',
      price: '15.0',
      imagePath: 'lib/images/coconut.png',
      color: Colors.brown,
    ),
    Item(
      name: 'Cherries',
      price: '15.0',
      imagePath: 'lib/images/cherries.png',
      color: Colors.red,
    ),
    Item(
      name: 'Mango',
      price: '15.0',
      imagePath: 'lib/images/mango.png',
      color: Colors.yellow,
    ),
    Item(
      name: 'Orange',
      price: '15.0',
      imagePath: 'lib/images/orange.png',
      color: Colors.orange,
    ),
    Item(
      name: 'Strawberry',
      price: '15.0',
      imagePath: 'lib/images/strawberry.png',
      color: Colors.pink,
    ),
    Item(
      name: 'Passion-fruit',
      price: '15.0',
      imagePath: 'lib/images/passion-fruit.png',
      color: Colors.purple,
    ),
    Item(
      name: 'Watermelon',
      price: '15.0',
      imagePath: 'lib/images/watermelon.png',
      color: Colors.red,
    ),
    Item(
      name: 'Egg',
      price: '15.0',
      imagePath: 'lib/images/egg.png',
      color: Colors.grey,
    ),
    Item(
      name: 'Milk',
      price: '15.0',
      imagePath: 'lib/images/milk.png',
      color: Colors.blue,
    ),
    Item(
      name: 'Cheese',
      price: '15.0',
      imagePath: 'lib/images/cheese.png',
      color: Colors.yellow,
    ),
  ];

  List<Item> get items => _items;

  // cart
  List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;

  void addItemToCart(Item item, int qty) {
    for (int i = 0; i < qty; i++) {
      _cartItems.add(item);

      notifyListeners();
    }
  }

  void removeItemFromCart(Item item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;

    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i].price);
    }

    return totalPrice.toString();
  }
}
