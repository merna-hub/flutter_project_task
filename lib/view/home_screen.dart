import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<String> images = [
    'assets/images/zara.png',
    'assets/images/hm.png',
    'assets/images/lacoste.png',
    'assets/images/pullbear.png',
    'assets/images/ralph.png',
    'assets/images/lacoste.png',
    'assets/images/pullbear.png',
    'assets/images/ralph.png',
  ];

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
            Image.asset('assets/images/logo.png', height: 30.h),
            SizedBox(width: 8.w),
            const Text(
              "Modee",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.card_travel, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
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
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send To",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Brisbane, Queensland",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 18.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    "Change",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Image.asset('assets/images/img.png'),
          ),
          SizedBox(height: 20.h),
          Text(
            "Popular Brands",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              itemCount: images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Image.asset(images[index]),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Flash Sale",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
              MediaQuery.of(context).size.width > 600 ? 4 : 2,
              childAspectRatio: 0.7,
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
  Widget productItem(BuildContext context, product, CartProvider cartProvider) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  product.image,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            Text("\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.red, fontSize: 13.sp)),
            Text("⭐ ${product.rating}", style: TextStyle(fontSize: 12.sp)),
            SizedBox(height: 5.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} added to cart!'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}