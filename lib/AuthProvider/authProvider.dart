import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;
  String? username;
  String? profileImageUrl;
  bool isLoading = false;

  AuthProvider() {
    _auth.authStateChanges().listen((firebaseUser) async {
      user = firebaseUser;
      if (user != null) {
        await fetchUserData();
      } else {
        username = null;
        profileImageUrl = null;
      }
      notifyListeners();
    });
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // ================= SIGN UP =================
  Future<String?> signUp(
      String email, String password, String generatedUsername) async {
    try {
      _setLoading(true);

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      await _firestore.collection('users').doc(user!.uid).set({
        'uid': user!.uid,
        'username': generatedUsername,
        'email': email,
        'profileImage': null,
        'createdAt': FieldValue.serverTimestamp(),
      });

      username = generatedUsername;
      profileImageUrl = null;

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  // ================= SIGN IN =================
  Future<String?> signIn(String email, String password) async {
    try {
      _setLoading(true);

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await fetchUserData();
      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  // ================= GOOGLE SIGN IN =================
  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);

      // ⭐⭐⭐ ده أهم سطر
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return 'Login cancelled';
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await _auth.signInWithCredential(credential);

      user = userCredential.user;
      if (user == null) return 'User is null';

      final userDoc =
      _firestore.collection('users').doc(user!.uid);

      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        await userDoc.set({
          'uid': user!.uid,
          'username':
          user!.displayName ?? user!.email?.split('@')[0],
          'email': user!.email,
          'profileImage': user!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await fetchUserData();
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: ${e.code}");
      return e.message;
    } catch (e) {
      debugPrint('❌ Google Sign-In Error: $e');
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // ================= FETCH USER DATA =================
  Future<void> fetchUserData() async {
    if (user == null) return;

    final doc =
    await _firestore.collection('users').doc(user!.uid).get();

    if (doc.exists) {
      final data = doc.data();
      username = data?['username'] ?? "No Username";
      profileImageUrl = data?['profileImage'];
    }
  }

  // ================= UPDATE USERNAME =================
  Future<void> updateUsername(String newUsername) async {
    if (user == null) return;

    await _firestore.collection('users').doc(user!.uid).update({
      'username': newUsername,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    username = newUsername;
    notifyListeners();
  }

  // ================= UPLOAD PROFILE IMAGE =================
  Future<void> uploadProfileImage(File image) async {
    if (user == null) return;

    try {
      _setLoading(true);

      final ref = FirebaseStorage.instance
          .ref()
          .child('users/${user!.uid}/profile.jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      await _firestore.collection('users').doc(user!.uid).update({
        'profileImage': url,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      profileImageUrl =
      "$url?ts=${DateTime.now().millisecondsSinceEpoch}";
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Upload image error: $e");
    } finally {
      _setLoading(false);
    }
  }

  // ================= SIGN OUT =================
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    user = null;
    username = null;
    profileImageUrl = null;

    notifyListeners();
  }

  // ================= RESET PASSWORD =================
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ================= GETTERS =================
  bool get isLoggedIn => user != null;
  String get userEmail => user?.email ?? "No Email";
  String get userName => username ?? "No Username";
  String? get userProfileImage => profileImageUrl;
}
