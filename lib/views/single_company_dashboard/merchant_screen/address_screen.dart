import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

import '../../../utils/string_constants.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Your Address",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: Constants.Sofiafontfamily,
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
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "Country",
                                  controller: merchantController.country.value,
                                  labelText: "Country",
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
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "State",
                                  controller: merchantController.state.value,
                                  labelText: "State",
                                  enable: false,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            CommonTextField(
                                              controller: merchantController
                                                  .pinCode.value,
                                              hintText: "Zip Code",
                                              labelText: "Zip Code",
                                              keyboardType: TextInputType.text,
                                              enable: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            CommonTextField(
                                              controller:
                                                  merchantController.city.value,
                                              labelText: "City",
                                              hintText: "City",
                                              keyboardType: TextInputType.text,
                                              enable: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Street Address ',
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
                                  hintText: "Street Address",
                                  controller:
                                      merchantController.streetAddress.value,
                                  labelText: "Street Address",
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
