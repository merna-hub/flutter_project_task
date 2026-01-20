import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_project_task/view/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../AuthProvider/authProvider.dart';
import '../themes/app_colors.dart';
import '../themes/theme_provider.dart';
import '../utels/navigation_buttom.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String selectedLang;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery and upload
  Future<void> _pickImage(AuthProvider authProvider) async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (image != null) {
      setState(() => _profileImage = File(image.path));
      await authProvider.uploadProfileImage(_profileImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    selectedLang = context.locale.languageCode;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background(themeProvider.isDark),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ButtomNavigationBar()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary(themeProvider.isDark),
          ),
        ),
        title: Text("profile".tr()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.card(themeProvider.isDark),
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55.r,
                        backgroundColor:
                        AppColors.cardAlt(themeProvider.isDark),
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (authProvider.profileImageUrl != null
                            ? NetworkImage(authProvider.profileImageUrl!)
                        as ImageProvider
                            : null),
                        child: (_profileImage == null &&
                            authProvider.profileImageUrl == null)
                            ? Icon(Icons.person,
                            size: 70.r, color: Colors.grey[700])
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => _pickImage(authProvider),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.edit,
                                size: 20.r, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          authProvider.userName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                            AppColors.textPrimary(themeProvider.isDark),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () async {
                          final TextEditingController dialogController =
                          TextEditingController(text: authProvider.userName);

                          final newName = await showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Edit Username".tr()),
                              content: TextField(
                                controller: dialogController,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "Enter new username".tr()),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, null),
                                  child: Text("Cancel".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, dialogController.text.trim());
                                  },
                                  child: Text("Update".tr()),
                                ),
                              ],
                            ),
                          );

                          if (newName != null && newName.isNotEmpty) {
                            await authProvider.updateUsername(newName);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Username updated".tr())),
                            );
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          size: 25.r,
                          color: AppColors.textPrimary(themeProvider.isDark),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),
                  Text(
                    authProvider.userEmail,
                    style: TextStyle(
                      color: AppColors.textSecondary(themeProvider.isDark),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "select_language".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary(themeProvider.isDark),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  RadioListTile<String>(
                    value: 'en',
                    groupValue: selectedLang,
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/images/Flag_of_the_United_States.svg.png',
                          width: 35.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'English'.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary(themeProvider.isDark),
                          ),
                        ),
                      ],
                    ),
                    onChanged: (value) {
                      setState(() => selectedLang = value!);
                      context.setLocale(const Locale('en'));
                    },
                  ),
                  RadioListTile<String>(
                    value: 'ar',
                    groupValue: selectedLang,
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/images/egypt.jpg',
                          width: 35.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Arabic'.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary(themeProvider.isDark),
                          ),
                        ),
                      ],
                    ),
                    onChanged: (value) {
                      setState(() => selectedLang = value!);
                      context.setLocale(const Locale('ar'));
                    },
                  ),
                  SizedBox(height: 20.h),
                  SwitchListTile(
                    title: Text(
                      "dark mode".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary(themeProvider.isDark),
                      ),
                    ),
                    value: themeProvider.isDark,
                    onChanged: (value) => themeProvider.toggleTheme(value),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await authProvider.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Logged out successfully")),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()),
                            (route) => false,
                      );
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
