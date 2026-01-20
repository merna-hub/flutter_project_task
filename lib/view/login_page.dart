import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../AuthProvider/authProvider.dart';
import '../utels/navigation_buttom.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

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
              Text("Login here".tr(),
                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold, color: Colors.blue)),
              SizedBox(height: 10.h),
              Text("Welcome back you".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.onSurface.withOpacity(0.7), fontSize: 16.sp)),
              SizedBox(height: 30.h),
              TextField(
                controller: emailController,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Email".tr(),
                  hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.blue),
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
                  hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: colors.onSurface.withOpacity(0.7)),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                  ),
                  child:  Text("Forgot Password?".tr()),
                ),
              ),
              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () async {
                    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Please fill all fields".tr()))
                      );
                      return;
                    }
                    String? result = await authProvider.signIn(
                        emailController.text.trim(), passwordController.text.trim());
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                    } else {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => ButtomNavigationBar()));
                    }
                  },
                  child: Text("Sign in".tr(), style: TextStyle(fontSize: 16.sp)),
                ),
              ),
              SizedBox(height: 20.h),
              Text("Or continue with".tr(),
                  style: TextStyle(fontSize: 14.sp, color: colors.onSurface.withOpacity(0.7))),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () async {
                  String? result = await authProvider.signInWithGoogle();
                  if (result != null) {
                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  } else {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => ButtomNavigationBar()));
                  }
                }},
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue),
                  ),
                  child:Center(
                      child: Icon(
                        Icons.g_mobiledata,
                        color: Colors.blue,
                        size: 30.sp,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
