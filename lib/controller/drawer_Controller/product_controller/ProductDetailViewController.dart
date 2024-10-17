import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/ResAllRecentTransaction.dart';
import 'package:paycron/model/drawer_model/ResSingleCustomerModel.dart';
import 'package:paycron/model/drawer_model/product_model/ResSingleProductData.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';


class ProductDetailViewController extends GetxController{

  ///---------------------Product Detail---------------
  RxString productName = "".obs;
  RxString productId = "".obs;
  RxString productDescription = "".obs;
  RxString productImage = "".obs;
  RxString productPrice = "".obs;
  RxString createdOn =''.obs;

  var variableController = Get.find<VariableController>();

  final List<ResSingleProductData> allSingleProductDataList =
      <ResSingleProductData>[].obs;

  TextEditingController searchController = TextEditingController();

  Future<void> getSingleProductData(String id) async {
    variableController.loading.value = true;

    try {
      var res = await ApiCall.getApiCall(MyUrls.singleProduct, CommonVariable.token.value, id);

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null && res is Map<String, dynamic>) {
        variableController.loading.value = false;

        allSingleProductDataList.clear();

        var singleProductData = ResSingleProductData.fromJson(res);
        allSingleProductDataList.add(singleProductData);
        productName.value = allSingleProductDataList[0].proName;
        productId.value = allSingleProductDataList[0].proId;
        productDescription.value = allSingleProductDataList[0].description;
        productImage.value = allSingleProductDataList[0].image;
        productPrice.value = allSingleProductDataList[0].price;
        createdOn.value = allSingleProductDataList[0].createdOn;
      } else {
        MyToast.toast("Failed to retrieve product data");
        variableController.loading.value = false;
      }
    } catch (e) {
      // Handle any errors during the API call
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
      variableController.loading.value = false;
    }
  }

}
