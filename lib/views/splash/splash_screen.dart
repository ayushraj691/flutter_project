import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_home_screen/home_screen.dart';
import 'package:paycron/views/auth/app_intro_screen.dart';
import 'package:paycron/views/auth/login_screen.dart';
import 'package:paycron/views/dashboard/bottom_floating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/color_constants.dart';
import '../../utils/common_variable.dart';
import '../../utils/string_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    Timer( const Duration(seconds: 2), () =>
    (preferences.getString("isLogin") == null)
        ? Get.off(const AppIntroScreen())
        :CommonVariable.businessCheck.value==1
        ?Get.off(const PaycronFloatingBottomBar()):Get.off(const HomeScreen()));

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
      body:Container(
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
                Image.asset(ImageAssets.paycronLogo),
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
                ),
              ],
            ),
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20), // Padding from the bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class AppVersionAndUrl extends StatelessWidget {
//   const AppVersionAndUrl(
//       {Key? key,
//       required this.color,
//       required this.textOne,
//       required this.textTwo})
//       : super(key: key);
//
//   final dynamic color;
//   final String textOne;
//   final String textTwo;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 35,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Text(
//                 textOne,
//                 textScaleFactor: 1.0,
//                 style: TextStyle(color: Color(color)),
//               )),
//           GestureDetector(
//             onTap: () {
//               GeneralMethods.launchMyUrl(Constants.compWebUrl);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Text(
//                 textTwo,
//                 textScaleFactor: 1.0,
//                 style: TextStyle(
//                   color: Color(color),
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
