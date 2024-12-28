import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResAllBussinessModel.dart';
import 'package:paycron/model/funds_model/ResFundsData.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class AllBussinessController extends GetxController{
  var variableController = Get.find<VariableController>();

  final List<ResAllBussiness> allBussinessList =
      <ResAllBussiness>[].obs;

  getAllBUssiness () async {
    variableController.loading.value = true;
    var res = await ApiCall.getApiCall(MyUrls.allbusiness,CommonVariable.token.value,CommonVariable.userId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      allBussinessList.clear();
      for (int i = 0; i < res.length; i++) {
        allBussinessList
            .add(ResAllBussiness.fromJson(res[i]));
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  Future<void> getFunds(String id) async {
    variableController.loading.value = true;
    debugPrint("************$id*************");
    try {
      var res = await ApiCall.getApiCall(MyUrls.fundsOfBusiness, CommonVariable.token.value, id);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");
      if (res != null) {
        var fundsData = ResFundsData.fromJson(res);
        variableController.loading.value = false;
        CommonVariable.approvedBalance.value = fundsData.available is int ? fundsData.available.toDouble() : fundsData.available as double;
        CommonVariable.pendingBalance.value = fundsData.current;
      } else {
        MyToast.toast("Failed to retrieve customer data");
        variableController.loading.value = false;
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
      variableController.loading.value = false;
    }
  }

}