import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.blue,
        elevation: 0,
        title: Text(
          "Forgot Password".tr(),
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Text(
                  "Reset Password".tr(),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Enter your email to receive a reset link".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.grey[400] : Colors.grey,
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email".tr(),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: isDark ? Colors.grey[500] : Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: isDark ? Colors.white : Colors.blue,
                        size: 22.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 16.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                            isDark ? Colors.grey[800] : Colors.black,
                            content: Text(
                              "Please enter your email".tr(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      try {
                        // إرسال الإيميل مباشرة عن طريق FirebaseAuth
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                            email: emailController.text.trim());

                        // إشعار المستخدم أن الإيميل وصل
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                            isDark ? Colors.grey[800] : Colors.green,
                            content: Text(
                              "Password reset email sent! Check your inbox 📧"
                                  .tr(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        );

                        emailController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Error: ${e.toString()}".tr(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        );
                      } finally {
                        setState(() => isLoading = false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isDark ? Colors.blueGrey : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "Send Reset Link".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back to Login".tr(),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.blue,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

