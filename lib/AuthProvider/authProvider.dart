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
        'createdAt': Timestamp.now(),
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

  Future<String?> signIn(String email, String password) async {
    try {
      _setLoading(true);

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await fetchUserData();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'Login cancelled';

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await _auth.signInWithCredential(credential);
      user = userCredential.user;

      final doc =
      await _firestore.collection('users').doc(user!.uid).get();

      if (!doc.exists) {
        String googleUsername =
            user!.displayName ?? user!.email!.split('@')[0];

        await _firestore.collection('users').doc(user!.uid).set({
          'uid': user!.uid,
          'username': googleUsername,
          'email': user!.email,
          'profileImage': null,
          'createdAt': Timestamp.now(),
        });

        username = googleUsername;
        profileImageUrl = null;
      } else {
        username = doc.data()?['username'];
        profileImageUrl = doc.data()?['profileImage'];
      }

      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    if (user == null) return;

    final doc =
    await _firestore.collection('users').doc(user!.uid).get();

    if (doc.exists) {
      final data = doc.data();
      username = data?['username'] ?? "No Username";
      profileImageUrl = data?['profileImage'];
      notifyListeners();
    }
  }

  Future<void> updateUsername(String newUsername) async {
    if (user == null) return;

    await _firestore.collection('users').doc(user!.uid).update({
      'username': newUsername,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    username = newUsername;
    notifyListeners();
  }

  Future<void> uploadProfileImage(File image) async {
    if (user == null) return;

    try {
      _setLoading(true);

      final ref = FirebaseStorage.instance
          .ref()
          .child('users/${user!.uid}/profile.jpg');

      await ref.putFile(image);
      debugPrint("✅ Image uploaded");

      final url = await ref.getDownloadURL();
      debugPrint("✅ Image URL: $url");

      await _firestore.collection('users').doc(user!.uid).update({
        'profileImage': url,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      profileImageUrl = "$url?ts=${DateTime.now().millisecondsSinceEpoch}";
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Upload image error: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    user = null;
    username = null;
    profileImageUrl = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  String get userEmail => user?.email ?? "No Email";
  String get userName => username ?? "No Username";
  String? get userProfileImage => profileImageUrl;
}
