import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_constants.dart';

class MyToast {
  static toast(String mgs) {
    Fluttertoast.showToast(
        msg: mgs,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.appBlueLightColor,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
