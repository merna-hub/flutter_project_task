import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularBrandsPage extends StatelessWidget {
  final String brandImage;
  final String productName;
  final String productDescription;
  final double rating;

  const PopularBrandsPage({
    super.key,
    required this.brandImage,
    required this.productName,
    required this.productDescription,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(brandImage, height: 200.h)),
            SizedBox(height: 10.h),
            Text(
              productName,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            Text("⭐ $rating", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 10.h),
            Text(
              productDescription,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
