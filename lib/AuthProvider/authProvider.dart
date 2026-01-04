import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthProvider() {
    user = _auth.currentUser;
    _auth.authStateChanges().listen((User? newUser) {
      user = newUser;
      notifyListeners();
    });
  }

  // Sign Up
  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      user = userCredential.user;
      notifyListeners();
      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign In
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      notifyListeners();
      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
