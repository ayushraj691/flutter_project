
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonVariable {

  static var  email = "".obs;
  static var verified = "".obs;
  static var userId = "".obs;
  static var userName = "".obs;
  static var role = "".obs;
  static var position = "".obs;
  static var businessCheck = 0.obs;
  static var token = "".obs;
  static var businessName = "".obs;
  static var Percentage = "".obs;
  static var businessId = "".obs;
  static var planId = "".obs;
  static var temporaryPlanId = "".obs;
  static var approvedBalance = 0.0.obs;
  static var pendingBalance = 0.obs;

  static getClientDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email.value = preferences.getString("EMAIL") ?? "";
    verified.value = preferences.getString("VERIFIED") ?? "";
    userId.value = preferences.getString("USER_ID") ?? "";
    userName.value = preferences.getString("USER_NAME") ?? "";
    role.value = preferences.getString("ROLE") ?? "";
    position.value = preferences.getString("POSITION") ?? "";
    businessCheck.value = preferences.getInt("BUSINESS_CHECK") ?? 0;
    token.value = preferences.getString("TOKEN") ?? "";

    debugPrint("From Common Variable ${email.value} and ${role.value} and ${userId.value}");
  }



}