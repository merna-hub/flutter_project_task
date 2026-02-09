import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Controller/cart_controller.dart';
import 'favorite_page.dart';
import 'item_details_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "cart".tr(),
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          "your_cart_is_empty 🛒".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItemObj = cartItems[index];
                  return cartItem(context, cartItemObj, cartProvider, isDark);
                },
              ),
            ),
            const Divider(thickness: 1.2),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("shipping_information".tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  )),
            ),
            SizedBox(height: 10.h),
            infoRow("total items".tr(), "${cartProvider.totalQuantity}", isDark),
            infoRow("shipping fee".tr(), "\$5.00", isDark),
            infoRow("taxes".tr(), "\$2.00", isDark),
            const Divider(thickness: 1.2),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total: \$${(cartProvider.totalPrice + 7).toStringAsFixed(2)}".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Proceeding to checkout: \$${(cartProvider.totalPrice + 7).toStringAsFixed(2)}".tr()),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.blueGrey : Colors.blue[800],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "checkout".tr(),
                    style: const TextStyle(color: Colors.white),
                  ).tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cartItem(BuildContext context, CartItem item, CartProvider cartProvider, bool isDark) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemDetailsPage(product: item.product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.network(item.product.image,
                width: 70.w, height: 70.h, fit: BoxFit.cover),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(height: 4.h),
                  Text("\$${item.product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                  onPressed: () {
                    cartProvider.decreaseQuantity(item.product);
                  },
                ),
                Text(
                  item.quantity.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () {
                    cartProvider.addToCart(item.product);
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                cartProvider.removeFromCart(item.product);
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget infoRow(String title, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
              TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black)),
          Text(value,
              style:
              TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}
