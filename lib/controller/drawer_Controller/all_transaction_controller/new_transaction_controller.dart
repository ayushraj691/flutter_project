import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/model/drawer_model/verifyModel/ReqDeleteTransactionData.dart';
import 'package:paycron/model/drawer_model/verifyModel/ReqVerifyTransactionData.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/widgets/date_picker_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NewTransactionController extends GetxController{

  var variableController = Get.find<VariableController>();

  List<ResTransactionDetail> newTransactionList =
      List<ResTransactionDetail>.empty(growable: true).obs;

  List<int> selectedItems = [];
  List<String> selectedIdList = [];
  bool isSelectionMode = false;
  bool isAllSelected = false;

  final startDate = ''.obs;
  final endDate = ''.obs;
  final selectedIndex = 1.obs;


  void callMethod() async {
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "pay_status": "0",
      "is_deleted_request": false,
      "is_deleted": false,
      "verification_status": false,
      "download_bymerchant": false,
    };
    await getAllTransactionData(
      CommonVariable.businessId.value,
      '',
      jsonEncode(argumentMap),
      startDate.value,
      endDate.value,
      "$sortMap",
    );
  }
  final buttonText = 'Select Date'.obs;

  void showSelectDurationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            const Text(
              "Select duration",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Zigzag Button Layout
            Column(
              children: [
                // First Row
                Row(
                  children: [
                    _buildOptionButton("Today", 1,context),
                    const SizedBox(width: 8),
                    _buildOptionButton("Yesterday", 2,context),
                  ],
                ),
                const SizedBox(height: 8),

                // Second Row
                Row(
                  children: [
                    const Spacer(flex: 1),
                    _buildOptionButton("Last 7 days", 3,context),
                    const SizedBox(width: 8),
                    _buildOptionButton("Last 30 days", 4,context),
                  ],
                ),
                const SizedBox(height: 8),
                // Third Row
                Row(
                  children: [
                    _buildOptionButton("Last Month", 5,context),
                    const SizedBox(width: 8),
                    _buildOptionButton("Last 2 months", 6,context),
                  ],
                ),
                const SizedBox(height: 8),
                // Fourth Row
                Row(
                  children: [
                    const Spacer(flex: 1),
                    _buildOptionButton("Last 6 months", 7,context),
                    const SizedBox(width: 8),
                    _buildOptionButton("Last 1 year", 8,context),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Get.to(RangeDatePickerScreen(onSubmit: (DateTime? pickStartDate, DateTime? pickEndDate) {
                  buttonText.value = '${DateFormat.yMMMd().format(pickStartDate!)} - ${DateFormat.yMMMd().format(pickEndDate!)}';
                  startDate.value = DateFormat.yMMMd().format(pickStartDate);
                  endDate.value = DateFormat.yMMMd().format(pickEndDate);
                  callMethod();
                  Navigator.pop(context);
                },));
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text("Custom range"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                minimumSize: const Size(double.infinity, 48), // Full width
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, int index,BuildContext context) {
    return Expanded(
      flex: 4,
      child: GestureDetector(
        onTap: () {
          selectedIndex.value= index;
          _handleDateSelection(index,context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDateSelection(int index,BuildContext context) {

    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    DateTime last7Days = DateTime.now().subtract(const Duration(days: 7));
    DateTime last30Days = DateTime.now().subtract(const Duration(days: 30));
    DateTime last6Months = DateTime.now().subtract(const Duration(days: 180));
    DateTime lastYear = DateTime.now().subtract(const Duration(days: 365));


    DateTime start, end;

    switch (index) {
      case 1:
        start = end = now;
        break;
      case 2:
        start = yesterday;
        end = now;
        break;
      case 3:
        start = last7Days;
        end = now;
        break;
      case 4:
        start = last30Days;
        end = now;
        break;
      case 5:
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      case 6: // Last 2 months
        start = DateTime(now.year, now.month - 2, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      case 7: // Last 6 months
        start = last6Months;
        end = now;
        break;
      case 8: // Last 1 year
        start = lastYear;
        end = now;
        break;
      default:
        return;
    }

    buttonText.value = '${DateFormat.yMMMd().format(start)} - ${DateFormat.yMMMd().format(end)}';
    startDate.value = DateFormat.yMMMd().format(start);
    endDate.value = DateFormat.yMMMd().format(end);

    callMethod();
    Navigator.pop(context);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> downloadCSV() async {
    try {
      final List<List<String>> csvRows = [
        ['TransactionId', 'Customer', 'Amount', 'Created On', 'Source','status']
      ];

      for (var transaction in newTransactionList) {
        final createdDate = transaction.createdOn;
        DateTime dateTime;
        try {
          dateTime = DateTime.parse(createdDate).toLocal();
        } catch (e) {
          debugPrint("Invalid date format: $createdDate");
          dateTime = DateTime.now();
        }

        String formattedTime = DateFormat.jm().format(dateTime);
        String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

        csvRows.add([
          transaction.txnNumber,
          transaction.custId!.info.custName,
          transaction.payTotal.toString(),
          "$formattedDate | $formattedTime",
          transaction.source,
          transaction.payStatus
        ]);
      }

      String csvString = const ListToCsvConverter().convert(csvRows);

      var status = await Permission.storage.request();
      if (status.isGranted) {
        // Get the appropriate external storage directory
        Directory? downloadsDirectory = await getExternalStorageDirectory();
        if (downloadsDirectory != null) {

          final filePath = "${downloadsDirectory.path}/newTransaction.csv";
          final file = File(filePath);

          await file.writeAsString(csvString);
          debugPrint("CSV file saved at: $filePath");

          await flutterLocalNotificationsPlugin.show(
            0,
            'Download Complete',
            'Tap to open the newTransaction CSV file.',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'download_channel',
                'Downloads',
                channelDescription: 'Notifications for file downloads',
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
              ),
            ),
            payload: filePath,
          );

          configureNotificationTapHandler(filePath);
        } else {
          debugPrint("Downloads directory not found.");
        }
      } else {
        debugPrint("Storage permission denied.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> handleNotificationTap(String? payload) async {
    try {
      if (payload != null && payload.isNotEmpty) {
        final file = File(payload);
        if (file.existsSync()) {
          final result = await OpenFilex.open(payload);
          if (result.type != ResultType.done) {
            debugPrint("Error opening file: ${result.message}");
          } else {
            debugPrint("File opened successfully: $payload");
          }
        } else {
          debugPrint("File does not exist at the specified path: $payload");
          MyToast.toast("File does not exist. Please try downloading again.");
        }
      } else {
        debugPrint("Invalid file path: $payload");
        MyToast.toast("Invalid file path. Unable to open the file.");
      }
    } catch (e) {
      debugPrint("Exception while opening file: $e");
      MyToast.toast("An error occurred while opening the file. Please try again.");
    }
  }

  void configureNotificationTapHandler(String? payload) {
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null && response.payload!.isNotEmpty) {
          handleNotificationTap(response.payload);
        }
      },
    );
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
      newTransactionList.clear();

      var res = await ApiCall.getApiCallParam(
          endpoint: MyUrls.allTransactionDetail,
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

        List<ResTransactionDetail> customerList =
        JsonUtils.parseCustomerData(res);
        newTransactionList.addAll(customerList);

        if (newTransactionList.isEmpty) {
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


  verifyData(List<String> ids) async {
    variableController.loading.value = true;
    ReqVerifyTransactionData reqVerifyTransactionData = ReqVerifyTransactionData(ids: ids);
    debugPrint(json.encode(reqVerifyTransactionData.toJson()));
    var res =
    await ApiCall.postApiCalltoken(MyUrls.verifyPayment, reqVerifyTransactionData,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
        variableController.loading.value = false;
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  deleteData(List<String> ids) async {
    variableController.loading.value = true;
    ReqDeleteTransactionData reqDeleteTransactionData = ReqDeleteTransactionData(ids: ids);
    debugPrint(json.encode(reqDeleteTransactionData.toJson()));
    var res =
    await ApiCall.postApiCalltoken(MyUrls.deletePayment, reqDeleteTransactionData,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
        variableController.loading.value = false;
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  downloadData(List<String> ids) async {
    variableController.loading.value = true;
    ReqDeleteTransactionData reqDeleteTransactionData = ReqDeleteTransactionData(ids: ids);
    debugPrint(json.encode(reqDeleteTransactionData.toJson()));
    var res =
    await ApiCall.postApiCallDownload(MyUrls.downloadPayment, reqDeleteTransactionData,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
    } else {
      MyToast.toast("Something Went Wrong");
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