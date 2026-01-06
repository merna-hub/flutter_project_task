import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_page.dart';
import 'Register_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220.h,
              child: Image.asset(
                'assets/images/images.png',
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 30.h),
            Text(
              "Modeee",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // الأزرق
              ),
            ),

            SizedBox(height: 15.h),
            Text(
              "Shop the latest fashion trends, all in one place".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.blue.withOpacity(0.7),
              ),
            ),

            SizedBox(height: 40.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Login".tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register".tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
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
