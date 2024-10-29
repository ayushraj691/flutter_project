import 'package:flutter/material.dart';
import 'package:paycron/utils/color_constants.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appBlueColor),
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.appWhiteColor,
      ),
      scaffoldBackgroundColor: AppColors.appWhiteColor,
    );
  }
}
