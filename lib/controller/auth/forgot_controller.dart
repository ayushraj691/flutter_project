import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/login_model/ReqForgotPassword.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/my_toast.dart';

class ForgotPasswordController extends GetxController {
  var variableController = Get.find<VariableController>();

  final Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<bool> emailValid = true.obs;
  var emailErrorMessage = null;
  final FocusNode emailFocusNode = FocusNode();

  bool emailValidation(BuildContext context) {
    if (emailController.value.text.isEmpty) {
      emailValid = false.obs;
      emailErrorMessage = 'Email is required';
      FocusScope.of(context).requestFocus(emailFocusNode);
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.value.text)) {
      emailValid = false.obs;
      emailErrorMessage = 'Invalid Email';
      FocusScope.of(context).requestFocus(emailFocusNode);
      return false;
    } else {
      emailValid = true.obs;
      return true;
    }
  }

  getForgotPassword() async {
    variableController.loading.value = true;
    ReqForgotPassword reqForgotPassword = ReqForgotPassword(
      email: emailController.value.text.trim(),
    );
    debugPrint(json.encode(reqForgotPassword.toJson()));
    var res = await ApiCall.putApiCallWithoutToken(
      MyUrls.forgotPassword,
      reqForgotPassword,
    );
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      try {
        var decodedResponse = json.decode(res);
        String message = decodedResponse['message'];
        MyToast.toast(message);
        emailController.value.clear();
        Get.back();
      } catch (e) {
        debugPrint("JSON Decoding Error: $e");
        MyToast.toast("Unexpected response format");
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }
}
