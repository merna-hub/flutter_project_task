import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project_task/utels/navigation_buttom.dart';
import 'Controller/product_controller.dart';
import 'Controller/cart_controller.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); // Initialize EasyLocalization

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            locale: context.locale, // <-- set current locale
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const ButtomNavigationBar(),
          );
        },
      ),
    );
  }
}

/// in the button to switch the lang //////
// context.setLocale(Locale('ar')); // switch to Arabic
// context.setLocale(Locale('en')); // switch to English
