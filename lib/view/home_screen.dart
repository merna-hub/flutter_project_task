import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_task/view/cart_screen.dart';
import '../Controller/product_controller.dart';
import '../Controller/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductController>(context, listen: false).getProducts());
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (productController.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (productController.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(productController.errorMessage!)),
      );
    }

    final products = productController.products;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Icon(Icons.store, color: Colors.blue, size: 28),
            const SizedBox(width: 8),
            const Text(
              "Modee",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // search
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage ()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // 🔹 هنا تم استبدال TextField بالكارد الجميل الخاص بالموقع
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Send To",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Brisbane, Queensland",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Change",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "50% Off Today\nLimited-time picks\njust for you",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: const Text(
                          "Shop Now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/man.png', height: 80),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Popular Brand",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                brandLogo("https://1000logos.net/wp-content/uploads/2017/05/Zara-logo.png"),
                brandLogo("https://upload.wikimedia.org/wikipedia/en/3/31/Lacoste_logo.svg"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/02/Ralph-Lauren-Logo.png"),
                brandLogo("https://upload.wikimedia.org/wikipedia/commons/4/44/Levi%27s_logo.svg"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/05/Nike-Logo.png"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/03/Adidas-Logo.png"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/05/HM-logo.png"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/05/Gucci-Logo.png"),
                brandLogo("https://1000logos.net/wp-content/uploads/2017/03/Puma-logo.png"),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "Flash Sale",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return productItem(context, product, cartProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget brandLogo(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundImage: NetworkImage(url),
        radius: 30,
      ),
    );
  }

  Widget productItem(BuildContext context, product, cartProvider) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(product.image,
                    height: 100, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.red)),
            Text("⭐ ${product.rating}"),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
