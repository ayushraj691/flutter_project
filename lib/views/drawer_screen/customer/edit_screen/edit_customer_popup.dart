import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class EditCustomerPopup extends StatefulWidget {
  final id;
  final VoidCallback onSave;

  const EditCustomerPopup(this.id, {super.key, required this.onSave});

  @override
  State<EditCustomerPopup> createState() => _EditCustomerPopupState();
}

class _EditCustomerPopupState extends State<EditCustomerPopup> {
  final _formKey = GlobalKey<FormState>();

  var addCustomerController = Get.find<AddCustomerController>();
  var customerDetailViewController = Get.find<CustomerDetailViewController>();

  @override
  void initState() {
    callMethod();
    addCustomerController = Get.find<AddCustomerController>();
    super.initState();
  }

  void callMethod() {
    addCustomerController.nameController.value = TextEditingController(
      text: customerDetailViewController.personName.value,
    );
    addCustomerController.mobileController.value = TextEditingController(
      text: customerDetailViewController.personMobileNumber.value,
    );
    addCustomerController.emailController.value = TextEditingController(
      text: customerDetailViewController.personEmail.value,
    );
    addCustomerController.descriptionController.value = TextEditingController(
      text: customerDetailViewController.personDescription.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      height: screenHeight * 0.7,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey, width: 0.2),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive space
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Edit Customer",
                style: TextStyle(
                  fontFamily: 'Sofia Sans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              "Customer Details",
              style: TextStyle(
                fontFamily: 'Sofia Sans',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            const Divider(
              thickness: 1,
              color: AppColors.appGreyColor,
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  // Limit width to avoid infinite constraints
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Customer Name ',
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
                              controller: addCustomerController.nameController.value,
                              labelText: "Customer Name",
                              focusNode: addCustomerController.nameFocusNode,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                              ],
                              onChanged: (value) {
                                String pattern = r'^[a-zA-Z\s]*$';
                                RegExp regExp = RegExp(pattern);
                                setState(() {
                                  if (value.isEmpty) {
                                    addCustomerController.nameValid = false.obs;
                                  } else if (regExp.hasMatch(value)) {
                                    addCustomerController.nameValid = true.obs;
                                  } else {
                                    addCustomerController.nameValid = false.obs;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.all(18),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.nameValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 2,
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
                                    // Error border for invalid input
                                    width: 2,
                                  ),
                                ),
                                errorText: addCustomerController.nameValid.value
                                    ? null
                                    : 'Customer Name is required',
                                hintText: "Enter Customer Name",
                                filled: true,
                                fillColor: AppColors.appNeutralColor5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Mobile Number ',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Align everything to the start
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CountryCodePicker(
                                      onChanged: (countryCode) {
                                        setState(() {
                                          addCustomerController.selectedCountryCode =
                                          countryCode.dialCode!;
                                        });
                                      },
                                      initialSelection: 'US',
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      textStyle: const TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Space between country code and phone number input

                                  // Expanded widget for the phone number input field
                                  Expanded(
                                    child: TextFormField(
                                      controller: addCustomerController
                                          .mobileController.value,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      focusNode: addCustomerController
                                          .mobileFocusNode,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Mobile number is required';
                                        } else if (value.trim().length < 10) {
                                          return 'Mobile number must be 10 digits';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        hintText: 'Enter Mobile Number',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey),
                                        filled: true,
                                        fillColor: AppColors.appNeutralColor5,
                                        contentPadding: const EdgeInsets.only(right: 16,left: 16),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: addCustomerController
                                                .mobileValid.value
                                                ? AppColors.appNeutralColor5
                                                : AppColors.appRedColor,
                                            // Change color based on validation
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.appNeutralColor5,
                                            // Default color for enabled but not focused
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder:
                                        const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.appRedColor,
                                            width: 1,
                                          ),
                                        ),
                                        errorText: addCustomerController
                                            .mobileValid.value
                                            ? null
                                            : (addCustomerController
                                            .mobileController.value
                                            .text
                                            .isEmpty
                                            ? 'Mobile number is required'
                                            : 'Mobile number must be 10 digits'),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          addCustomerController
                                              .mobileValid.value = value
                                              .length ==
                                              10; // Valid if exactly 10 digits
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Builder(
                                builder: (context) {
                                  final formField =
                                  context.findAncestorWidgetOfExactType<
                                      TextFormField>();
                                  return Text(
                                    formField?.validator?.call(
                                        addCustomerController
                                            .mobileController.value.text) ??
                                        '',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12), // Error message style
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
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
                              addCustomerController.emailController.value,
                              labelText: "Email Id",
                              keyboardType: TextInputType.emailAddress,
                              focusNode: addCustomerController.emailFocusNode,
                              onChanged: (value) {
                                String pattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                RegExp regExp = RegExp(pattern);
                                setState(() {
                                  if (value.isEmpty) {
                                    addCustomerController.emailValid =
                                        false.obs; // Empty field
                                  } else if (regExp.hasMatch(value)) {
                                    addCustomerController.emailValid = true.obs;
                                  } else {
                                    addCustomerController.emailValid =
                                        false.obs; // Invalid input
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.only(right: 16,left: 16),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.emailValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 1, // Thickness for the underline
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appNeutralColor5,
                                    // Default color for enabled state
                                    width: 1,
                                  ),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    width: 1,
                                  ),
                                ),
                                errorText: addCustomerController.emailValid.value
                                    ? null
                                    : (addCustomerController
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
                      RichText(
                        text: const TextSpan(
                          text: 'Description',
                          style: TextStyle(
                            fontFamily: 'Sofia Sans',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        controller:
                        addCustomerController.descriptionController.value,
                        maxLines: 10,
                        minLines: 5,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Enter Your Description Here",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.appNeutralColor2,
                            fontSize: 14,
                            fontFamily: 'Sofia Sans',
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(16.0),
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
                          filled: true,
                          fillColor: AppColors.appNeutralColor5,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.appNeutralColor2,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                      // SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (addCustomerController.personValidation(context)){
                                GeneralMethods.loadingDialog(context);
                                addCustomerController.updateCustomerDetail(widget.id);
                                widget.onSave();
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: AppColors.appBlueColor),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}