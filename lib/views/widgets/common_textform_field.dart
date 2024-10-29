import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color_constants.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
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
  final String? errorMessage; // Error message passed externally (optional)
  final String? Function(String?)? validator; // Validator function
  final List<TextInputFormatter>? inputFormatters; // Added inputFormatters
  final InputDecoration? decoration;


  const CommonTextField(
      {Key? key,
      this.hintText,
      this.focusNode,
      this.controller,
      this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.prefixImage, // Made prefixImage optional
      this.suffixIcon, // Made suffixIcon optional
      this.suffixIconColor, // Made suffixIcon color optional
      this.onSuffixIconTap, // Made onSuffixIconTap optional
      this.obscureText =
          false, // Made obscureText optional with default value false
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.maxLines, // Keep the maxLines optional
      this.minLines, // Added minLines for initial height
      this.errorMessage, // Error message passed externally
      this.validator, // Validator function
      this.inputFormatters,
      this.decoration,
      required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 380,
      ),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        obscureText: obscureText,
        maxLength: maxLength,
        maxLines: maxLines ?? null, // Allow text field to expand vertically
        minLines: minLines ?? 1, // Initial height with 1 line
        keyboardType: keyboardType,
        inputFormatters: inputFormatters, // Apply input formatters dynamically
        style: const TextStyle(
          fontFamily: 'Sofia Sans',
          fontSize: 16,
          color: AppColors.appTextColor, // Set the text color
        ),
        decoration: decoration ?? InputDecoration(
          counterText: '',
          prefixIcon: prefixImage != null
              ? InkWell(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    prefixImage,
                    color: AppColors.appTextColor,
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    suffixIcon,
                    color: suffixIconColor,
                  ),
                )
              : null,
          labelStyle: const TextStyle(color: AppColors.appBlueColor),
          contentPadding: const EdgeInsets.all(18),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.appNeutralColor5,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.appNeutralColor5,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.appNeutralColor5,
          errorText: errorMessage, // Show error text if provided
        ),

        validator: validator, // Call the validator function here
        enableInteractiveSelection: false, // Disable copy-paste interaction
      ),
    );
  }
}

