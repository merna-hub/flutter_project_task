import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_project_task/view/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../AuthProvider/authProvider.dart';
import '../themes/app_colors.dart';
import '../themes/theme_provider.dart';
import '../utels/navigation_buttom.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late String selectedLang;


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    selectedLang = context.locale.languageCode;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background(themeProvider.isDark),

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
                  // Profile Photo
                  CircleAvatar(
                    radius: 55.r,
                    backgroundColor: AppColors.cardAlt(themeProvider.isDark),
                    child: Icon(
                      Icons.person,
                      size: 70.r,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // Name
                  Text(
                    'Merna Eid',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(themeProvider.isDark),
                    ),
                  ),

                  // Subtitle
                  Text(
                    'Flutter dev.',
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

                  // English
                  RadioListTile<String>(
                    value: 'en',
                    groupValue: selectedLang,
                    title: Row(
                      children: [
                        Image.asset('assets/images/Flag_of_the_United_States.svg.png', width: 35.w),
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

                  // Arabic
                  RadioListTile<String>(
                    value: 'ar',
                    groupValue: selectedLang,
                    title: Row(
                      children: [
                        Image.asset('assets/images/egypt.jpg', width: 35.w),
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
                          const SnackBar(content: Text("Logged out successfully")),
                        );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => WelcomeScreen()),
                              (route) => false,
                        );
                      },

                      child: Text("Logout"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
