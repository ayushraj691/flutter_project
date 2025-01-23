import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/my_toast.dart';

import 'all_product_controller.dart';

class AddProductController extends GetxController {
  var variableController = Get.find<VariableController>();
  var allTabProductController = Get.find<AllTabProductController>();

  Rx<TextEditingController> productNameController = TextEditingController().obs;
  Rx<TextEditingController> productIdController = TextEditingController().obs;
  Rx<TextEditingController> productPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> productDescriptionController =
      TextEditingController().obs;
  final FocusNode productNameFocusNode = FocusNode();
  final FocusNode productIdFocusNode = FocusNode();
  final FocusNode productPriceFocusNode = FocusNode();
  final FocusNode productDescriptionFocusNode = FocusNode();

  Rx<bool> productNameValid = true.obs;
  Rx<bool> productPriceValid = true.obs;

  var productNameMessage = null;
  var productPriceMessage = null;

  File? selectedFile;

  void clearAllField() {
    productNameController.value.clear();
    productIdController.value.clear();
    productPriceController.value.clear();
    productDescriptionController.value.clear();
    selectedFile = null;
  }

  bool validation(BuildContext context) {
    if (productNameController.value.text.isEmpty) {
      productNameValid = false.obs;
      productNameMessage = 'Product Name is required';
      FocusScope.of(context).requestFocus(productNameFocusNode);
      return false;
    } else if (productPriceController.value.text.isEmpty) {
      productPriceValid = false.obs;
      productPriceMessage = 'Product Price is required';
      FocusScope.of(context).requestFocus(productPriceFocusNode);
      return false;
    } else {
      productNameValid = productPriceValid = true.obs;
      return true;
    }
  }

  Future<void> insertProductData(BuildContext context) async {
    GeneralMethods.loadingDialog(context);
    variableController.loading.value = true;
    final Map<String, dynamic> formData = {
      'pro_name': productNameController.value.text,
      'pro_id': productIdController.value.text,
      'description': productDescriptionController.value.text,
      'price': productPriceController.value.text,
      'app': "1",
    };

    try {
      final uri = Uri.parse(
          '${MyUrls.BASE_URL}/${MyUrls.addProduct}/${CommonVariable.businessId.value}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['pro_name'] = formData['pro_name'];
      request.fields['pro_id'] = formData['pro_id'];
      request.fields['description'] = formData['description'];
      request.fields['price'] = formData['price'];
      request.fields['app'] = formData['app'];
      if (selectedFile != null && selectedFile!.existsSync()) {
        List<int> imageBytes = await selectedFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        request.fields['image_app'] = 'data:image/png;base64,$base64Image';
        debugPrint("*******image****${request.fields}********");
      } else {
        debugPrint("No image file selected. Sending null for 'image_app'.");
        request.fields['image_app'] = '';
      }
      request.headers.addAll({
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CommonVariable.token.value}',
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var res = json.decode(responseData.body);
        debugPrint("*************************");
        debugPrint("*****$res*******");
        debugPrint("*************************");
        if (res != null) {
          MyToast.toast("Product added successfully.");
          Get.back();
          allTabProductController.callMethod();
        } else {
          MyToast.toast("Something went wrong.");
        }
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        MyToast.toast("Failed to add product. Please try again.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      MyToast.toast("An error occurred while uploading the product.");
    } finally {
      variableController.loading.value = false;
    }
  }
}
