import 'package:flutter/material.dart';
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

  bool _apiCalled = false;

  String _lastValidatedRoutingNumber = "";

  @override
  void initState() {
    super.initState();
    addCustomerController = Get.find<AddCustomerController>();
    addCustomerController.routingNumberController.addListener(_routingNumberListener);
  }

  void _routingNumberListener() {
    final input = addCustomerController.routingNumberController.text;

    // Reset _apiCalled if routing number is cleared
    if (input.isEmpty) {
      _apiCalled = false;
      _lastValidatedRoutingNumber = ""; // Clear the last validated number
    }

    if (input.length == 9 && !_apiCalled && input != _lastValidatedRoutingNumber) {
      _apiCalled = true;
      _lastValidatedRoutingNumber = input;  // Store this validated routing number
      _checkRoutingNumber(input);
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> _checkRoutingNumber(String routingNumber) async {
    await addCustomerController.validateRoutingNumber(routingNumber.trim());
    setState(() {
      // Any UI changes can be triggered here if necessary
    });
  }

  @override
  void dispose() {
    addCustomerController.routingNumberController.removeListener(_routingNumberListener);
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
                  // Limit width to avoid infinite constraints
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                          context,
                          'Account Holder Name',
                          'Enter Account Holder Name',
                         addCustomerController.accountHolderNameController,TextInputType.text),
                      buildMultilineField(
                          context,
                          'Routing Number',
                          'Enter Routing Number',
                          9,
                         addCustomerController.routingNumberController,
                          TextInputType.number),

                      Visibility(
                        visible:addCustomerController.isRoutingNumberValid.value,
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
                                Obx(() => _buildDetailRow("Bank Name",addCustomerController.bankName.value)),
                                const SizedBox(height: 4),
                                // Holder's Name Row
                                Obx(() => _buildDetailRow("Address",addCustomerController.bankAddress.value),),
                                const SizedBox(height: 4),
                                // Postal Code Row
                                Obx(() => _buildDetailRow("Postal Code",addCustomerController.postalCode.value),),
                                const SizedBox(height: 4),
                                // State Row
                                Obx(() =>  _buildDetailRow("State",addCustomerController.state.value),),
                                const SizedBox(height: 4),
                                // City Row
                                Obx(() => _buildDetailRow("City",addCustomerController.city.value),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible:addCustomerController.isRoutingNumberValid.value,
                          child: SizedBox(height: 16,)),

                      buildField(
                          context,
                          'Account Number',
                          'Enter Account Number',
                         addCustomerController.accountNumberController,TextInputType.number),
                      buildField(
                          context,
                          'Confirm Account Number',
                          'Enter Confirm Account Number',
                         addCustomerController.confirmAccountNumberController,TextInputType.number),
                      buildField(context, 'Suit/Apt', 'Enter Suit/Apt',
                         addCustomerController.suitAptController,TextInputType.text),
                      buildField(context, 'Street', 'Enter Street',
                         addCustomerController.streetController,TextInputType.text),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: buildField(
                                context,
                                'Country',
                                'Enter Country',
                               addCustomerController.countryController,TextInputType.text),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: buildField(context, 'State', 'Enter State',
                               addCustomerController.stateController,TextInputType.text),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: buildField(context, 'City', 'Enter City',
                               addCustomerController.cityController,TextInputType.text),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: buildField(
                                context,
                                'Zip Code',
                                'Enter Zip Code',
                               addCustomerController.zipController,TextInputType.number),
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
                                addCustomerController.addAccountDetail();
                                addCustomerController.clearAllAccount();
                                Navigator.pop(context);
                              }else{
                                addCustomerController.addSingleAccount(widget.id);
                                Navigator.pop(context);
                              }
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


  Widget buildMultilineField(
      BuildContext context,
      String label,
      String hintText,
      int maxlength,
      TextEditingController controller,
      TextInputType keyboardType) {
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
            maxLength: maxlength,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  Widget buildField(BuildContext context, String label, String hintText,
      TextEditingController controller, TextInputType keyboardType) {
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
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }
}
