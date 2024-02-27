import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_grocery_store/firebase_options.dart';
import 'package:mini_grocery_store/models/item_images.dart';
import 'package:mini_grocery_store/pages/cart_page.dart';
import 'package:mini_grocery_store/pages/intro_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemImages(),
      child: MaterialApp(
        title: 'Mini Grocery Store',
        home: const IntroPage(),
        routes: {
          '/cartpage': (context) => const CartPage(),
        },
      ),
    );
  }
}
