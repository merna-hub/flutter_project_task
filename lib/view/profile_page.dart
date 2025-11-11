import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E8FF),
      body: Column(
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF9C6ADE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'your_profile'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                transform: Matrix4.translationValues(0, -60, 0),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFFF0E8FF),
                      child: Icon(Icons.person, size: 70, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Merna Eid',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Flutter dev.',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "select_language".tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RadioListTile<String>(
                      value: 'en',
                      groupValue: selectedLang,
                      activeColor: const Color(0xFF9C6ADE),
                      title: Row(
                        children: [
                          Image.asset('assets/images/Flag_of_the_United_States.svg.png', width: 35),
                          const SizedBox(width: 10),
                          const Text(
                            'English',
                            style: TextStyle(fontSize: 16),
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
                      activeColor: const Color(0xFF9C6ADE),
                      title: Row(
                        children: [
                          Image.asset('assets/images/egypt.jpg', width: 35),
                          const SizedBox(width: 10),
                          const Text(
                            'العربية',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() => selectedLang = value!);
                        context.setLocale(const Locale('ar'));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
