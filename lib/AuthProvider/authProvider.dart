import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;
  bool isLoading = false;

  AuthProvider() {
    user = _auth.currentUser;
    _auth.authStateChanges().listen((User? newUser) {
      user = newUser;
      notifyListeners();
    });
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<String?> signUp(String email, String password) async {
    try {
      setLoading(true);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      notifyListeners();
      setLoading(false);
      return null;
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      return e.message;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      setLoading(true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      notifyListeners();
      setLoading(false);
      return null;
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      return e.message;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //  Logout
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    user = null;
    notifyListeners();
  }

  Future<String?> signInWithGoogle() async {
    try {
      setLoading(true);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setLoading(false);
        return 'Login cancelled';
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
      notifyListeners();

      setLoading(false);
      return null;
    } catch (e) {
      setLoading(false);
      return e.toString();
    }
  }
}
