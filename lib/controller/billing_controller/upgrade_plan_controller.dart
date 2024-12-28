import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/billing_model/ReqPlanUpdate.dart';
import 'package:paycron/model/billing_model/ResGetAllPlans.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/drawer_screen/billing/billing_information.dart';

class UpgradePlanController extends GetxController {

  var variableController = Get.find<VariableController>();

  var selectedPlanIndex = 0.obs;
  void setSelectedPlanIndex(int index) {
    selectedPlanIndex.value = index;
  }


  List<ResGetAllPlans> getAllPlanList =
      List<ResGetAllPlans>.empty(growable: true).obs;


  updatePlane() async {
    variableController.loading.value = true;
    ReqPlanUpdate reqPlanUpdate = ReqPlanUpdate(planId: CommonVariable.temporaryPlanId.value);
    debugPrint(json.encode(reqPlanUpdate.toJson()));
    var res =
    await ApiCall.putApiCall(MyUrls.updatePlane, reqPlanUpdate,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
        variableController.loading.value = false;
        CommonVariable.planId.value='';
        Get.to(const BillingInformation());
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }



  Future<void> getAllPlan() async {
    variableController.loading.value = true;
    try {
      var res = await ApiCall.getApiCallWithoutId(MyUrls.getAllPlans, CommonVariable.token.value);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        List<ResGetAllPlans> allGatewayList = JsonUtils.parseCustomerData(res);
        getAllPlanList.clear();
        getAllPlanList.addAll(allGatewayList);

        if (getAllPlanList.isEmpty) {
          MyToast.toast("No Plan found.");
        }
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

class JsonUtils {
  static List<ResGetAllPlans> parseCustomerData(dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed as List)
          .map((json) => ResGetAllPlans.fromJson(json))
          .toList();
    } else if (jsonResponse is List) {
      return jsonResponse
          .map((json) => ResGetAllPlans.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }
}
