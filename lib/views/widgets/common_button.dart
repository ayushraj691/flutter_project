import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double buttonWidth;
  final Color buttonColor;
  final IconData? icon;
  final String? imagePath; // Add image path

  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.buttonWidth,
    this.buttonColor = AppColors.appBlueColor,
    this.icon,
    this.imagePath, // New optional image path
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: imagePath != null
            ? Image.asset(
                imagePath!, // Display the image if provided
                width: 20,
                height: 20,
              )
            : icon != null
                ? Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  )
                : const SizedBox.shrink(),
        label: Text(
          buttonName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(buttonWidth, 40),
          backgroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}

class CommonButtonImage extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double buttonWidth;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final IconData? icon;
  final String? imagePath;

  const CommonButtonImage({
    super.key,
    required this.buttonName,
    required this.textColor,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonColor,
    required this.borderColor,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth, // Set the width here
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor, // Black border
          width: 1.0, // Border thickness
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button text
            Text(
              buttonName,
              style: TextStyle(
                fontFamily: 'Sofia Sans',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: textColor, // Text color
              ),
            ),
            if (imagePath != null) ...[
              const SizedBox(width: 8),
              Image.asset(
                imagePath!,
                width: 20,
                height: 20,
              )
            ] else if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 20,
                color: Colors.white,
              )
            ],
          ],
        ),
      ),
    );
  }
}
