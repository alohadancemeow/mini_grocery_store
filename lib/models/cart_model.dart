import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // items
  final List _items = [
    ['Apple', '15.0', 'lib/images/apple.png', Colors.red],
    ['Blue Berry', '15.0', 'lib/images/blueberry.png', Colors.purple],
    ['Coconut', '15.0', 'lib/images/coconut.png', Colors.brown],
    ['Cherries', '15.0', 'lib/images/cherries.png', Colors.red],
    ['Mango', '15.0', 'lib/images/mango.png', Colors.yellow],
    ['Orange', '15.0', 'lib/images/orange.png', Colors.orange],
    ['Strawberry', '15.0', 'lib/images/strawberry.png', Colors.pink],
    ['Passion-fruit', '15.0', 'lib/images/passion-fruit.png', Colors.purple],
    ['Watermelon', '15.0', 'lib/images/watermelon.png', Colors.red],
    ['Egg', '15.0', 'lib/images/egg.png', Colors.grey],
    ['Milk', '15.0', 'lib/images/milk.png', Colors.blue],
    ['Cheese', '15.0', 'lib/images/cheese.png', Colors.yellow],
  ];

  get items => _items;

  // cart
  List _cartItems = [];

  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_items[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;

    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }

    return totalPrice.toString();
  }
}
