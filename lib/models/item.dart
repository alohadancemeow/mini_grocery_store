import 'package:flutter/material.dart';

class Item {
  String name;
  String price;
  String imagePath;
  Color color;

  Item({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.color,
  });

  // String get _name => name;
  // String get _price => price;
  // String get _imagePath => imagePath;
  // Color get _color => color;
}
