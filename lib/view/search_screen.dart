import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/favorite_controller.dart';
import '../Controller/product_controller.dart';
import 'PopularBrands_Page.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text("Search".tr(),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Search Products",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                controller.searchProducts(query);
              },
            ),
          ),
          Expanded(
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.products.isEmpty
                ? const Center(child: Text("No products found"))
                : ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                final isFav = favoriteProvider.isFavorite(product);

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(product.title),
                  subtitle: Text("${product.rating} ⭐"),
                  trailing: IconButton(
                    icon: Icon(
                      isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      favoriteProvider.toggleFavorite(product);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PopularBrandsPage(
                          brandImage: product.image,
                          productName: product.title,
                          rating: product.rating,
                          productDescription: product.description,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
