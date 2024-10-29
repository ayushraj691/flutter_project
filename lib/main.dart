import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paycron/bindings/initial_binding.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/theme.dart';
import 'package:paycron/views/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(statusBarColor: AppColors.appWhiteColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pay Cron',
      theme: AppTheme.theme,
      initialBinding: InitialBinding(),
      home: const SplashScreen(),
    );
  }
}



