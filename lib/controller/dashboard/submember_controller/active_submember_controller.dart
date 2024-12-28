import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/profileModel/ResAllSubmemberModel.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';
class ActiveSubmemberController extends GetxController{
  var variableController = Get.find<VariableController>();

  List<ResAllSubmemberModel> activeSubmemberList =
      List<ResAllSubmemberModel>.empty(growable: true).obs;


  getActiveSubmember(
      String userId,
      String query,
      String argument,
      String sort,
      ) async {
    variableController.loading.value = true;

    try {
      activeSubmemberList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.allSubmemberByUser,
          id: userId,
          token: CommonVariable.token.value,
          args: argument,
          query: query,
          page: 1,
          size: 10,
          yes: 'yes',
          urlIdentifier: '1');

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        List<ResAllSubmemberModel> submemberList =
        JsonUtils.parseCustomerData(res);
        activeSubmemberList.addAll(submemberList);

        if (activeSubmemberList.isEmpty) {
          MyToast.toast("No Submember found.");
        }
      } else {
        MyToast.toast("Something went wrong. Please try again.");
        variableController.loading.value = false;
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
      MyToast.toast("Something went wrong: ${e.toString()}");
    } finally {
      variableController.loading.value = false;
    }
  }
}

class JsonUtils {
  static List<ResAllSubmemberModel> parseCustomerData(
      dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed['data'] as List)
          .map((json) => ResAllSubmemberModel.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      return (jsonResponse['data'] as List)
          .map((json) => ResAllSubmemberModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }

}