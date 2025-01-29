import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqAddCustomer.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/drawer_screen/customer/add_account_popup.dart';
import 'package:paycron/views/drawer_screen/customer/edit_screen/edit_account_popup.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import '../../../controller/drawer_Controller/customer_controller/all_controller.dart';
import '../../../utils/string_constants.dart';
import '../../../utils/style.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  var addCustomerController = Get.find<AddCustomerController>();
  var variableController = Get.find<VariableController>();
  var allTabController = Get.find<AllTabController>();

  int currentStep = 1;
  bool _isAccountDetail = false;
  bool isPersonalDetailsFilled = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    addCustomerController = Get.find<AddCustomerController>();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      addCustomerController.routingNumberController
          .addListener(_routingNumberListener);
    });
  }

  void _routingNumberListener() async {
    final input = addCustomerController.routingNumberController.text;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _checkRoutingNumber(input);
    });

    if (input.length < 9) {
      addCustomerController.isRoutingNumberValid = false.obs;
      setState(() {});
    }
  }

  Future<void> _checkRoutingNumber(String routingNumber) async {
    await addCustomerController.validateRoutingNumber(routingNumber.trim());
    setState(() {});
  }

  @override
  void dispose() {
    addCustomerController.routingNumberController
        .removeListener(_routingNumberListener);
    _debounce?.cancel();
    super.dispose();
  }

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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          "Create Customer",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: Constants.Sofiafontfamily,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.025),
        child: Form(
          child: Column(
            children: [
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
                                      ? FontWeight.w600
                                      : FontWeight.w600,
                                  color: currentStep == 1 &&
                                          isPersonalDetailsFilled == true
                                      ? AppColors.appTextColor
                                      : AppColors.appBlueColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              currentStep == 2 && isPersonalDetailsFilled == true
                                  ? Image.asset(
                                      ImageAssets.success,
                                      width: screenWidth * 0.05,
                                      height: screenWidth * 0.05,
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(
                            thickness: 2,
                            color: currentStep == 1 &&
                                    isPersonalDetailsFilled == true
                                ? AppColors.appTextColor
                                : AppColors.appBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (addCustomerController.personValidation(context)) {
                          setState(() {
                            currentStep = 2;
                            isPersonalDetailsFilled = true;
                            addCustomerController.accountDetailsList.isEmpty
                                ? _isAccountDetail = false
                                : _isAccountDetail = true;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            '2. Account Details',
                            style: TextStyle(
                              fontWeight: currentStep == 2
                                  ? FontWeight.w600
                                  : FontWeight.w600,
                              color: currentStep == 2
                                  ? AppColors.appTextColor
                                  : AppColors.appGreyTransparentColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Divider(
                            thickness: 2,
                            color: currentStep == 2
                                ? AppColors.appTextColor
                                : AppColors.appGreyTransparentColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentStep == 1) ...[
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Name ',
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
                                      CommonTextField(
                                        controller:
                                        addCustomerController.nameController.value,
                                        labelText: "Name",
                                        keyboardType: TextInputType.text,
                                        focusNode: addCustomerController.nameFocusNode,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^[a-zA-Z\s]*$')),
                                        ],
                                        onChanged: (value) {
                                          String pattern = r'^[a-zA-Z\s]*$';
                                          RegExp regExp = RegExp(pattern);
                                          setState(() {
                                            if (value.isEmpty) {
                                              addCustomerController.nameValid =
                                                  false.obs;
                                            } else if (regExp.hasMatch(value)) {
                                              addCustomerController.nameValid =
                                                  true.obs;
                                            } else {
                                              addCustomerController.nameValid =
                                                  false.obs;
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
                                              addCustomerController.nameValid.value
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
                                          errorText:
                                          addCustomerController.nameValid.value
                                              ? null
                                              : 'Name is required',
                                          errorStyle: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: "Enter Name",
                                          filled: true,
                                          fillColor: AppColors.appNeutralColor5,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Name is required';
                                          }
                                          return null;
                                        },
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
                                        text:  TextSpan(
                                          text: 'Email Id ',
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
                                              addCustomerController.emailValid =
                                                  true.obs;
                                            } else {
                                              addCustomerController.emailValid =
                                                  false.obs; // Invalid input
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
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
                                          errorStyle: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          errorText:
                                          addCustomerController.emailValid.value
                                              ? null
                                              : (addCustomerController
                                              .emailController
                                              .value
                                              .text
                                              .isEmpty
                                              ? 'Email is required'
                                              : 'Invalid Email'),
                                          hintText: "Enter Email",
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Description',
                                      style: TextStyle(
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
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
                                    labelStyle: TextStyle(
                                      color: AppColors.appNeutralColor2,
                                      fontSize: 14,
                                      fontFamily: Constants.Sofiafontfamily,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    alignLabelWithHint: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        right: 16, left: 16,top: 12,bottom: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.appNeutralColor5,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.appNeutralColor5,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.appNeutralColor5,
                                  ),
                                  style: TextStyle(
                                    color: AppColors.appTextColor,
                                    fontSize: 14,
                                    fontFamily: Constants.Sofiafontfamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (currentStep == 2) ...[
                        _isAccountDetail
                            ? Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: addCustomerController
                                      .accountDetailsList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildAccountAddView(
                                            addCustomerController
                                                .accountDetailsList,
                                            context,
                                            "Account ${index + 1}",
                                            index),
                                      ),
                                    );
                                  },
                                ))
                            : buildAccountForm(context),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: currentStep == 1
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (addCustomerController
                                  .personValidation(context)) {
                                currentStep = 2;
                                isPersonalDetailsFilled = true;
                                addCustomerController.accountDetailsList.isEmpty
                                    ? _isAccountDetail = false
                                    : _isAccountDetail = true;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: AppColors.appBlueColor),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_isAccountDetail) {
                                  addAccountPopup(context);
                                  addCustomerController.clearAllAccount();
                                } else {
                                  setState(() {
                                    if (addCustomerController
                                        .validation(context)) {
                                      _isAccountDetail = true;
                                      addCustomerController.addAccountDetail();
                                      addCustomerController.clearAllAccount();
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isAccountDetail
                                    ? Colors.white
                                    : AppColors.appBlueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                      color: AppColors.appBlueColor),
                                ),
                                elevation: 0,
                              ),
                              child: _isAccountDetail
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: AppColors.appBlueColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Add More",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors
                                                .appBlueColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                GeneralMethods.loadingDialog(context);
                                if (!_isAccountDetail) {
                                  if (addCustomerController
                                      .validation(context)) {
                                    addCustomerController.accountDetailsList
                                        .clear();
                                    addCustomerController.addAccountDetail();
                                    addCustomerController.insertCustomerData();
                                    Get.back();
                                    setState(() {});
                                  }
                                } else {
                                  // if (addCustomerController.validation()) {
                                  addCustomerController.insertCustomerData();
                                  Get.back();
                                  setState(() {});
                                  // }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: AppColors.appBlueColor),
                              child: const Text(
                                "Confirm & Submit",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountForm(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account Details",
                  style: TextStyle(
                    fontFamily: Constants.Sofiafontfamily,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (addCustomerController.validation(context)) {
                        _isAccountDetail = true;
                        addCustomerController.addAccountDetail();
                        addCustomerController.clearAllAccount();
                      }
                    });
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
                )
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.appBackgroundGreyColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Account Holder Name ',
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
                  CommonTextField(
                    controller:
                    addCustomerController.accountHolderNameController.value,
                    labelText: "Account Holder Name",
                    focusNode: addCustomerController.accountNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                    ],
                    onChanged: (value) {
                      String pattern = r'^[a-zA-Z\s]*$';
                      RegExp regExp = RegExp(pattern);
                      setState(() {
                        if (value.isEmpty) {
                          addCustomerController.AccountNameValid = false.obs;
                        } else if (regExp.hasMatch(value)) {
                          addCustomerController.AccountNameValid = true.obs;
                        } else {
                          addCustomerController.AccountNameValid = false.obs;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: AppColors.appBlueColor),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                          right: 16, left: 16,top: 12,bottom: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: addCustomerController.AccountNameValid.value
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
                          // Error border for invalid input
                          width: 2,
                        ),
                      ),
                      errorText: addCustomerController.AccountNameValid.value
                          ? null
                          : 'Account Holder Name is required',
                      errorStyle: const TextStyle(
                        fontSize: 10.0, // Reduced font size for error text
                        color: Colors.red, // Default color for the error text
                        fontWeight: FontWeight.normal, // Optional: Make it less bold
                      ),
                      hintText: "Enter Account Holder Name",
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
                      text: 'Routing Number ',
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
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CommonTextField(
                        controller: addCustomerController.routingNumberController,
                        labelText: "Routing Number",
                        maxLength: 9,
                        focusNode: addCustomerController.routingFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onSubmitted: (value) {
                          addCustomerController.routingNumberController
                              .addListener(_routingNumberListener);
                        },
                        onChanged: (value) {
                          String pattern = r'^\d{9}$';
                          RegExp regExp = RegExp(pattern);
                          setState(() {
                            if (value.isEmpty) {
                              addCustomerController.routingValid = false.obs;
                              addCustomerController.routingErrorMessage =
                              'Routing Number cannot be empty';
                            } else if (!regExp.hasMatch(value)) {
                              addCustomerController.routingValid = false.obs;
                              addCustomerController.routingErrorMessage =
                              'Routing Number must be 9 digits';
                            } else {
                              addCustomerController.routingNumberController
                                  .addListener(_routingNumberListener);
                            }
                          });
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          labelStyle:
                          const TextStyle(color: AppColors.appBlueColor),
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              right: 16, left: 16,top: 12,bottom: 12),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: addCustomerController.routingValid.value
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
                              width: 2,
                            ),
                          ),
                          errorText: addCustomerController.routingValid.value
                              ? null
                              : addCustomerController.routingErrorMessage,
                          errorStyle: const TextStyle(
                            fontSize: 10.0, // Reduced font size for error text
                            color: Colors.red, // Default color for the error text
                            fontWeight: FontWeight.normal, // Optional: Make it less bold
                          ),
                          hintText: "Enter Routing Number",
                          filled: true,
                          fillColor: AppColors.appNeutralColor5,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Routing Number is required';
                          }
                          if (value.trim().length != 9) {
                            return 'Routing Number must be 9 digits';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Visibility(
              visible: addCustomerController.isRoutingNumberValid.value,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0,
                        spreadRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bank Name Row
                      Obx(() => _buildDetailRow(
                          "Bank Name", addCustomerController.bankName.value)),
                      const SizedBox(height: 4),
                      // Holder's Name Row
                      Obx(
                            () => _buildDetailRow(
                            "Address", addCustomerController.bankAddress.value),
                      ),
                      const SizedBox(height: 4),
                      // Postal Code Row
                      Obx(
                            () => _buildDetailRow(
                            "Postal Code", addCustomerController.postalCode.value),
                      ),
                      const SizedBox(height: 4),
                      // State Row
                      Obx(
                            () => _buildDetailRow(
                            "State", addCustomerController.state.value),
                      ),
                      const SizedBox(height: 4),
                      // City Row
                      Obx(
                            () => _buildDetailRow(
                            "City", addCustomerController.city.value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: addCustomerController.isRoutingNumberValid.value,
                child: const SizedBox(
                  height: 16,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Account Number ',
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
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CommonTextField(
                        controller:
                        addCustomerController.accountNumberController.value,
                        labelText: "Account Number",
                        focusNode: addCustomerController.accountNumberFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              addCustomerController.AccountNumberValid = false.obs;
                              addCustomerController.accountNumberErrorMessage =
                              'Account number is required';
                            } else if (value.length > 15) {
                              addCustomerController.AccountNumberValid = false.obs;
                              addCustomerController.accountNumberErrorMessage =
                              'Account number must be 15 digits or less';
                            } else {
                              addCustomerController.AccountNumberValid = true.obs;
                              addCustomerController.accountNumberErrorMessage =
                              null;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          labelStyle:
                          const TextStyle(color: AppColors.appBlueColor),
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              right: 16, left: 16,top: 12,bottom: 12),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: addCustomerController.AccountNumberValid.value
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
                              width: 2,
                            ),
                          ),
                          errorText: addCustomerController.AccountNumberValid.value
                              ? null
                              : addCustomerController.accountNumberErrorMessage,
                          hintText: "Enter Account Number",
                          filled: true,
                          fillColor: AppColors.appNeutralColor5,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Account number is required';
                          }
                          if (value.trim().length > 15) {
                            return 'Account number must be 15 digits or less';
                          }
                          return null; // Return null if the input is valid
                        },
                      );
                    },
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
                      text: 'Confirm Account Number ',
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
                  CommonTextField(
                    controller:
                    addCustomerController.confirmAccountNumberController.value,
                    labelText: "Confirm Account Number",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    focusNode: addCustomerController.confirmAccountNumberFocusNode,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          addCustomerController.ConfirmAccountNumberValid =
                              false.obs;
                          addCustomerController.confirmAccountErrorMessage =
                          'Confirm Account number is required';
                        } else if (value !=
                            addCustomerController.accountNumberController.value.text
                                .trim()) {
                          addCustomerController.ConfirmAccountNumberValid =
                              false.obs;
                          addCustomerController.confirmAccountErrorMessage =
                          'Account Number & Confirm Account Number should be the same';
                        } else if (value.length > 15) {
                          addCustomerController.ConfirmAccountNumberValid =
                              false.obs;
                          addCustomerController.confirmAccountErrorMessage =
                          'Confirm Account number must be 15 digits or less';
                        } else {
                          addCustomerController.ConfirmAccountNumberValid =
                              true.obs;
                          addCustomerController.confirmAccountErrorMessage = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelStyle: const TextStyle(color: AppColors.appBlueColor),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                          right: 16, left: 16,top: 12,bottom: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                          addCustomerController.ConfirmAccountNumberValid.value
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
                          width: 2,
                        ),
                      ),
                      errorText:
                      addCustomerController.ConfirmAccountNumberValid.value
                          ? null
                          : addCustomerController.confirmAccountErrorMessage,
                      errorStyle: const TextStyle(
                        fontSize: 10.0, // Reduced font size for error text
                        color: Colors.red, // Default color for the error text
                        fontWeight: FontWeight.normal, // Optional: Make it less bold
                      ),
                      hintText: "Re-enter Account Number",
                      filled: true,
                      fillColor: AppColors.appNeutralColor5,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm account number is required';
                      }
                      if (value.trim() !=
                          addCustomerController.accountNumberController.value.text
                              .trim()) {
                        return 'Account Number & Confirm Account Number should be the same';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Account Holder’s Address",
              style: TextStyle(
                fontFamily: Constants.Sofiafontfamily,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors.appBlackColor,
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.appBackgroundGreyColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Suit/Apt ',
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
                  CommonTextField(
                    controller: addCustomerController.suitAptController.value,
                    labelText: "Suit/Apt",
                    keyboardType: TextInputType.text,
                    focusNode: addCustomerController.suitAptFocusNode,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          addCustomerController.suitAptValid = false.obs;
                          addCustomerController.suitAptErrorMessage =
                          'Suit/Apt is required';
                        } else {
                          addCustomerController.suitAptValid = true.obs;
                          addCustomerController.suitAptErrorMessage = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelStyle: const TextStyle(color: AppColors.appBlueColor),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                          right: 16, left: 16,top: 12,bottom: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: addCustomerController.suitAptValid.value
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
                          width: 2,
                        ),
                      ),
                      errorText: addCustomerController.suitAptValid.value
                          ? null
                          : addCustomerController.suitAptErrorMessage,
                      hintText: "Enter Suit/Apt",
                      filled: true,
                      fillColor: AppColors.appNeutralColor5,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'suit/Apt is required';
                      }
                      return null;
                    },
                  )
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
                      text: 'Street ',
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
                  CommonTextField(
                    controller: addCustomerController.streetController.value,
                    labelText: "Street",
                    keyboardType: TextInputType.text,
                    focusNode: addCustomerController.streetFocusNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          addCustomerController.streetValid = false.obs;
                          addCustomerController.streetErrorMessage =
                          'Street is required';
                        } else {
                          addCustomerController.streetValid = true.obs;
                          addCustomerController.streetErrorMessage = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelStyle: const TextStyle(color: AppColors.appBlueColor),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                          right: 16, left: 16,top: 12,bottom: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: addCustomerController.streetValid.value
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
                      errorText: addCustomerController.streetValid.value
                          ? null
                          : addCustomerController.streetErrorMessage,
                      hintText: "Enter Street",
                      filled: true,
                      fillColor: AppColors.appNeutralColor5,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Street is required';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Country ',
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
                        CommonTextField(
                          controller: addCustomerController.countryController.value,
                          labelText: "Country",
                          keyboardType: TextInputType.text,
                          focusNode: addCustomerController.countryFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                          ],
                          onChanged: (value) {
                            String pattern = r'^[a-zA-Z\s]*$';
                            RegExp regExp = RegExp(pattern);
                            setState(() {
                              if (value.isEmpty) {
                                addCustomerController.countrytValid = false.obs;
                                addCustomerController.countryterrorMessage =
                                'Country is required';
                              } else if (regExp.hasMatch(value)) {
                                addCustomerController.countrytValid = true.obs;
                                addCustomerController.countryterrorMessage = null;
                              } else {
                                addCustomerController.countrytValid = true.obs;
                                addCustomerController.countryterrorMessage = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelStyle:
                            const TextStyle(color: AppColors.appBlueColor),
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                right: 16, left: 16,top: 12,bottom: 12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: addCustomerController.countrytValid.value
                                    ? AppColors.appNeutralColor5
                                    : AppColors.appRedColor,
                                width: 1,
                              ),
                            ),
                            enabledBorder:  UnderlineInputBorder(
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
                            errorText: addCustomerController.countrytValid.value
                                ? null
                                : addCustomerController.countryterrorMessage,
                            hintText: "Enter Country",
                            filled: true,
                            fillColor: AppColors.appNeutralColor5,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Country is required';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'State ',
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
                        CommonTextField(
                          controller: addCustomerController.stateController.value,
                          labelText: "State",
                          keyboardType: TextInputType.text,
                          focusNode: addCustomerController.stateFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                          ],
                          onChanged: (value) {
                            String pattern = r'^[a-zA-Z\s]*$';
                            RegExp regExp = RegExp(pattern);
                            setState(() {
                              if (value.isEmpty) {
                                addCustomerController.stateValid = false.obs;
                                addCustomerController.stateErrorMessage =
                                'State is required';
                              } else if (regExp.hasMatch(value)) {
                                addCustomerController.stateValid = true.obs;
                                addCustomerController.stateErrorMessage = null;
                              } else {
                                addCustomerController.stateValid = true.obs;
                                addCustomerController.stateErrorMessage = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelStyle:
                            const TextStyle(color: AppColors.appBlueColor),
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                right: 16, left: 16,top: 12,bottom: 12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: addCustomerController.stateValid.value
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
                            errorText: addCustomerController.stateValid.value
                                ? null
                                : addCustomerController.stateErrorMessage,
                            hintText: "Enter State",
                            filled: true,
                            fillColor: AppColors.appNeutralColor5,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'State is required';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'City ',
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
                        CommonTextField(
                          controller: addCustomerController.cityController.value,
                          labelText: "City",
                          focusNode: addCustomerController.cityFocusNode,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                addCustomerController.cityValid = false.obs;
                                addCustomerController.cityErrorMessage =
                                'City is required';
                              } else {
                                addCustomerController.cityValid = true.obs;
                                addCustomerController.cityErrorMessage = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelStyle:
                            const TextStyle(color: AppColors.appBlueColor),
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                right: 16, left: 16,top: 12,bottom: 12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: addCustomerController.cityValid.value
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
                            errorText: addCustomerController.cityValid.value
                                ? null
                                : addCustomerController.cityErrorMessage,
                            hintText: "Enter City",
                            filled: true,
                            fillColor: AppColors.appNeutralColor5,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'City is required';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Zip Code ',
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
                        CommonTextField(
                          controller: addCustomerController.zipController.value,
                          labelText: "Zip Code",
                          focusNode: addCustomerController.zipcodeFocusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            String pattern = r'^\d{6}$';
                            RegExp regExp = RegExp(pattern);
                            setState(() {
                              if (value.isEmpty) {
                                addCustomerController.zipcodeValid = false.obs;
                                addCustomerController.zipcodeErrorMessage =
                                'Zip Code is required';
                              } else if (!regExp.hasMatch(value)) {
                                addCustomerController.zipcodeValid = false.obs;
                                addCustomerController.zipcodeErrorMessage =
                                'Zip Code must be 6 digits';
                              } else {
                                addCustomerController.zipcodeValid = true.obs;
                                addCustomerController.zipcodeErrorMessage = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelStyle:
                            const TextStyle(color: AppColors.appBlueColor),
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                right: 16, left: 16,top: 12,bottom: 12),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: addCustomerController.zipcodeValid.value
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
                            errorText: addCustomerController.zipcodeValid.value
                                ? null
                                : addCustomerController.zipcodeErrorMessage,
                            hintText: "Enter Zip Code",
                            filled: true,
                            fillColor: AppColors.appNeutralColor5,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Zip Code is required';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch(
                  value: addCustomerController.isSwitched = true,
                  onChanged: (value) {
                    setState(() {
                      addCustomerController.isSwitched =
                          value;
                    });
                  },
                  activeColor: AppColors.appBlueColor,
                  inactiveThumbColor:
                  AppColors.appGreyColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'Primary',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: Constants.Sofiafontfamily,
                      color: AppColors.appGreyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountAddView(
      List<Items> accountItems, BuildContext context, String title, int index) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.transparent,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      setState(() {
                        editAccountPopup(context, index);
                      });
                    } else if (value == 'remove') {
                      if (addCustomerController.accountDetailsList.length <=
                          1) {
                        MyToast.toast(
                            "You need at least one account to proceed.");
                      } else {
                        setState(() {
                          addCustomerController.removeAccountDetail(index);
                          addCustomerController.clearAllAccount();
                          addCustomerController.accountDetailsList.isEmpty
                              ? buildAccountForm(context)
                              : '';
                        });
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'edit',
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage( ImageAssets.EditIcon),
                              width: 16,
                              height: 16,
                              color: AppColors.appBlackColor,
                            ),
                            const SizedBox(width: 4),
                            const Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'remove',
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage( ImageAssets.removeImage),
                              width: 16,
                              height: 16,
                              color: AppColors.appBlackColor,
                            ),
                            const SizedBox(width: 4),
                            const Text('Remove'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDetailRow(
                          "Holder's Name", accountItems[index].accountName),
                      const SizedBox(height: 4),
                      _buildDetailRow(
                          "Account Number", accountItems[index].accountNumber),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: accountItems[index].primary,
                            onChanged: (value) {
                              setState(() {
                                addCustomerController.isSwitched = value;
                              });
                            },
                            activeColor: AppColors.appBlueColor,
                            inactiveThumbColor: AppColors
                                .appGreyColor,
                          ),
                          Text(
                            'Primary',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: Constants.Sofiafontfamily,
                                color: AppColors.appGreyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addAccountPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddAccountPopup('', onSave: () {
            setState(() {});
          }),
        );
      },
    );
  }

  void editAccountPopup(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: EditAccountPopup(index),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style:  AppTextStyles.regularText,
          ),
        ),
        Text(
          ':',
          style: AppTextStyles.boldText,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: AppTextStyles.boldText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
