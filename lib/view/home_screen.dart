import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_task/view/cart_screen.dart';

import '../Controller/product_controller.dart';
import '../Controller/cart_controller.dart';
import '../Controller/favorite_controller.dart';
import '../data/model/product_model.dart';
import '../themes/theme_provider.dart';
import '../themes/app_colors.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productController = Provider.of<ProductController>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isDark = themeProvider.isDark;

    if (productController.isLoading) {
    return Scaffold(
    backgroundColor: AppColors.background(isDark),
    body: const Center(child: CircularProgressIndicator()),
    );
    }

    if (productController.errorMessage != null) {
    return Scaffold(
    backgroundColor: AppColors.background(isDark),
    body: Center(
    child: Text(
    productController.errorMessage!,
    style: TextStyle(color: isDark ? Colors.white : Colors.black),
    ),
    ),
    );
    }

    final products = productController.products;

    return Scaffold(
    backgroundColor: AppColors.background(isDark),
    appBar: AppBar(
    backgroundColor: AppColors.primary(isDark),
    title: Row(
    children: [
    Image.asset('assets/images/logo.png', height: 30.h),
    SizedBox(width: 8.w),
    Text(
    "Modee",
    style: TextStyle(
    color: isDark ? Colors.white : Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    ),
    ),
    ],
    ),
    actions: [
    IconButton(
    icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black),
    onPressed: () {},
    ),
    Consumer<CartProvider>(
    builder: (context, cartProvider, _) {
    return Stack(
    children: [
    IconButton(
    icon: Icon(Icons.card_travel, color: isDark ? Colors.white : Colors.black),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const CartPage()),
    );
    },
    ),
    if (cartProvider.cartItems.isNotEmpty)
    Positioned(
    right: 6,
    top: 6,
    child: Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(10),
    ),
    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
    child: Text(
    cartProvider.cartItems.length.toString(),
    style: const TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
    ),
    ),
    ),
    ],
    );
    },
    ),
    SizedBox(width: 10.w),
    ],
    ),
    body: ListView(
    padding: EdgeInsets.all(12.w),
    children: [
    // LOCATION
    Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    margin: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
    color: AppColors.card(isDark),
    borderRadius: BorderRadius.circular(12.r),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    blurRadius: 6.r,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Row(
    children: [
    Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey.shade200,
    ),
    child: Icon(
    Icons.location_on_outlined,
    color: Colors.blue,
    size: 28.w,
    ),
    ),
    SizedBox(width: 10.w),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "send_to".tr(),
    style: TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    ),
    ),
    Text(
    "Egypt, Queensland",
    style: TextStyle(
    color: AppColors.textPrimary(isDark),
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    ),
    ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.r),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),
    child: Text(
    "change".tr(),
    style: TextStyle(
    color: Colors.white,
    fontSize: 13.sp,
    ),
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
    // POPULAR BRANDS
    Text(
    "popular_Brands".tr(),
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    color: AppColors.textPrimary(isDark),
    ),
    ),
    SizedBox(height: 20.h),
    SizedBox(
    height: 80.h,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: images.length,
    itemBuilder: (context, index) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.w),
    child: Container(
    padding: EdgeInsets.all(5.w),
    width: 80,
    height: 80,
    decoration: BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    ),
    child: Image.asset(images[index]),
    ),
    );
    },
    ),
    ),
    SizedBox(height: 25.h),
    // FLASH SALE
    Text(
    "flash_sale".tr(),
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    color: AppColors.textPrimary(isDark),
    ),
    ),
    SizedBox(height: 10.h),
    GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
    childAspectRatio: 0.68,
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
    return productItem(context, products[index], cartProvider, favoriteProvider, isDark);
    },
    ),
    ],
    ),
    );
  }

  Widget productItem(BuildContext context, Product product, CartProvider cartProvider,
      FavoriteProvider favoriteProvider, bool isDark) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(product.image, height: 250.h, fit: BoxFit.contain),
                  SizedBox(height: 12.h),
                  Text(product.title,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6.h),
                  Text("${product.price.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16.sp, color: Colors.red)),
                  SizedBox(height: 6.h),
                  Text("⭐ ${product.rating}", style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () {
                      cartProvider.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('added_to_cart!'.tr()),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                    child: Text("add_to_cart".tr(), style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(8.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120.h,
                    width: double.infinity,
                    child: Center(
                      child: Image.network(product.image, height: 100.h, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(
                        favoriteProvider.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
                        color: favoriteProvider.isFavorite(product) ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        favoriteProvider.toggleFavorite(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(favoriteProvider.isFavorite(product)
                                ? "Added to Favorites ❤️".tr()
                                : "Removed from Favorites 💔".tr()),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.black)),
              Text("${product.price.toStringAsFixed(2)}",
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
                          content: Text('added_to_cart!'.tr()),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 1)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Text("add_to_cart".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
