import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class EditAccountPopup extends StatefulWidget {
  final index;

  EditAccountPopup(this.index);

  @override
  State<EditAccountPopup> createState() => _EditAccountPopupState();
}

class _EditAccountPopupState extends State<EditAccountPopup> {
  var addCustomerController = Get.find<AddCustomerController>();

  @override
  void initState() {
      callMethod();
    super.initState();
  }

  void callMethod() {
    addCustomerController.accountHolderNameController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].accountName,
    );
    addCustomerController.routingNumberController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].routingNumber,
    );
    addCustomerController.accountNumberController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].accountNumber,
    );
    addCustomerController.confirmAccountNumberController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].confirmAccountNumber,
    );
    addCustomerController.streetController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].address,
    );
    addCustomerController.countryController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].country,
    );
    addCustomerController.stateController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].state,
    );
    addCustomerController.cityController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].city,
    );
    addCustomerController.suitAptController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].apartment,
    );
    addCustomerController.zipController = TextEditingController(
      text: addCustomerController.accountDetailsList[widget.index].postalCode,
    );
    addCustomerController.isSwitched = addCustomerController.accountDetailsList[widget.index].primary;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05), // 5% of the screen width
      height: screenHeight * 0.8, // 80% of the screen height
      child: Form(
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
            SizedBox(height: 2),
            const Divider(
              thickness: 1,
              color: AppColors.appGreyColor,
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth * 0.9,
                  // Limit width to avoid infinite constraints
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                          context,
                          'Account Holder Name',
                          'Enter Account Holder Name',
                          addCustomerController.accountHolderNameController),
                      buildField(
                          context,
                          'Routing Number',
                          'Enter Routing Number',
                          addCustomerController.routingNumberController),
                      buildField(
                          context,
                          'Account Number',
                          'Enter Account Number',
                          addCustomerController.accountNumberController),
                      buildField(
                          context,
                          'Confirm Account Number',
                          'Enter Confirm Account Number',
                          addCustomerController.confirmAccountNumberController),
                      buildField(context, 'Suit/Apt', 'Enter Suit/Apt',
                          addCustomerController.suitAptController),
                      buildField(context, 'Street', 'Enter Street',
                          addCustomerController.streetController),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: buildField(
                              context,
                              'Country',
                              'Enter Country',
                              addCustomerController.countryController,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: buildField(context, 'State', 'Enter State',
                                addCustomerController.stateController),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: buildField(context, 'City', 'Enter City',
                                addCustomerController.cityController),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: buildField(
                                context,
                                'Zip Code',
                                'Enter Zip Code',
                                addCustomerController.zipController),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: addCustomerController.isSwitched,
                            onChanged: (value) {
                              setState(() {
                                addCustomerController.isSwitched =
                                    value;
                              });
                            },
                            activeColor: AppColors.appBlueColor,
                            // Color when switch is ON
                            inactiveThumbColor: AppColors
                                .appGreyColor, // Color of the switch when OFF
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Make It Primary',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Sofia Sans',
                                color: AppColors.appGreyColor),
                          ),
                        ],
                      ),
                      // SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              addCustomerController.addAccountDetail();
                              addCustomerController.clearAllAccount();
                              addCustomerController.removeAccountDetail(widget.index);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
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
