import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/product_model/ResAllFilterProductData.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class ActiveProductController extends GetxController {
  var variableController = Get.find<VariableController>();
  List<ResAllFilterProductData> allProductDataList =
      List<ResAllFilterProductData>.empty(growable: true).obs;

  final buttonText = 'Select Date'.obs;
  final startDate = ''.obs;
  final endDate = ''.obs;

  ActiveProductController() {
    // Set the default date range to the last year
    final DateTime now = DateTime.now();
    final DateTime lastYear = DateTime(now.year - 1);
    setDateRange(now, lastYear); // Swapping the order of the dates
  }

  void callMethod() async {
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "\"is_deleted\"": false,
    };
    await getAllProductData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      startDate.value,
      endDate.value,
      "$sortMap",
    );
  }

  void setDateRange(DateTime end, DateTime start) {
    // Swapping parameters
    endDate.value = DateFormat.yMMMd().format(end);
    startDate.value = DateFormat.yMMMd().format(start);
    buttonText.value = '${startDate.value} - ${endDate.value}'; // Changed order
  }

  Future<void> showDatePickerDialog(BuildContext context) async {
    final DateTime now = DateTime.now();

    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.today, color: Colors.blue),
                  title: Text('Today'),
                  onTap: () {
                    setDateRange(now, now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.orange),
                  title: Text('Yesterday'),
                  onTap: () {
                    setDateRange(now.subtract(Duration(days: 1)),
                        now.subtract(Duration(days: 1)));
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.date_range, color: Colors.green),
                  title: Text('Last 7 Days'),
                  onTap: () {
                    setDateRange(
                        now, now.subtract(Duration(days: 7))); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.date_range, color: Colors.purple),
                  title: Text('Last 30 Days'),
                  onTap: () {
                    setDateRange(
                        now, now.subtract(Duration(days: 30))); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.date_range, color: Colors.deepPurple),
                  title: Text('Last 6 Months'),
                  onTap: () {
                    setDateRange(now,
                        DateTime(now.year, now.month - 6)); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading:
                  Icon(Icons.calendar_view_month, color: Colors.indigo),
                  title: Text('Last 1 Year'),
                  onTap: () {
                    final DateTime lastYear = DateTime(now.year - 1);
                    setDateRange(now, lastYear); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.red),
                  title: Text('Custom Range'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickCustomDateRange(context);
                    callMethod();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickCustomDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setDateRange(picked.start, picked.end); // Correct order for swapping
    }
  }

  getAllProductData(
      String businessId,
      String query,
      String argument,
      String startDate,
      String endDate,
      String sort,
      ) async {
    variableController.loading.value = true;

    try {
      allProductDataList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.filterProduct,
          id: businessId,
          token: CommonVariable.token.value,
          query: query,
          args: argument,
          endDate: endDate,
          page: 1,
          size: 21,
          startDate: startDate,
          yes: 'yes',
          urlIdentifier: '0');

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        List<ResAllFilterProductData> productList =
        JsonUtils.parseCustomerData(res);
        allProductDataList.addAll(productList);

        if (allProductDataList.isEmpty) {
          MyToast.toast("No product found.");
          variableController.loading.value = false;
        }
      } else {
        MyToast.toast("Something went wrong. Please try again.");
        variableController.loading.value = false;
      }
    } catch (e) {
      variableController.loading.value = false;
      debugPrint("Error occurred: $e");
      MyToast.toast("Something went wrong: ${e.toString()}");
    } finally {
      variableController.loading.value = false;
    }
  }
}

class JsonUtils {
  static List<ResAllFilterProductData> parseCustomerData(
      dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed['data'] as List)
          .map((json) => ResAllFilterProductData.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      return (jsonResponse['data'] as List)
          .map((json) => ResAllFilterProductData.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }
}
