import 'package:flutter/material.dart';
import '../data/model/product_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final Product product;

  const ItemDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Item Details",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
            color: isDark ? Colors.white : Colors.black), // لون أيقونات العودة
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Center(
              child: Image.network(
                product.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // العنوان
            Text(
              product.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            // السعر
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            // التصنيف
            Text(
              "Category: ${product.category}",
              style: TextStyle(
                  fontSize: 16, color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            // الوصف
            Text(
              product.description,
              style: TextStyle(
                  fontSize: 16, color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            // التقييم
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  product.rating.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // زر لإضافة للـ Cart (اختياري)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // هنا ممكن تضيفي action لإضافة المنتج للكارت
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: isDark ? Colors.blueGrey : Colors.blue[800],
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
