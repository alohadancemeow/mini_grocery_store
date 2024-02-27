import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mini_grocery_store/models/item.dart';

class FirestoreService {
  final CollectionReference itemsRef =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference cartRef =
      FirebaseFirestore.instance.collection('cart');

  // READ ITEMS
  Stream<QuerySnapshot> getItems() => itemsRef.snapshots();

  // ADD TO CART
  Future<void> addToCart(Item item) {
    return cartRef.add({
      'name': item.name,
      'price': item.price,
      'imagePath': item.imagePath,
      'color': item.color,
      'timestamp': Timestamp.now(),
    });
  }
  // REMOVE FROM CART

  // GET IMAGE PATH
  Future<String?> getImageUrlFromFirebaseStorage(String imagePath) async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(imagePath);
      return await gsReference.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  // CUSTOM COLOR
  Map<String, Color> colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'pink': Colors.pink,
    'grey': Colors.grey,
    'brown': Colors.brown,
  };

  Color getColorFromString(String colorString) {
    return colorMap[colorString.toLowerCase()] ?? Colors.black;
  }
}
