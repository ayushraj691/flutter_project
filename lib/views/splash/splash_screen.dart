import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_home_screen/home_screen.dart';
import 'package:paycron/views/dashboard/bottom_floating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/color_constants.dart';
import '../../utils/common_variable.dart';
import '../../utils/string_constants.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    callMyMethod();
  }

  callMyMethod() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CommonVariable.getClientDetails();
    Timer(
        const Duration(seconds: 2),
        () => (preferences.getString("isLogin") == null)
            ? Get.off(const LoginScreen())
            : CommonVariable.businessCheck.value == 1
                ? Get.off(const PaycronFloatingBottomBar())
                : Get.off(const HomeScreen()));
    FocusScope.of(context).unfocus();
    // Timer(Duration(seconds: 3), () {
    //   if (preferences.getString("isLogin") == null) {
    //     Get.off(LoginScreen());
    //   } else {
    //     String? role = CommonVariable.role.value;
    //     print(role);
    //     print(preferences.getString("isLogin"));
    //     CommonVariable.getClientDetails();
    //     if (role == "merchant") {
    //       Get.offAll(const HomeScreen());
    //     } else if (role == "Admin") {
    //       Get.offAll(const HomeScreen());
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhiteColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.paycronLogo)
                    .animate()
                    .fadeIn(duration: 1200.ms)
                    .scale(delay: 600.ms, duration: 800.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 20),
                Text(
                  Constants.appName,
                  textScaleFactor: 1.0,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                ).animate().fadeIn(duration: 1500.ms).slideY(begin: 0.5, end: 0.0),
              ],
            ),
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}