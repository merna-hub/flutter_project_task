import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../AuthProvider/authProvider.dart';
import '../utels/navigation_buttom.dart';

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

              // Title
              Text(
                "Login here",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 10.h),

              // Subtitle
              Text(
                "Welcome back you've been missed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
              ),

              SizedBox(height: 30.h),

              /// Email
              TextField(
                controller: emailController,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Email",
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

              /// Password with eye icon
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Password",
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
                    splashRadius: 20,
                    iconSize: 22,
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

              SizedBox(height: 10.h),

              /// Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter your email"),
                        ),
                      );
                      return;
                    }

                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Password reset email sent! Check your inbox."),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: ${e.toString()}"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// Sign In Button
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
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                        ),
                      );
                      return;
                    }

                    String? result = await authProvider.signIn(
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
                          builder: (context) => ButtomNavigationBar(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                "Or continue with",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colors.onSurface.withOpacity(0.7),
                ),
              ),

              SizedBox(height: 15.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_mobiledata, size: 40.sp, color: Colors.blue),
                  SizedBox(width: 15.w),
                  Icon(Icons.facebook, size: 30.sp, color: Colors.blue),
                  SizedBox(width: 15.w),
                  Icon(Icons.apple, size: 30.sp, color: Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
