import 'package:flutter/material.dart';
import 'package:flutter_project_task/view/home_screen.dart';
import 'package:provider/provider.dart';

import '../AuthProvider/authProvider.dart';
import '../utels/navigation_buttom.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login here",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Welcome back you've been missed!",
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
            const SizedBox(height: 30),

            /// Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot your password?"),
              ),
            ),

            const SizedBox(height: 20),

            /// Sign In Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ButtomNavigationBar()));
                String? result = await authProvider.signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

                if (result != null) {
                  // لو فيه خطأ
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                } else {
                  // لو نجحت
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign In Successful")),
                  );
                  // ممكن تعمل نافيجيشن للصفحة الرئيسية بعد تسجيل الدخول
                  // Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text(
                "Sign in",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Or continue with"),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.g_mobiledata, size: 40),
                SizedBox(width: 15),
                Icon(Icons.facebook, size: 30),
                SizedBox(width: 15),
                Icon(Icons.apple, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
