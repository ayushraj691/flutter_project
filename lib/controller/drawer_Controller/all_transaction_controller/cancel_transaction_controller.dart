import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class CancelTransationController extends GetxController {

  var variableController = Get.find<VariableController>();

  List<ResTransactionDetail> cancelTransactionList =
      List<ResTransactionDetail>.empty(growable: true).obs;

  final startDate = ''.obs;
  final endDate = ''.obs;

  void callMethod() async {
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "": "",
    };
    await getAllTransactionData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      startDate.value,
      endDate.value,
      "$sortMap",
    );
  }

  final buttonText = 'Select Date'.obs;

  Future<void> showDatePickerDialog(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(Duration(days: 1));
    final DateTime last7Days = now.subtract(Duration(days: 7));
    final DateTime last30Days = now.subtract(Duration(days: 30));
    final DateTime last6Months = DateTime(now.year, now.month - 6);
    final DateTime lastYear = DateTime(now.year - 1);

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
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
                  leading: const Icon(Icons.calendar_month, color: Colors.grey),
                  title: const Text('Select Date'),
                  onTap: () {
                    buttonText.value = 'select Date';
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.today, color: Colors.blue),
                  title: const Text('Today'),
                  onTap: () {
                    buttonText.value = '${DateFormat.yMMMd().format(now)} - ${DateFormat.yMMMd().format(now)}';
                    startDate.value=DateFormat.yMMMd().format(now);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.orange),
                  title: const Text('Yesterday'),
                  onTap: () {
                    buttonText.value = '${DateFormat.yMMMd().format(yesterday)} - ${DateFormat.yMMMd().format(now)}'; // Set yesterday's date
                    startDate.value=DateFormat.yMMMd().format(yesterday);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.green),
                  title: const Text('Last 7 Days'),
                  onTap: () {
                    buttonText.value =
                    '${DateFormat.yMMMd().format(last7Days)} - ${DateFormat.yMMMd().format(now)}'; // Set last 7 days
                    startDate.value=DateFormat.yMMMd().format(last7Days);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.purple),
                  title: const Text('Last 30 Days'),
                  onTap: () {
                    buttonText.value =
                    '${DateFormat.yMMMd().format(last30Days)} - ${DateFormat.yMMMd().format(now)}'; // Set last 30 days
                    startDate.value=DateFormat.yMMMd().format(last30Days);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.deepPurple),
                  title: const Text('Last 6 Months'),
                  onTap: () {
                    buttonText.value =
                    '${DateFormat.yMMMd().format(last6Months)} - ${DateFormat.yMMMd().format(now)}'; // Set last 6 months
                    startDate.value=DateFormat.yMMMd().format(last6Months);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_view_month, color: Colors.indigo),
                  title: const Text('Last 1 Year'),
                  onTap: () {
                    buttonText.value =
                    '${DateFormat.yMMMd().format(lastYear)} - ${DateFormat.yMMMd().format(now)}'; // Set last year
                    startDate.value=DateFormat.yMMMd().format(lastYear);
                    endDate.value=DateFormat.yMMMd().format(now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.red),
                  title: const Text('Custom Range'),
                  onTap: () async {
                    callMethod();
                    Navigator.pop(context);
                    await _pickCustomDateRange(context);
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
      buttonText.value =
      '${DateFormat.yMMMd().format(picked.start)} - ${DateFormat.yMMMd().format(picked.end)}';
      startDate.value=DateFormat.yMMMd().format((picked.start));
      endDate.value=DateFormat.yMMMd().format((picked.end));
    }
  }

  getAllTransactionData(
      String businessId,
      String query,
      String argument,
      String startDate,
      String endDate,
      String sort,
      ) async {
    variableController.loading.value = true;

    try {
      cancelTransactionList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.allTransactionDetail,
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

        List<ResTransactionDetail> customerList =
        JsonUtils.parseCustomerData(res);
        cancelTransactionList.addAll(customerList);

        if (cancelTransactionList.isEmpty) {
          MyToast.toast("No Transaction found.");
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
  static List<ResTransactionDetail> parseCustomerData(
      dynamic jsonResponse) {
    if (jsonResponse is String) {
      final parsed = jsonDecode(jsonResponse);
      return (parsed['data'] as List)
          .map((json) => ResTransactionDetail.fromJson(json))
          .toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      return (jsonResponse['data'] as List)
          .map((json) => ResTransactionDetail.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected data format');
    }
  }

}