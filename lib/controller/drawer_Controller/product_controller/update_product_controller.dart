import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../network/api_call/url.dart';
import '../../../utils/common_variable.dart';
import '../../../utils/general_methods.dart';
import '../../../utils/my_toast.dart';
import '../../variable_controller.dart';
import 'ProductDetailViewController.dart';

class UpdateProductController extends GetxController{
  var productDetailViewController = Get.find<ProductDetailViewController>();
  var variableController = Get.find<VariableController>();

  Rx<TextEditingController> productNameController = TextEditingController().obs;
  Rx<TextEditingController> productIdController = TextEditingController().obs;
  Rx<TextEditingController> productPriceController = TextEditingController().obs;
  Rx<TextEditingController> productDescriptionController = TextEditingController().obs;

  File? selectedFile;

  Future<void> updateProductData(BuildContext context,String id) async {
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
          '${MyUrls.BASE_URL}/${MyUrls.updateProduct}/$id');
      var request = http.MultipartRequest('PUT', uri);
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
          MyToast.toast("Product update successfully.");
          Get.back();
        } else {
          MyToast.toast("Something went wrong.");
        }
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        MyToast.toast("Failed to update product. Please try again.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      MyToast.toast("An error occurred while uploading the product.");
    } finally {
      variableController.loading.value = false;
    }
  }
}