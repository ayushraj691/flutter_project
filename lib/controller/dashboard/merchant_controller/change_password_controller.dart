import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';


class ChangePasswordController extends GetxController{
  var variableController=Get.find<VariableController>();
  var merchantController = Get.find<MerchantController>();


  Rx<TextEditingController> oldPassword = TextEditingController().obs;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();



  RxBool isObsecureForCurrentPassword = true.obs;
  RxBool isObsecureForNewPassword = true.obs;
  RxBool isObsecureForConfirmPassword = true.obs;


// getChangePassword(ReqChangePassword reqChangePassword) async{
//     variableController.loading.value = true;
//     debugPrint(json.encode(reqChangePassword.toJson()));
//     var res = await ApiCall.postApiCall(MyUrls.getNewUserPassword, reqChangePassword);
//     debugPrint("*************************");
//     debugPrint("*****$res*******");
//     debugPrint("*************************");
//
//     if (res != null) {
//       ResChangePassword resChangePassword = ResChangePassword.fromJson(res);
//       debugPrint(resChangePassword.result);
//       if (resChangePassword.resultFlag == "1") {
//         MyToast.toast(resChangePassword.result);
//         Get.to(const SignInScreen());
//       }else{
//         MyToast.toast(resChangePassword.result);
//         variableController.loading.value = false;
//       }
//     } else {
//       MyToast.toast("Something Went Wrong");
//       variableController.loading.value = false;
//     }
//   }


}