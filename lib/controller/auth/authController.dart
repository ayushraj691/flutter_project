import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/login_model/ReqLogin.dart';
import 'package:paycron/model/login_model/ResLogin.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/app_home_screen/home_screen.dart';
import 'package:paycron/views/dashboard/bottom_floating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  ///------------------- Internet Connectivity--------------
  var noInternetCount = 0.obs;
  var connectionStatus = 'ConnectivityResult.none'.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  ///----------login------------------------
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> userPasswordController =
      TextEditingController().obs;
  RxBool isObsecureForLogin = true.obs;
  var checkBox = false.obs;
  var variableController = Get.find<VariableController>();

  getLogin() async {
    variableController.loading.value = true;
    ReqLogin reqLogin = ReqLogin(
        email: emailController.value.text,
        password: userPasswordController.value.text);
    debugPrint(json.encode(reqLogin.toJson()));
    var res = await ApiCall.postApiCall(MyUrls.login, reqLogin, '');
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResLogin resLogin = ResLogin.fromJson(res);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("isLogin", "true");
      variableController.loading.value = false;
      debugPrint("********flag**********${"USERNAME"}****");
      preferences.setString("EMAIL", resLogin.email);
      preferences.setString("VERIFIED", resLogin.verified.toString());
      preferences.setString("USER_ID", resLogin.userid);
      preferences.setString("USER_NAME", resLogin.username);
      preferences.setString("ROLE", resLogin.role);
      preferences.setString("POSITION", resLogin.position);
      preferences.setInt("BUSINESS_CHECK", resLogin.businesscheck);
      preferences.setString("TOKEN", resLogin.token);
      CommonVariable.getClientDetails();
      if (resLogin.businesscheck == 1) {
        Get.off(const PaycronFloatingBottomBar());
        emailController.value.clear();
        userPasswordController.value.clear();
      } else {
        if (resLogin.role == "merchant") {
          Get.offAll(const HomeScreen());
          emailController.value.clear();
          userPasswordController.value.clear();
        }
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }
}
