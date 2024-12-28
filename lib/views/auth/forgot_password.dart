import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/auth/forgot_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var variableController = Get.find<VariableController>();
  var forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  void dispose() {
    forgotPasswordController.emailController.value.clear();
    forgotPasswordController.emailValid = true.obs;
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      resizeToAvoidBottomInset: true, // Allows resizing when keyboard appears
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Forgot Password",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: screenWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Email Id ',
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    CommonTextField(
                      controller:
                      forgotPasswordController.emailController.value,
                      labelText: "Email Id",
                      keyboardType: TextInputType.emailAddress,
                      focusNode: forgotPasswordController.emailFocusNode,
                      onChanged: (value) {
                        String pattern =
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        RegExp regExp = RegExp(pattern);
                        setState(() {
                          if (value.isEmpty) {
                            forgotPasswordController.emailValid =
                                false.obs; // Empty field
                          } else if (regExp.hasMatch(value)) {
                            forgotPasswordController.emailValid = true.obs;
                          } else {
                            forgotPasswordController.emailValid =
                                false.obs; // Invalid input
                          }
                        });
                      },
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: AppColors.appBlueColor),
                        contentPadding:
                        const EdgeInsets.only(right: 16, left: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: forgotPasswordController.emailValid.value
                                ? AppColors.appNeutralColor5
                                : AppColors.appRedColor,
                            width: 1, // Thickness for the underline
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.appNeutralColor5,
                            width: 1,
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.appRedColor,
                            width: 1,
                          ),
                        ),
                        errorText: forgotPasswordController.emailValid.value
                            ? null
                            : (forgotPasswordController
                            .emailController.value.text.isEmpty
                            ? 'Email is required'
                            : 'Invalid Email'),
                        hintText: "Enter email",
                        filled: true,
                        fillColor: AppColors.appNeutralColor5,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
        child: CommonButton(
          buttonWidth: screenWidth * 0.9,
          buttonName: "Forgot Password",
          onPressed: () {
            setState(() {
              if (forgotPasswordController.emailValidation(context)) {
                forgotPasswordController.getForgotPassword();
              }
            });
          },
        ),
      ),
    );
  }
}
