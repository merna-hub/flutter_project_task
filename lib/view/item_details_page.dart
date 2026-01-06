import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../data/model/product_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final Product product;

  const ItemDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color textColor = isDark ? Colors.white : Colors.black;
    Color bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "item_details".tr(),
          style: TextStyle(color: textColor),
        ),
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: textColor),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// Title
            Text(
              product.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "${"price".tr()}: \$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "${"category".tr()}: ${product.category}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "description".tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 5),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),

            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  "${"rating".tr()}: ${product.rating}",
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
