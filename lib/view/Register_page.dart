import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../AuthProvider/authProvider.dart';
import '../utels/navigation_buttom.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      backgroundColor: colors.surface,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "Create Account".tr(),
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Create an account so you can explore all the prodect".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: emailController,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Email".tr(),
                  hintStyle: TextStyle(
                    color: colors.onSurface.withOpacity(0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Password".tr(),
                  hintStyle: TextStyle(
                    color: colors.onSurface.withOpacity(0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Confirm Password".tr(),
                  hintStyle: TextStyle(
                    color: colors.onSurface.withOpacity(0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                          content: Text("Passwords do not match".tr() ),
                        ),
                      );
                      return;
                    }
                    String? result = await authProvider.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Sign up".tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
