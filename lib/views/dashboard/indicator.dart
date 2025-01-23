import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const IndicatorWidget(
      {required this.iconColor, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Align icon with the text
      children: [
        Icon(
          icon, // Use the icon provided
          size: 20,
          color: iconColor,
        ),
        SizedBox(width: screenWidth * 0.02),
        // Further reduce the width of the SizedBox
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
