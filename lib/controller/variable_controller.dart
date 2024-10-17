import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VariableController extends GetxController{
  var loading = false.obs;
  var apiResponseCode = "".obs;

}