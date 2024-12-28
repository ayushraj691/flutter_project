import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/funds_model/ResAllGateway.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class FundController extends GetxController{

  var variableController = Get.find<VariableController>();

  Rx<TextEditingController> addProofAmountController = TextEditingController().obs;
  var fundsSource = "".obs;
  final FocusNode addProofAmountFocusNode = FocusNode();
  Rx<bool> addProofAmountValid = true.obs;
  var addProofAmountMessage = null;


  File? selectedFile;


  List<ResAllGateway> allGatewayDataList =
      List<ResAllGateway>.empty(growable: true).obs;

  Future<void> getAllGateway() async {
    variableController.loading.value = true;
    try {
      var res = await ApiCall.getApiCallWithoutId(MyUrls.getAllGateway, CommonVariable.token.value);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        List<ResAllGateway> allGatewayList = JsonUtils.parseCustomerData(res);
        allGatewayDataList.clear();
        allGatewayDataList.addAll(allGatewayList);

        if (allGatewayDataList.isEmpty) {
          MyToast.toast("No Gateway found.");
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

  void clearAllField() {
    addProofAmountController.value.clear();
    selectedFile = null;
  }

  bool validation(BuildContext context) {
    if (addProofAmountController.value.text.isEmpty) {
      addProofAmountValid = false.obs;
      addProofAmountMessage = 'Amount is required';
      FocusScope.of(context).requestFocus(addProofAmountFocusNode);
      return false;
    } else if (selectedFile == null) {
      MyToast.toast('Select Product Image');
      return false;
    }else {
      addProofAmountValid = true.obs;
      return true;
    }
  }


  Future<void> insertFundsData() async {
    variableController.loading.value = true;
    final Map<String, dynamic> formData = {
      'added_now': addProofAmountController.value.text,
      'fund_source': fundsSource.value,
      'app': "1",
    };

    try {
      final uri = Uri.parse('${MyUrls.BASE_URL}/${MyUrls.addFundsByBusiness}/${CommonVariable.businessId.value}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['added_now'] = formData['added_now'];
      request.fields['fund_source'] = formData['fund_source'];
      request.fields['app'] = formData['app'];
      if (selectedFile != null && selectedFile!.existsSync()) {
        List<int> imageBytes = await selectedFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        request.fields['proof_pay'] = 'data:image/png;base64,$base64Image';
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
          MyToast.toast("Funds added successfully.");
          Get.back();
        } else {
          MyToast.toast("Something went wrong.");
        }
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        MyToast.toast("Failed to add Funds. Please try again.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      MyToast.toast("An error occurred while uploading the Funds.");
    } finally {
      variableController.loading.value = false;
    }
  }
}

class JsonUtils {
  static List<ResAllGateway> parseCustomerData(dynamic response) {
    List<ResAllGateway> gateways = [];
    if (response is List) {
      for (var item in response) {
        String details = item['details'];
        if (details.contains('<p>') || details.contains('<strong>')) {
          var document = html_parser.parse(details);
          details = document.body?.text ?? details;
        }
        gateways.add(ResAllGateway(
          sId: item['_id'],
          name: item['name'],
          details: details, // Now contains plain text or extracted text from HTML
          isDeleted: item['is_deleted'],
          createdOn: item['created_on'],
          lastUpdated: item['last_updated'], iV: item['__v'],
        ));
      }
    }
    return gateways;
  }
}
