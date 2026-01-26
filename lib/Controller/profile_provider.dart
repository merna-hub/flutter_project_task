import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  File? profileImage;
  final ImagePicker _picker = ImagePicker();


  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      profileImage = File(image.path);
      await saveImagePath(image.path); // نخزن path في SharedPreferences
      notifyListeners();
    }
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
    print("✅ Image path saved: $path");
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');

    if (path != null && path.isNotEmpty) {
      profileImage = File(path);
      notifyListeners();
      print("✅ Image path loaded: $path");
    }
  }
}
