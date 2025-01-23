import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResSingleCustomerModel.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllRecentTransaction.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class CustomerDetailViewController extends GetxController {
  ///---------------------person Detail---------------
  RxString personName = "".obs;
  RxString personMobileNumber = "".obs;
  RxString personEmail = "".obs;
  RxString personDescription = "".obs;

  final List<BankId> allBankList = <BankId>[].obs;

  final List<ResAllRecentTransaction> allRecentTransactionList =
      <ResAllRecentTransaction>[].obs;

  var filterValue = 'All'.obs;
  var filterItems = <String>[
    'All',
    'New',
    'Verify',
    'Downloaded',
    'Cancel',
    'Delete',
    'Reimbursement'
  ].obs;

  var variableController = Get.find<VariableController>();

  final List<ResSingleData> allSingleDataList = <ResSingleData>[].obs;

  TextEditingController searchController = TextEditingController();

  Map<String, dynamic> getArgumentMap(String filterValue) {
    Map<String, dynamic> argumentMap = {};

    if (filterValue == 'All') {
      argumentMap = {"": ""};
    } else if (filterValue == 'New') {
      argumentMap = {
        "pay_status": "0",
        "is_deleted_request": false,
        "is_deleted": false,
        "verification_status": false,
        "download_bymerchant": false,
        "\$or": [
          {
            "\$and": [
              {"pay_mode": "0"},
              {"is_schedule": false},
            ]
          },
          {
            "\$and": [
              {"pay_mode": "1"},
              {"is_schedule": true},
            ]
          },
        ],
      };
    } else if (filterValue == 'Verify') {
      argumentMap = {
        "pay_status": {
          "\$nin": [5],
        },
        "is_deleted_request": false,
        "verification_status": true,
        "download_bymerchant": false,
        "is_deleted": false,
      };
    } else if (filterValue == 'Downloaded') {
      argumentMap = {
        "pay_status": {
          "\$nin": [5, 6, 7],
        },
        "is_deleted_request": false,
        "is_deleted": false,
        "download_bymerchant": true,
      };
    } else if (filterValue == 'Cancel') {
      argumentMap = {
        "pay_status": "5",
      };
    } else if (filterValue == 'Delete') {
      argumentMap = {
        "is_deleted_request": true,
        "is_deleted": false,
        "pay_status": {
          "\$nin": [5, 6, 7],
        },
      };
    } else if (filterValue == 'Reimbursement') {
      argumentMap = {
        "is_deleted_request": {
          "\$in": [true, false],
        },
        "is_deleted": true,
      };
    } else {
      argumentMap = {"": ""};
    }

    return argumentMap;
  }

  disableAccount(String bankId) async {
    variableController.loading.value = true;
    var res =
        await ApiCall.postApiCallWithoutBody(MyUrls.changeBankStatus, bankId);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      MyToast.toast("Account Disable");
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  Future<void> getSingleData(String id) async {
    variableController.loading.value = true;

    try {
      var res = await ApiCall.getApiCall(
          MyUrls.singleCustomer, CommonVariable.token.value, id);

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null && res is Map<String, dynamic>) {
        variableController.loading.value = false;

        allSingleDataList.clear();
        allBankList.clear();

        var singleCustomerData = ResSingleData.fromJson(res);
        allSingleDataList.add(singleCustomerData);

        if (allSingleDataList.isNotEmpty &&
            allSingleDataList[0].bankId.isNotEmpty) {
          allBankList.addAll(allSingleDataList[0].bankId);
        }
        personName.value = allSingleDataList[0].info.custName ?? "";
        personMobileNumber.value = allSingleDataList[0].info.mobile ?? "";
        personEmail.value = allSingleDataList[0].info.email ?? "";
        personDescription.value = allSingleDataList[0].info.description ?? "";
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

  Future<void> getAllRecentTransactionData(
    String businessId,
    String query,
    String argument,
    String sort,
  ) async {
    variableController.loading.value = true;
    try {
      allRecentTransactionList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.allTransactionsByCustomerId,
          id: businessId,
          token: CommonVariable.token.value,
          args: argument,
          query: query,
          endDate: '',
          page: 1,
          size: 21,
          startDate: '',
          yes: 'yes',
          urlIdentifier: '1');

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        List<ResAllRecentTransaction> RecentTransactionList =
            JsonUtils.parseCustomerData(res);
        allRecentTransactionList.addAll(RecentTransactionList);

        if (allRecentTransactionList.isEmpty) {
          // MyToast.toast("No Recent Transaction found.");
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
  static List<ResAllRecentTransaction> parseCustomerData(dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed['data'] as List)
          .map((json) => ResAllRecentTransaction.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      return (jsonResponse['data'] as List)
          .map((json) => ResAllRecentTransaction.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }
}
