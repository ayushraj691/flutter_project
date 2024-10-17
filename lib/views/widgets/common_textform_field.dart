import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final IconData? prefixImage; // Added prefixImage
  final IconData? suffixIcon; // Added suffixIcon
  final Color? suffixIconColor; // Added suffixIconColor
  final VoidCallback? onSuffixIconTap; // Added onSuffixIconTap
  final bool obscureText; // Added obscureText
  final int? maxLength; // Added maxLength
  final TextInputType keyboardType; // Added keyboardType
  final int? maxLines; // Keep the maxLines optional
  final int? minLines; // Added minLines to control initial height
  final String? errorMessage; // Added minLines to control initial height

  const CommonTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.prefixImage, // Made prefixImage optional
    this.suffixIcon, // Made suffixIcon optional
    this.suffixIconColor, // Made suffixIcon color optional
    this.onSuffixIconTap, // Made onSuffixIconTap optional
    this.obscureText = false, // Made obscureText optional with default value false
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.maxLines, // Keep the maxLines optional
    this.minLines, // Added minLines for initial height
    this.errorMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 380,
        // Remove maxHeight to allow flexible height based on input
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        obscureText: obscureText,
        maxLength: maxLength,
        maxLines: maxLines ?? null, // Allow text field to expand vertically
        minLines: minLines ?? 1, // Initial height with 1 line
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: 'Sofia Sans', // Apply font to the input text
          fontSize: 16, // Optional: You can adjust font size as needed
          color: AppColors.appTextColor, // Optional: Set the text color
        ),
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: prefixImage != null ? InkWell(
            onTap: onSuffixIconTap,
            child: Icon(
              prefixImage,
              color: AppColors.appTextColor,
            ),
          ): null,
          suffixIcon: suffixIcon != null
              ? InkWell(
            onTap: onSuffixIconTap,
            child: Icon(
              suffixIcon,
              color: suffixIconColor,
            ),
          )
              : null,
          labelStyle: TextStyle(color: AppColors.appBlueColor),
          contentPadding: const EdgeInsets.all(18),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.appNeutralColor5,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appNeutralColor5,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.appNeutralColor5,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
