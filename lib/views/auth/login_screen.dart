import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/auth/authController.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/auth/forgot_password.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.appWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.04),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Welcome ',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appBlackColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Back!',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appBlueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Please enter your details here',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Sofia Sans',
                            color: AppColors.appGreyColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),

                    // Email Input Field
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          text: 'Email ',
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
                    ),
                    SizedBox(height: size.height * 0.005),
                    CommonTextField(
                      hintText: "Enter Email",
                      controller: authController.emailController.value,
                      labelText: "Enter Email",
                    ),
                    SizedBox(height: size.height * 0.015),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          text: 'Password ',
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
                    ),
                    SizedBox(height: size.height * 0.005),
                    CommonTextField(
                      hintText: "Enter Password",
                      controller: authController.userPasswordController.value,
                      labelText: "Enter Password",
                      maxLines: 1,
                      suffixIcon: authController.isObsecureForLogin.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      obscureText: authController.isObsecureForLogin.value,
                      suffixIconColor: AppColors.appGreyColor,
                      onSuffixIconTap: () {
                        authController.isObsecureForLogin.value =
                        !authController.isObsecureForLogin.value;
                        setState(() {});
                      },
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0, top: 20.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(const ForgotPasswordScreen());
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontFamily: 'Sofia Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  CommonButton(
                    buttonWidth: size.width * 0.9,
                    buttonName: "Login",
                    onPressed: () {
                      if (authController.emailController.value.text.isEmpty) {
                        MyToast.toast("Please Enter Email");
                      } else if (authController.userPasswordController.value.text.isEmpty) {
                        MyToast.toast("Please Enter Password");
                      } else {
                        authController.getLogin();
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have an account? ",
                        style: TextStyle(
                          color: AppColors.appTextColor,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(SignupScreen());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Sofia Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02), // Extra padding at the bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
