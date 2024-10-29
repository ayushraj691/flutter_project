import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class AddAccountPopup extends StatefulWidget {
  final String id;
  const AddAccountPopup( this.id, {super.key});

  @override
  State<AddAccountPopup> createState() => _AddAccountPopupState();
}

class _AddAccountPopupState extends State<AddAccountPopup> {

  var addCustomerController = Get.find<AddCustomerController>();
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
  void _routingNumberListener() async{
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

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      height: screenHeight * 0.8,
      child: Form(
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
                "Add More Account",
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
              "Account Details",
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
                child: Container(
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
                                text: 'Account Holder Name ',
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
                              controller: addCustomerController.accountHolderNameController,
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
                                    addCustomerController.AccountNameValid = false;
                                  } else if (regExp.hasMatch(value)) {
                                    addCustomerController.AccountNameValid = true;
                                  } else {
                                    addCustomerController.AccountNameValid = false;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.all(18),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.AccountNameValid
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
                                errorText: addCustomerController.AccountNameValid
                                    ? null
                                    : 'Account Holder Name is required',
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
                              text: const TextSpan(
                                text: 'Routing Number ',
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
                                        addCustomerController.routingValid = false;
                                        addCustomerController.routingErrorMessage =
                                        'Routing Number cannot be empty';
                                      } else if (!regExp.hasMatch(value)) {
                                        addCustomerController.routingValid = false;
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
                                    contentPadding: const EdgeInsets.all(18),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: addCustomerController.routingValid
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
                                        width: 2,
                                      ),
                                    ),
                                    errorText: addCustomerController.routingValid
                                        ? null
                                        : addCustomerController.routingErrorMessage,
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
                            padding: EdgeInsets.all(16),
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
                              text: const TextSpan(
                                text: 'Account Number ',
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
                            StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return CommonTextField(
                                  controller: addCustomerController.accountNumberController,
                                  labelText: "Account Number",
                                  focusNode: addCustomerController.accountNumberFocusNode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        addCustomerController.AccountNumberValid = false;
                                        addCustomerController.accountNumberErrorMessage =
                                        'Account number is required';
                                      } else if (value.length > 15) {
                                        addCustomerController.AccountNumberValid = false;
                                        addCustomerController.accountNumberErrorMessage =
                                        'Account number must be 15 digits or less';
                                      } else {
                                        addCustomerController.AccountNumberValid = true;
                                        addCustomerController.accountNumberErrorMessage =
                                        null;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    labelStyle:
                                    const TextStyle(color: AppColors.appBlueColor),
                                    contentPadding: const EdgeInsets.all(18),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: addCustomerController.AccountNumberValid
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
                                        width: 2,
                                      ),
                                    ),
                                    errorText: addCustomerController.AccountNumberValid
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
                              text: const TextSpan(
                                text: 'Confirm Account Number ',
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
                              addCustomerController.confirmAccountNumberController,
                              labelText: "Confirm Account Number",
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              focusNode: addCustomerController.confirmAccountNumberFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    addCustomerController.ConfirmAccountNumberValid = false;
                                    addCustomerController.confirmAccountErrorMessage =
                                    'Confirm Account number is required';
                                  } else if (value !=
                                      addCustomerController.accountNumberController.text
                                          .trim()) {
                                    addCustomerController.ConfirmAccountNumberValid = false;
                                    addCustomerController.confirmAccountErrorMessage =
                                    'Account Number & Confirm Account Number should be the same';
                                  } else if (value.length > 15) {
                                    addCustomerController.ConfirmAccountNumberValid = false;
                                    addCustomerController.confirmAccountErrorMessage =
                                    'Confirm Account number must be 15 digits or less';
                                  } else {
                                    addCustomerController.ConfirmAccountNumberValid = true;
                                    addCustomerController.confirmAccountErrorMessage = null;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.all(18),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.ConfirmAccountNumberValid
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
                                    width: 2,
                                  ),
                                ),
                                errorText: addCustomerController.ConfirmAccountNumberValid
                                    ? null
                                    : addCustomerController.confirmAccountErrorMessage,
                                hintText: "Re-enter Account Number",
                                filled: true,
                                fillColor: AppColors.appNeutralColor5,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Confirm account number is required';
                                }
                                if (value.trim() !=
                                    addCustomerController.accountNumberController.text
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
                      const Text(
                        "Account Holder’s Address",
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
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
                              text: const TextSpan(
                                text: 'Suit/Apt ',
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
                              controller: addCustomerController.suitAptController,
                              labelText: "Suit/Apt",
                              keyboardType: TextInputType.text,
                              focusNode: addCustomerController.suitAptFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    addCustomerController.suitAptValid = false;
                                    addCustomerController.suitAptErrorMessage =
                                    'Suit/Apt is required';
                                  } else {
                                    addCustomerController.suitAptValid = true;
                                    addCustomerController.suitAptErrorMessage = null;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.all(18),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.suitAptValid
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
                                    width: 2,
                                  ),
                                ),
                                errorText: addCustomerController.suitAptValid
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
                              text: const TextSpan(
                                text: 'Street ',
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
                              controller: addCustomerController.streetController,
                              labelText: "Street",
                              keyboardType: TextInputType.text,
                              focusNode: addCustomerController.streetFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    addCustomerController.streetValid = false;
                                    addCustomerController.streetErrorMessage =
                                    'Street is required';
                                  } else {
                                    addCustomerController.streetValid = true;
                                    addCustomerController.streetErrorMessage = null;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                contentPadding: const EdgeInsets.all(18),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: addCustomerController.streetValid
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
                                    width: 2,
                                  ),
                                ),
                                errorText: addCustomerController.streetValid
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
                                    text: const TextSpan(
                                      text: 'Country ',
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
                                    controller: addCustomerController.countryController,
                                    labelText: "Country",
                                    keyboardType: TextInputType.text,
                                    focusNode: addCustomerController.countryFocusNode,
                                    onChanged: (value) {
                                      String pattern = r'^[a-zA-Z\s]*$';
                                      RegExp regExp = RegExp(pattern);
                                      setState(() {
                                        if (value.isEmpty) {
                                          addCustomerController.countrytValid = false;
                                          addCustomerController.countryterrorMessage =
                                          'Country is required';
                                        } else if (regExp.hasMatch(value)) {
                                          addCustomerController.countrytValid = true;
                                          addCustomerController.countryterrorMessage = null;
                                        } else {
                                          addCustomerController.countrytValid = true;
                                          addCustomerController.countryterrorMessage = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelStyle:
                                      const TextStyle(color: AppColors.appBlueColor),
                                      contentPadding: const EdgeInsets.all(18),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: addCustomerController.countrytValid
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
                                          width: 2,
                                        ),
                                      ),
                                      errorText: addCustomerController.countrytValid
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
                                    text: const TextSpan(
                                      text: 'State ',
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
                                    controller: addCustomerController.stateController,
                                    labelText: "State",
                                    keyboardType: TextInputType.text,
                                    focusNode: addCustomerController.stateFocusNode,
                                    onChanged: (value) {
                                      String pattern = r'^[a-zA-Z\s]*$';
                                      RegExp regExp = RegExp(pattern);
                                      setState(() {
                                        if (value.isEmpty) {
                                          addCustomerController.stateValid = false;
                                          addCustomerController.stateErrorMessage =
                                          'State is required';
                                        } else if (regExp.hasMatch(value)) {
                                          addCustomerController.stateValid = true;
                                          addCustomerController.stateErrorMessage = null;
                                        } else {
                                          addCustomerController.stateValid = true;
                                          addCustomerController.stateErrorMessage = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelStyle:
                                      const TextStyle(color: AppColors.appBlueColor),
                                      contentPadding: const EdgeInsets.all(18),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: addCustomerController.stateValid
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
                                          width: 2,
                                        ),
                                      ),
                                      errorText: addCustomerController.stateValid
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
                                    text: const TextSpan(
                                      text: 'City ',
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
                                    controller: addCustomerController.cityController,
                                    labelText: "City",
                                    focusNode: addCustomerController.cityFocusNode,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          addCustomerController.cityValid = false;
                                          addCustomerController.cityErrorMessage =
                                          'City is required';
                                        } else {
                                          addCustomerController.cityValid = true;
                                          addCustomerController.cityErrorMessage = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelStyle:
                                      const TextStyle(color: AppColors.appBlueColor),
                                      contentPadding: const EdgeInsets.all(18),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: addCustomerController.cityValid
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
                                          width: 2,
                                        ),
                                      ),
                                      errorText: addCustomerController.cityValid
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
                                    text: const TextSpan(
                                      text: 'Zip Code ',
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
                                    controller: addCustomerController.zipController,
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
                                          addCustomerController.zipcodeValid = false;
                                          addCustomerController.zipcodeErrorMessage =
                                          'Zip Code is required';
                                        } else if (!regExp.hasMatch(value)) {
                                          addCustomerController.zipcodeValid = false;
                                          addCustomerController.zipcodeErrorMessage =
                                          'Zip Code must be 6 digits';
                                        } else {
                                          addCustomerController.zipcodeValid = true;
                                          addCustomerController.zipcodeErrorMessage = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelStyle:
                                      const TextStyle(color: AppColors.appBlueColor),
                                      contentPadding: const EdgeInsets.all(18),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: addCustomerController.zipcodeValid
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
                                          width: 2,
                                        ),
                                      ),
                                      errorText: addCustomerController.zipcodeValid
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
                            value:addCustomerController.isSwitched,
                            onChanged: (value) {
                              setState(() {
                               addCustomerController.isSwitched =
                                    value;
                              });
                            },
                            activeColor: AppColors.appBlueColor,
                            inactiveThumbColor:
                            AppColors.appGreyColor, // Color of the switch when OFF
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Make It Primary',
                            style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400
                                , fontFamily: 'Sofia Sans',color: AppColors.appGreyColor),
                          ),
                        ],
                      ),
                      // SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(widget.id.isEmpty){
                                if (addCustomerController.validation()){
                                addCustomerController.addAccountDetail();
                                addCustomerController.clearAllAccount();
                                Navigator.pop(context);
                                }
                              }else{
                                addCustomerController.addSingleAccount(widget.id);
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(':  $value',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
        ],
      ),
    );
  }

  Widget buildField(
      BuildContext context,
      String label,
      String hintText,
      TextEditingController controller,
      TextInputType keyboardType,
      bool? isMandatory,
      [String? regexPattern, List<TextInputFormatter>? inputFormatters]  // Optional regex pattern for additional validation
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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
              children: [
                if (isMandatory ?? false) // Show '*' if the field is mandatory
                  const TextSpan(
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
            hintText: hintText,
            controller: controller,
            labelText: label,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: (value) {
              if ((isMandatory ?? false) && (value == null || value.isEmpty)) {
                return '$label is required';
              }
              if (regexPattern != null && value != null && value.isNotEmpty) {
                final regex = RegExp(regexPattern);
                if (!regex.hasMatch(value)) {
                  return 'Invalid $label format';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }


  Widget buildMultilineField(
      BuildContext context,
      String label,
      String hintText,
      int maxlength,
      TextEditingController controller,
      TextInputType keyboardType,
      bool? isMandatory,
      [String? regexPattern, List<TextInputFormatter>? inputFormatters]// Optional regex pattern for additional validation
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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
              children: [
                if (isMandatory ?? false) // Show '*' if the field is mandatory
                  const TextSpan(
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
            hintText: hintText,
            controller: controller,
            labelText: label,
            maxLength: maxlength,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: (value) {
              if ((isMandatory ?? false) && (value == null || value.isEmpty)) {
                return '$label is required';
              }
              if (maxlength == 9 && value!.trim().length < 9) {
                return '$label must be 9 digits';
              }
              if (maxlength == 6 && value!.trim().length < 6) {
                return '$label must be 6 digits';
              }
              if (label == 'Confirm Account Number' &&
                  addCustomerController.accountNumberController.text.trim() !=
                      addCustomerController.confirmAccountNumberController.text.trim()) {
                return 'Account Number & Confirm Account Number Should Be Same';
              }
              if (maxlength >= 15 && value != null && value.trim().length > 15) {
                return '$label must be 15 digits or less';
              }
              if (regexPattern != null && value != null && value.isNotEmpty) {
                final regex = RegExp(regexPattern);
                if (!regex.hasMatch(value)) {
                  return 'Invalid $label format';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
