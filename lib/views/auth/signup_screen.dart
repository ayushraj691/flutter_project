import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/auth/login_screen.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.appWhiteColor,
      resizeToAvoidBottomInset: true,
      // Allows the screen to resize when the keyboard is visible
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.04),
                      // Title Section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Get started with  ',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appBlackColor,
                                ),
                              ),
                              TextSpan(
                                text: 'us!',
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
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Fill out your details to get associated with us',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'Sofia Sans',
                              color: AppColors.appGreyColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),

                      // Input Fields
                      _buildTextField(context, 'Full Name', 'Enter Your name'),
                      _buildTextField(context, 'Email Id', 'Enter Your email'),
                      _buildTextField(
                          context, 'Phone number', 'Enter Your phone number'),
                      _buildTextField(context, 'Password', 'Enter Password'),
                      _buildTextField(context, 'Confirm Password',
                          'Enter Confirm Password'),
                    ],
                  ),
                ),
              ),
            ),

            // Spacer to push button to the bottom
            SizedBox(height: size.height * 0.02),

            // Sign Up Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  CommonButton(
                    buttonWidth: size.width * 0.9,
                    buttonName: "Sign Up",
                    onPressed: () {
                      // Sign Up functionality
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account? ",
                        style: TextStyle(
                          color: AppColors.appTextColor,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const LoginScreen());
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: 'Sofia Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.appBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Extra padding at the bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '$label ',
              style: const TextStyle(
                fontFamily: 'Sofia Sans',
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: const [
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          CommonTextField(
            hintText: hint,
            controller: TextEditingController(),
            labelText: hint,
          ),
        ],
      ),
    );
  }
}
