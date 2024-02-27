import 'package:flutter/material.dart';

class ItemImages extends ChangeNotifier {
  final List<MyImages> _images = [
    MyImages(
      name: 'Apple',
      imagePath: 'lib/images/apple.png',
    ),
    MyImages(
      name: 'Blue Berry',
      imagePath: 'lib/images/blueberry.png',
    ),
    MyImages(
      name: 'Coconut',
      imagePath: 'lib/images/coconut.png',
    ),
    MyImages(
      name: 'Cherries',
      imagePath: 'lib/images/cherries.png',
    ),
    MyImages(
      name: 'Mango',
      imagePath: 'lib/images/mango.png',
    ),
    MyImages(
      name: 'Orange',
      imagePath: 'lib/images/orange.png',
    ),
    MyImages(
      name: 'Strawberry',
      imagePath: 'lib/images/strawberry.png',
    ),
    MyImages(
      name: 'Passion-fruit',
      imagePath: 'lib/images/passion-fruit.png',
    ),
    MyImages(
      name: 'Watermelon',
      imagePath: 'lib/images/watermelon.png',
    ),
    MyImages(
      name: 'Egg',
      imagePath: 'lib/images/egg.png',
    ),
    MyImages(
      name: 'Milk',
      imagePath: 'lib/images/milk.png',
    ),
    MyImages(
      name: 'Cheese',
      imagePath: 'lib/images/cheese.png',
    ),
  ];

  List<MyImages> get images => _images;
}

class MyImages {
  String name;
  String imagePath;

  MyImages({
    required this.name,
    required this.imagePath,
  });
}
