import 'package:flutter/material.dart';
import 'package:paycron/utils/string_constants.dart';
import 'color_constants.dart'; // Import your custom colors if any

class AppTextStyles {
  // Regular Text Style
  static TextStyle normalRegularText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appBlackColor,
  );

  static TextStyle regularText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appNeutralColor2,
  );


  // Bold Text Style
  static  TextStyle regularBoldText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appBlackColor,
  );

  static  TextStyle boldText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appBlackColor,
  );

  // Large Title Text Style
  static TextStyle titleText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appBlackColor,
  );

  // Subtitle Text Style
  static TextStyle subtitleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: Constants.Sofiafontfamily,
    color: AppColors.appNeutralColor2,
  );

  // Error Text Style
  static TextStyle errorText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: Constants.Sofiafontfamily,
    color: Colors.red,
  );

  // Customizable method for dynamic text styles
  static TextStyle customTextStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = Colors.black,
    String fontFamily = 'Sofia Sans',
  }) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
    );
  }
}
