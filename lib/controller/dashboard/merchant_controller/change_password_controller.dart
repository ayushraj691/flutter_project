import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/profileModel/change_password_model/ReqChangePassword.dart';
import 'package:paycron/model/profileModel/change_password_model/ResChangePassword.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class ChangePasswordController extends GetxController {
  var variableController = Get.find<VariableController>();
  var merchantController = Get.find<MerchantController>();

  Rx<TextEditingController> oldPassword = TextEditingController().obs;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isObsecureForCurrentPassword = true.obs;
  RxBool isObsecureForNewPassword = true.obs;
  RxBool isObsecureForConfirmPassword = true.obs;

  getChangePassword() async {
    variableController.loading.value = true;
    ReqChangePassword reqChangePassword =
        ReqChangePassword(password: confirmPassword.text);
    debugPrint(json.encode(reqChangePassword.toJson()));
    var res = await ApiCall.postApiCalltoken(
        MyUrls.resetPassword,
        reqChangePassword,
        CommonVariable.token.value,
        CommonVariable.userId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResChangePassword resChangePassword = ResChangePassword.fromJson(res);
      debugPrint(resChangePassword.message);
      MyToast.toast(resChangePassword.message);
      variableController.loading.value = false;
      Get.back();
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }
}
