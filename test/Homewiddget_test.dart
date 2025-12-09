import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_task/Controller/cart_controller.dart';
import 'package:flutter_project_task/data/model/product_model.dart';


class TestCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              key: Key('add_button'),
              onPressed: () {
                final product = Product(
                  id: 1,
                  title: 'T-Shirt',
                  price: 10.0,
                  image: 'https://example.com/tshirt.png',
                  rating: 4.5,
                  description: 'Comfortable cotton t-shirt',
                  category: 'Clothing',
                );
                cartProvider.addToCart(product);
              },
              child: Text('Add to Cart'),
            ),
            Text('Items in cart: ${cartProvider.cartItems.length}', key: Key('cart_text')),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Widget test for adding product to cart', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: TestCartWidget(),
      ),
    );


    expect(find.text('Items in cart: 0'), findsOneWidget);


    await tester.tap(find.byKey(Key('add_button')));
    await tester.pump();


    expect(find.text('Items in cart: 1'), findsOneWidget);
  });
}

