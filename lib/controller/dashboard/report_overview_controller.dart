import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReportOverviewController extends GetxController {
  // ForceUpdateController forceUpdateController =
  // Get.put(ForceUpdateController());

  Rx<TextEditingController> filterSearchController =
      TextEditingController().obs;
  var filterValue = '2024'.obs;
  var filterItems = <String>['2024', '2025', '2026', '2027'].obs;
}
