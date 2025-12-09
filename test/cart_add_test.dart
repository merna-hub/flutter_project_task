import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project_task/Controller/cart_controller.dart';
import 'package:flutter_project_task/data/model/product_model.dart';

void main() {
  group('CartProvider addToCart', () {
    late CartProvider cartProvider;
    late Product product;

    setUp(() {
      cartProvider = CartProvider();
      product = Product(
        id: 1,
        title: 'T-Shirt',
        price: 10.0,
        image: 'https://example.com/tshirt.png',
        rating: 4.5,
        description: 'Comfortable cotton t-shirt',
        category: 'Clothing',
      );
    });


    test('should add a new product to the cart', () {
      cartProvider.addToCart(product);

      expect(cartProvider.cartItems.length, 1);
      expect(cartProvider.cartItems[0].product.id, 1);
      expect(cartProvider.cartItems[0].quantity, 1);
    });

    test('should increase quantity if the product already exists', () {
      cartProvider.addToCart(product);
      cartProvider.addToCart(product);

      expect(cartProvider.cartItems.length, 1);
      expect(cartProvider.cartItems[0].quantity, 2);
    });
  });
}


