import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class PersonDetailsScreen extends StatefulWidget {

  const PersonDetailsScreen({super.key});

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  var merchantController = Get.find<MerchantController>();
  var variableController = Get.find<VariableController>();



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
            "Person Detail",
            style: TextStyle(
              fontSize: 16,
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
                                      text: 'Full Name ',
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
                                  hintText: "Full Name",
                                  controller: merchantController.fullName.value,
                                  labelText: "Full Name",
                                  enable: false,
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
                                      text: 'Email address ',
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
                                  hintText: "Email address",
                                  controller: merchantController.email.value,
                                  labelText: "Email address",
                                  enable: false,
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
                                      text: 'Mobile number ',
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
                                  hintText: "Enter Mobile Number",
                                  controller: merchantController.phone.value,
                                  labelText: "Enter Mobile Number",
                                  enable: false,
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
                                      text: 'Date of Birth ',
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
                                  hintText: "Enter Date of Birth",
                                  controller: merchantController.dob.value,
                                  labelText: "Enter Date of Birth",
                                  enable: false,
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
              buttonWidth: screenWidth * 0.9, // Adjust button width
              buttonName: "Save Detail",
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
