import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import '../../../../utils/string_constants.dart';

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
      height: screenHeight * 0.68,
      decoration: BoxDecoration(
        color: AppColors.appWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                padding: const EdgeInsets.all(2.0),
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
                fontWeight: FontWeight.w600,
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
                              controller:
                                  addCustomerController.nameController.value,
                              labelText: "Customer Name",
                              focusNode: addCustomerController.nameFocusNode,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]*$')),
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
                                labelStyle: const TextStyle(
                                    color: AppColors.appBlueColor),
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    right: 16, left: 16,top: 12,bottom: 12),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.nameValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.appNeutralColor5,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    width: 1,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Mobile Number ',
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
                            const SizedBox(height: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntlPhoneField(
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter Mobile Number',
                                    labelStyle: TextStyle(
                                      fontFamily: Constants.Sofiafontfamily,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.appNeutralColor5,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.appNeutralColor5,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
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
                                    errorStyle: const TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  initialCountryCode: 'US',
                                  onChanged: (phone) {
                                    setState(() {
                                      addCustomerController.selectedCountryCode = phone.countryCode;
                                      addCustomerController.mobileController.value.text = phone.number;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.completeNumber.trim().isEmpty) {
                                      return 'Mobile number is required';
                                    } else if (value.completeNumber.trim().length < 10) {
                                      return 'Mobile number must be at least 10 digits';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    right: 16, left: 16,top: 12,bottom: 12),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        addCustomerController.emailValid.value
                                            ? AppColors.appNeutralColor5
                                            : AppColors.appRedColor,
                                    width: 1, // Thickness for the underline
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.appNeutralColor5,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    width: 1,
                                  ),
                                ),
                                errorText:
                                    addCustomerController.emailValid.value
                                        ? null
                                        : (addCustomerController.emailController
                                                .value.text.isEmpty
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
                        minLines: 2,
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
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              right: 16, left: 16,top: 12,bottom: 12),
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
                          fontWeight: FontWeight.w600,
                          color: AppColors.appNeutralColor2,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (addCustomerController
                                  .personValidation(context)) {
                                GeneralMethods.loadingDialog(context);
                                addCustomerController
                                    .updateCustomerDetail(widget.id);
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
