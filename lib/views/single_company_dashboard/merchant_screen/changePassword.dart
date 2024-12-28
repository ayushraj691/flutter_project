import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/change_password_controller.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var variableController = Get.find<VariableController>();
  var changePasswordController = Get.find<ChangePasswordController>();
  var merchantController = Get.find<MerchantController>();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    changePasswordController.oldPassword.value.text = merchantController.password.value;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
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
            "Change Password",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Current Password ',
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
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "Current Password",
                                  controller:
                                      changePasswordController.oldPassword.value,
                                  labelText: "Current Password",
                                  maxLines: 1,
                                  suffixIcon: changePasswordController
                                          .isObsecureForCurrentPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  obscureText: changePasswordController
                                      .isObsecureForCurrentPassword.value,
                                  suffixIconColor: AppColors.appGreyColor,
                                  onSuffixIconTap: () {
                                    changePasswordController
                                            .isObsecureForCurrentPassword
                                            .value =
                                        !changePasswordController
                                            .isObsecureForCurrentPassword.value;
                                    setState(() {});
                                  },
                                  onChanged: (value) {},
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'New Password ',
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
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "New Password",
                                  controller:
                                      changePasswordController.newPassword,
                                  labelText: "New Password",
                                  maxLines: 1,
                                  suffixIcon: changePasswordController
                                          .isObsecureForNewPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  obscureText: changePasswordController
                                      .isObsecureForNewPassword.value,
                                  suffixIconColor: AppColors.appGreyColor,
                                  onSuffixIconTap: () {
                                    changePasswordController
                                            .isObsecureForNewPassword.value =
                                        !changePasswordController
                                            .isObsecureForNewPassword.value;
                                    setState(() {});
                                  },
                                  onChanged: (value) {},
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Re-enter New Password ',
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
                                            // Set a different color for the asterisk
                                            fontSize: 12.0,
                                            // Same or different size
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "Enter Confirm Password",
                                  controller:
                                      changePasswordController.confirmPassword,
                                  labelText: "Enter Confirm Password",
                                  maxLines: 1,
                                  suffixIcon: changePasswordController
                                          .isObsecureForConfirmPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  obscureText: changePasswordController
                                      .isObsecureForConfirmPassword.value,
                                  suffixIconColor: AppColors.appGreyColor,
                                  onSuffixIconTap: () {
                                    changePasswordController
                                            .isObsecureForConfirmPassword
                                            .value =
                                        !changePasswordController
                                            .isObsecureForConfirmPassword.value;
                                    setState(() {});
                                  },
                                  onChanged: (value) {},
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                              ],
                            ),
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
            padding: const EdgeInsets.only(bottom: 20.0),
            // Space from the bottom
            child: CommonButton(
              buttonWidth: screenWidth * 0.9,
              buttonName: "Change Password",
              onPressed: () {
                if(changePasswordController.oldPassword.value.text.isEmpty){
                  MyToast.toast("Please Enter Current Password");
                }else if(changePasswordController.newPassword.text.isEmpty){
                  MyToast.toast("Please Enter New Password");
                }else if(changePasswordController.confirmPassword.text.isEmpty){
                  MyToast.toast("Please Enter Confirm Password");
                }else{
                  if (changePasswordController.oldPassword.value.text == changePasswordController.newPassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('New password cannot be the same as the old password.'),
                    ));
                  }else if (changePasswordController.newPassword.text != changePasswordController.confirmPassword.text) {
                    // Display password mismatch error message
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('New password and confirm password do not match.'),
                    ));
                  } else {
                   Get.back();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
