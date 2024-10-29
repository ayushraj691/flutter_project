// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, unnecessary_null_comparison, sized_box_for_whitespace, non_constant_identifier_names, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_toast.dart';

class GeneralMethods {

  static Future<void> launchMyUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw "could not launch $url";
    }
  }

  launchURL(String uri) async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      launchUrl(Uri.parse(uri));
    } else {
    throw "could not launch $uri";
  }
  }

  static Future<dynamic> loadingDialog2(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            height: 25,
            width: 25,
            child: Lottie.asset(
                "assets/lottie/updating.json"),
          );
        });
  }


  static void showPopup(BuildContext context,String text1,String text2,VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Main dialog content
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "You’re about to $text1 items",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: Constants.Sofiafontfamily,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                     Text(
                      text2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.Sofiafontfamily,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "No, keep it",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              onDelete();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Yes, delete",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -10,
                right: -10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.close, color: Colors.black, size: 18),
                  ),
                ),
              ),

              Positioned(
                top: -35,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), // Adjust this value as needed
                    topRight: Radius.circular(10), // Adjust this value as needed
                  ),
                  child: Container(
                    color: Colors.white,
                    height: 60,
                    width: 60,
                    child: Icon(Icons.delete, color: Colors.grey, size: 30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  // static Future<void> initConnectivity() async {
  //   AuthController authController = Get.find<AuthController>();
  //   print("${authController.connectionStatus.value}-------------------------------------");
  //   authController.connectivitySubscription = authController
  //       .connectivity.onConnectivityChanged
  //       .listen(updateConnectionStatus);
  //
  //   ConnectivityResult result = ConnectivityResult.none;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await authController.connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //     print(" my connectivity error ============= =======  ");
  //   }
  //
  //   /// If the widget was removed from the tree while the asynchronous platform
  //   /// message was in flight, we want to discard the reply rather than calling
  //   /// setState to update our non-existent appearance.
  //
  //   return updateConnectionStatus(result);
  // }
  //
  // static Future<void> updateConnectionStatus(ConnectivityResult result) async {
  //   AuthController authController = Get.find<AuthController>();
  //   authController.noInternetCount.value = 0;
  //
  //   print("update connection method called ----------------");
  //   print(authController.connectionStatus.value);
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //       {
  //         authController.connectionStatus.value = result.toString();
  //
  //         break;
  //       }
  //     case ConnectivityResult.mobile:
  //       {
  //         authController.connectionStatus.value = result.toString();
  //         break;
  //       }
  //     case ConnectivityResult.none:
  //       {
  //         authController.connectionStatus.value = result.toString();
  //
  //         if (authController.noInternetCount.value == 0) {
  //           MyToast.toast("There is no active internet connection");
  //           authController.noInternetCount.value++;
  //         }
  //         authController.noInternetCount.value++;
  //         break;
  //       }
  //
  //     default:
  //       authController.connectionStatus.value = 'Failed to get connectivity.';
  //       break;
  //   }
  // }

  ///-------------------------Regex----------------------------

  ///            for Pan card regex

  static bool validatePan(String panNumber) {
    const pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(panNumber);
  }
  ///        for voter Id Regex

  static bool validateVoterId(String voterId) {
    const pattern = r'^[A-Z]{3}[0-9]{7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(voterId);
  }
  ///    for Driving License Regex

  static bool validateDrivingLicense(String licenseNumber) {
    // Adjust the pattern based on the specific format of the driving license number
    const  regex = "^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}" +
        "|([a-zA-Z]{2}[0-9]{2}[\\/][a-zA-Z]{3}[\\/][0-9]{2}[\\/][0-9]{5})" +
        "|([a-zA-Z]{2}[0-9]{2}(N)[\\-]{1}((19|20)[0-9][0-9])[\\-][0-9]{7})" +
        "|([a-zA-Z]{2}[0-9]{14})" +
        "|([a-zA-Z]{2}[\\-][0-9]{13})" +
        "|([A-Z]{2}[0-9] [0-9]{4}[0-9]{7})";
    final regExp = RegExp(regex);
    return regExp.hasMatch(licenseNumber);
  }


  ///    for Email regex

  static bool isValidEmail(String email) {
    // Regular expression for validating an email
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  /// for IFSC Code regex

  static bool isValidIFSCCode(String ifsc) {
    String pattern = r'^[A-Za-z]{4}\d{7}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(ifsc);
  }

  static bool isValidBankAccountNumber(String acc) {
    String pattern = r'^\d{9,18}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(acc);
  }


  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static bool isPanCardValid(String value) {
    RegExp reg = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return reg.hasMatch(value);
    }

    static bool isDLValid(String value){
      RegExp reg = RegExp(
          r"^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}" +
              r"|([a-zA-Z]{2}[0-9]{2}[\\/][a-zA-Z]{3}[\\/][0-9]{2}[\\/][0-9]{5})" +
              r"|([a-zA-Z]{2}[0-9]{2}(N)[\\-]{1}((19|20)[0-9][0-9])[\\-][0-9]{7})" +
              r"|([a-zA-Z]{2}[0-9]{14})" +
              r"|([a-zA-Z]{2}[\\-][0-9]{13})" +
              r"|([A-Z]{2}[0-9] [0-9]{4}[0-9]{7})$");

      return reg.hasMatch(value);

    }

  static bool isValidPassport(String passport) {
    String pattern = r'^[A-PR-WY-Z][1-9]\\d\\s?\\d{4}[1-9]$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(passport);
  }

  static bool isValidGstNumber(String gst) {
    String pattern =
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(gst);
  }

  static bool isValidCINNumber(String cin) {
    String pattern =
        r'^([LUu]{1})([0-9]{5})([A-Za-z]{2})([0-9]{4})([A-Za-z]{3})([0-9]{6})$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(cin);
  }


  static String getAcronym(String fullName) {
    if (fullName.isEmpty) return ''; // Return empty if the input string is empty
    List<String> words = fullName.split(" ");
    String acronym = words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : "").join();

    // Return only the first two letters of the acronym
    return acronym.length > 2 ? acronym.substring(0, 2) : acronym;
  }
  static String maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) {
      return accountNumber; // Return as is if less than or equal to 4 digits
    }
    String lastFourDigits = accountNumber.substring(accountNumber.length - 4);
    String maskedPart = 'x' * (accountNumber.length - 4); // Mask with asterisks
    return '$maskedPart $lastFourDigits';
  }

}



class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.5, 0, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
