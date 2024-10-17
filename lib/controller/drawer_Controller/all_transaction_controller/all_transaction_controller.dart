import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';

class AllTransactionController extends GetxController{

  var variableController = Get.find<VariableController>();
  List<ResTransaction> allTransactionList =
      List<ResTransaction>.empty(growable: true).obs;


  void addAccountDetail() {
    allTransactionList.add(ResTransaction(
        sId: '123',
        custId: "custId",
        bankId: "bankId",
        checkNo: 34567,
        memo: "memo",
        source: "source",
        txnNumber: "txnNumber",
        randomNumber: 4567,
        payTotal: 1223,
        isInvoice: true,
        isInvoicePreapproved: false,
        payDue: "payDue",
        isSendInvoice: false,
        isSusbcription: false,
        isSchedule: true,
        scheduleStart: false,
        subscriptionIsInvoice: false,
        subscriptionInvoicePreapproved: false,
        verificationStatus: false,
        verifyToken: "false",
        subscriptionType: "subscriptionType",
        payStatus: "payStatus",
        payMode: "payMode",
        cancelReason: false,
        downloadBymerchant: false,
        downloadByadmin: false,
        isDeletedRequest: false,
        isDeleted: false,
        createdOn: "2024-10-11T07:36:47.278Z",
        lastUpdated: "2024-10-11T07:37:53.120Z",
        iV: 12345));

  }



  final buttonText = 'Select Date'.obs;
  final startDate = ''.obs;
  final endDate = ''.obs;

  AllTransactionController() {
    final DateTime now = DateTime.now();
    final DateTime lastYear = DateTime(now.year - 1);
    setDateRange(now, lastYear);
  }

  void callMethod() async {
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "": "",
    };
    // await getAllCustomerData(
    //   CommonVariable.businessId.value,
    //   '',
    //   "$argumentMap",
    //   startDate.value,
    //   endDate.value,
    //   "$sortMap",
    // );
  }

  void setDateRange(DateTime end, DateTime start) {
    endDate.value = DateFormat.yMMMd().format(end);
    startDate.value = DateFormat.yMMMd().format(start);
    buttonText.value = '${startDate.value} - ${endDate.value}';
  }

  Future<void> showDatePickerDialog(BuildContext context) async {
    final DateTime now = DateTime.now();

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.today, color: Colors.blue),
                  title: const Text('Today'),
                  onTap: () {
                    setDateRange(now, now);
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.orange),
                  title: const Text('Yesterday'),
                  onTap: () {
                    setDateRange(now.subtract(Duration(days: 1)),
                        now.subtract(Duration(days: 1)));
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.green),
                  title: const Text('Last 7 Days'),
                  onTap: () {
                    setDateRange(
                        now, now.subtract(Duration(days: 7))); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.purple),
                  title: const Text('Last 30 Days'),
                  onTap: () {
                    setDateRange(
                        now, now.subtract(Duration(days: 30))); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.deepPurple),
                  title: const Text('Last 6 Months'),
                  onTap: () {
                    setDateRange(now,
                        DateTime(now.year, now.month - 6)); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading:
                  const Icon(Icons.calendar_view_month, color: Colors.indigo),
                  title: const Text('Last 1 Year'),
                  onTap: () {
                    final DateTime lastYear = DateTime(now.year - 1);
                    setDateRange(now, lastYear); // Swapped dates
                    callMethod();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.red),
                  title: const Text('Custom Range'),
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: const TextTheme(
              button: TextStyle(fontSize: 12),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentTextStyle: TextStyle(fontSize: 14),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 0.85,
            ),
            child: SingleChildScrollView(
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

}