import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResCustomerListModel.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class CreatePaymentController extends GetxController{

  var variableController = Get.find<VariableController>();

  Rx<TextEditingController> customerListTextController = TextEditingController().obs;
  Rx<TextEditingController> checkNumberTextController = TextEditingController().obs;
  Rx<TextEditingController> memoTextController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberTextController = TextEditingController().obs;

  List<ResCustomerList> customerList =
      List<ResCustomerList>.empty(growable: true).obs;

  final List<BankId> allBankList =
      <BankId>[].obs;



  Future<void> getCustomerList(String id) async {
    variableController.loading.value = true;

    try {
      var res = await ApiCall.getApiCall(MyUrls.customerList, CommonVariable.token.value, id);

      debugPrint("*************************");
      debugPrint("API Response: $res");  // Check the structure of the response
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        customerList.clear();
        allBankList.clear();

        // Check if response is a list
        if (res is List) {
          // Parse each item in the list into a ResCustomerList
          res.forEach((item) {
            var customerListData = ResCustomerList.fromJson(item);
            customerList.add(customerListData);
          });
        } else if (res is Map<String, dynamic>) {
          // If it's a single object, handle it as a Map
          var customerListData = ResCustomerList.fromJson(res);
          customerList.add(customerListData);
        } else {
          // Handle unexpected response structure
          MyToast.toast("Unexpected data format");
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