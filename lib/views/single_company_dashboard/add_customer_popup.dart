import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

import '../../utils/string_constants.dart';

class CreateCustomerForm extends StatefulWidget {
  const CreateCustomerForm({super.key});

  @override
  _CreateCustomerFormState createState() => _CreateCustomerFormState();
}

class _CreateCustomerFormState extends State<CreateCustomerForm> {
  final createPaymentController = Get.find<CreatePaymentController>();

  final _formKey = GlobalKey<FormState>();
  int currentStep = 1; // Initialize current step
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isPersonalDetailsFilled() {
    return nameController.text.isNotEmpty &&
        mobileController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05), // 5% of the screen width
      height: screenHeight * 0.8, // 80% of the screen height
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 60,
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: AppColors.appGreyColor,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: AppColors.appGreyColor, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive space
            Text(
              "Create Customer",
              style: TextStyle(
                fontFamily: Constants.Sofiafontfamily,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.appBlackColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentStep = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '1. Personal Details',
                              style: TextStyle(
                                fontWeight: currentStep == 1
                                    ? FontWeight.normal
                                    : FontWeight.normal,
                                color: currentStep == 1 ||
                                        isPersonalDetailsFilled == true
                                    ? AppColors.appGreyColor
                                    : AppColors.appBlueColor,
                                fontSize: 16,
                              ),
                            ),
                            // SizedBox(width: screenWidth * 0.02),
                            // Image.asset(ImageAssets.success),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(
                          thickness: 2,
                          color: currentStep == 1 ||
                                  isPersonalDetailsFilled == true
                              ? AppColors.appGreyColor
                              : AppColors.appBlueColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05), // Responsive space
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isPersonalDetailsFilled()) {
                        setState(() {
                          currentStep = 2;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Please fill out personal details first!")),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Text(
                          '2. Account Details',
                          style: TextStyle(
                            fontWeight: currentStep == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: currentStep == 2
                                ? AppColors.appGreyColor
                                : AppColors.appGreyColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          thickness: 2,
                          color: currentStep == 2
                              ? AppColors.appGreyColor
                              : AppColors.appGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive space
            // Create a scrollable area within 80% height
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align fields to the left in the column
                  children: [
                    if (currentStep == 1) ...[
                      buildField(context, 'Name', 'Enter Name', nameController),
                      buildField(context, 'Mobile Number',
                          'Enter Mobile Number', mobileController),
                      buildField(context, 'Email Id', 'Enter Email Id',
                          emailController),
                      buildField(context, 'Description', 'Enter Description',
                          descriptionController),
                    ] else if (currentStep == 2) ...[
                      buildField(context, 'Account Holder Name',
                          'Enter Account Holder Name', TextEditingController()),
                      buildField(context, 'Routing Number',
                          'Enter Routing Number', TextEditingController()),
                      buildField(context, 'Account Number',
                          'Enter Account Number', TextEditingController()),
                      buildField(
                          context,
                          'Confirm Account Number',
                          'Enter Confirm Account Number',
                          TextEditingController()),
                      buildField(context, 'Suit/Apt', 'Enter Suit/Apt',
                          TextEditingController()),
                      buildField(context, 'Street', 'Enter Street',
                          TextEditingController()),
                      SizedBox(height: screenHeight * 0.02),
                      // Responsive space
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align fields at the start of the Row
                        children: [
                          Expanded(
                              child: buildField(context, 'Country',
                                  'Enter Country', TextEditingController())),
                          SizedBox(width: screenWidth * 0.02),
                          // Responsive space
                          Expanded(
                              child: buildField(context, 'State', 'Enter State',
                                  TextEditingController())),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Responsive space
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align fields at the start of the Row
                        children: [
                          Expanded(
                              child: buildField(context, 'City', 'Enter City',
                                  TextEditingController())),
                          SizedBox(width: screenWidth * 0.02),
                          // Responsive space
                          Expanded(
                              child: buildField(context, 'Zip Code',
                                  'Enter Zip Code', TextEditingController())),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive space
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentStep == 1) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          currentStep = 2; // Move to the next step
                        });
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    currentStep == 1 ? "Next" : "Submit",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(BuildContext context, String label, String hintText,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '$label ',
              style: TextStyle(
                fontFamily: Constants.Sofiafontfamily,
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
          SizedBox(height: 4.0),
          CommonTextField(
            hintText: hintText,
            controller: controller,
            labelText: label,
          ),
        ],
      ),
    );
  }
}
