import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Controller/profile_provider.dart';
import '../themes/app_colors.dart';
import '../themes/theme_provider.dart';
import '../utels/navigation_buttom.dart';
import '../AuthProvider/authProvider.dart';
import 'welcome_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String selectedLang;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.loadImage(); // load image from SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    selectedLang = context.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.background(themeProvider.isDark),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ButtomNavigationBar()),
            );
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
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55.r,
                        backgroundColor: AppColors.cardAlt(themeProvider.isDark),
                        backgroundImage: profileProvider.profileImage != null
                            ? FileImage(profileProvider.profileImage!)
                            : AssetImage('assets/images/default_profile.png') as ImageProvider,
                        child: profileProvider.profileImage == null
                            ? Icon(Icons.person,
                            size: 70.r, color: Colors.grey[700])
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => profileProvider.pickImage(),
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
                            color: AppColors.textPrimary(themeProvider.isDark),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () async {
                          final dialogController =
                          TextEditingController(text: authProvider.userName);
                          final newName = await showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: themeProvider.isDark
                                  ? Colors.grey[850]
                                  : Colors.white,
                              title: Text("Edit Username".tr(),
                                  style: TextStyle(
                                      color: AppColors.textPrimary(themeProvider.isDark))),
                              content: TextField(
                                controller: dialogController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: "Enter new username".tr(),
                                  filled: true,
                                  fillColor: themeProvider.isDark
                                      ? Colors.grey[900]
                                      : Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: themeProvider.isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2),
                                  ),
                                ),
                                style: TextStyle(
                                  color: themeProvider.isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, null),
                                  child: Text(
                                    "Cancel".tr(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, dialogController.text.trim());
                                  },
                                  child: Text(
                                    "Update".tr(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          );
                          if (newName != null && newName.isNotEmpty) {
                            await authProvider.updateUsername(newName);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Username updated ✔".tr(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
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
                  RadioListTile<String>(
                    value: 'en',
                    groupValue: selectedLang,
                    title: Text('English').tr(),
                    onChanged: (value) {
                      setState(() => selectedLang = value!);
                      context.setLocale(const Locale('en'));
                    },
                  ),
                  RadioListTile<String>(
                    value: 'ar',
                    groupValue: selectedLang,
                    title: Text('Arabic').tr(),
                    onChanged: (value) {
                      setState(() => selectedLang = value!);
                      context.setLocale(const Locale('ar'));
                    },
                  ),
                  SwitchListTile(
                    title: Text("dark mode".tr()),
                    value: themeProvider.isDark,
                    onChanged: themeProvider.toggleTheme,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await authProvider.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()),
                            (route) => false,
                      );
                    },
                    child: Text("Logout".tr()),
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
