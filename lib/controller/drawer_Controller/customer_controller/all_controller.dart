import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/ResAllFilterCustomerDataModel.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class AllTabController extends GetxController {
  var variableController = Get.find<VariableController>();
  List<ResAllFilterCustomerData> allCustomerDataList =
      List<ResAllFilterCustomerData>.empty(growable: true).obs;

  final buttonText = 'Select Date'.obs;
  final startDate = ''.obs;
  final endDate = ''.obs;

  AllTabController() {
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
      "": "",
    };
    await getAllCustomerData(
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

  // Future<void> _pickCustomDateRange(BuildContext context) async {
  //   final DateTimeRange? picked = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null) {
  //     setDateRange(picked.start, picked.end); // Correct order for swapping
  //   }
  // }

  Future<void> _pickCustomDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Apply a smaller font size for buttons and general dialog content
            textTheme: const TextTheme(
              button: TextStyle(fontSize: 12),  // Smaller font size for buttons
            ),
            // Adjust the dialog shape and padding
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentTextStyle: TextStyle(fontSize: 14),  // Smaller content text
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,  // Adjust the primary color if needed
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 0.85,  // Shrinks all text within the dialog
            ),
            child: SingleChildScrollView( // Enables scrolling for smaller screens
              child: child ?? SizedBox(),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setDateRange(picked.start, picked.end);  // Correct order
    }
  }


  getAllCustomerData(
    String businessId,
    String query,
    String argument,
    String startDate,
    String endDate,
    String sort,
  ) async {
    variableController.loading.value = true;

    try {
      allCustomerDataList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.filterCustomer,
          id: businessId,
          token: CommonVariable.token.value,
          query: query,
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

        List<ResAllFilterCustomerData> customerList =
            JsonUtils.parseCustomerData(res);
        allCustomerDataList.addAll(customerList);

        if (allCustomerDataList.isEmpty) {
          MyToast.toast("No customers found.");
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
  static List<ResAllFilterCustomerData> parseCustomerData(
      dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed['data'] as List)
          .map((json) => ResAllFilterCustomerData.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      return (jsonResponse['data'] as List)
          .map((json) => ResAllFilterCustomerData.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }
}
