import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_task/utels/navigation_buttom.dart';
import 'Controller/product_controller.dart';
import 'Controller/cart_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartProvider()), // ✅ added
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ButtomNavigationBar(),
      ),
    );
  }
}
