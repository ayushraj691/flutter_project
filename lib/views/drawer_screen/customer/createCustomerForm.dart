import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqAddCustomer.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/drawer_screen/customer/add_account_popup.dart';
import 'package:paycron/views/drawer_screen/customer/edit_account_popup.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  var addCustomerController = Get.find<AddCustomerController>();
  final _formKey = GlobalKey<FormState>();
  int currentStep = 1;
  bool _isAccountDetail = false;
  bool isPersonalDetailsFilled = false;
  String selectedCountryCode = '+1';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Action for back arrow
          },
        ),
        titleSpacing: 0, // Removes extra space between arrow and title
        title: const Text(
          "Create Customer",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05), // 5% of the screen width
        // height: screenHeight * 0.8, // 80% of the screen height
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Center(
              //   child: Container(
              //     width: 60,
              //     padding: EdgeInsets.all(3.0),
              //     decoration: BoxDecoration(
              //       color: AppColors.appGreyColor,
              //       borderRadius: BorderRadius.circular(30.0),
              //       border: Border.all(color: AppColors.appGreyColor, width: 1.5),
              //     ),
              //   ),
              // ),
              // SizedBox(height: screenHeight * 0.02), // Responsive space
              // const Text(
              //   "Create Customer",
              //   style: TextStyle(
              //     fontFamily: 'Sofia Sans',
              //     fontSize: 16.0,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.appBlackColor,
              //   ),
              // ),
              // SizedBox(height: screenHeight * 0.02),
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
                              SizedBox(width: screenWidth * 0.02),
                              isPersonalDetailsFilled == true
                                  ? Image.asset(ImageAssets.success)
                                  : SizedBox.shrink(),
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
                        if (addCustomerController.nameController.value.text
                            .trim()
                            .isEmpty) {
                          MyToast.toast("Please Enter Name");
                        } else if (addCustomerController
                            .mobileController.value.text
                            .trim()
                            .isEmpty) {
                          MyToast.toast("Please Enter Mobile Number");
                        } else if (addCustomerController
                            .emailController.value.text
                            .trim()
                            .isEmpty) {
                          MyToast.toast("Please Enter Email ID");
                        } else if (addCustomerController
                            .descriptionController.value.text
                            .trim()
                            .isEmpty) {
                          MyToast.toast("Please Enter Description");
                        } else {
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
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align fields to the left in the column
                    children: [
                      if (currentStep == 1) ...[
                        buildField(
                            context,
                            'Name',
                            'Enter Name',
                            addCustomerController.nameController,
                            TextInputType.text),
                        // buildMultilineField(
                        //     context,
                        //     'Mobile Number',
                        //     'Enter Mobile Number',
                        //     10,
                        //     addCustomerController.mobileController,
                        //     TextInputType.number),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.appNeutralColor5,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.appNeutralColor5, width: 0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: CountryCodePicker(
                                onChanged: (countryCode) {
                                  setState(() {
                                    selectedCountryCode = countryCode.dialCode!;
                                  });
                                },
                                initialSelection: 'US',
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                textStyle: const TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 16,
                                  color: AppColors.appTextColor,
                                ),
                                padding: const EdgeInsets.all(0),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: addCustomerController.mobileController,
                                maxLength: 10, // Limit to 10 digits
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 16,
                                  color: AppColors.appTextColor,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'Enter Mobile Number',
                                  // labelText: 'Mobile Number',
                                  labelStyle: const TextStyle(color: AppColors.appGreyColor),
                                  filled: true,
                                  fillColor: AppColors.appNeutralColor5,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: AppColors.appNeutralColor5, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: AppColors.appNeutralColor5, width: 0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: AppColors.appNeutralColor5, width: 0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        buildField(
                            context,
                            'Email Id',
                            'Enter Email Id',
                            addCustomerController.emailController,
                            TextInputType.emailAddress),
                        // buildField(context, 'Description', 'Enter Description',
                        //     addCustomerController.descriptionController),
                        RichText(
                          text: const TextSpan(
                            text: 'Description',
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
                        TextFormField(
                          controller:
                              addCustomerController.descriptionController,
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
                            contentPadding: EdgeInsets.all(16.0),
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
                      ] else if (currentStep == 2) ...[
                        _isAccountDetail
                            ? Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  // Prevent scrolling inside the ListView
                                  itemCount: addCustomerController
                                      .accountDetailsList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildAccountAddView(
                                            addCustomerController
                                                .accountDetailsList,
                                            context,
                                            "Account${index + 1}",
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
              // Responsive space
              Center(
                child: currentStep == 1
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (addCustomerController.nameController.value.text
                                .trim()
                                .isEmpty) {
                              MyToast.toast("Please Enter Name");
                            } else if (addCustomerController
                                .mobileController.value.text
                                .trim()
                                .isEmpty) {
                              MyToast.toast("Please Enter Mobile Number");
                            } else if (addCustomerController
                                .emailController.value.text
                                .trim()
                                .isEmpty) {
                              MyToast.toast("Please Enter Email ID");
                            } else if (addCustomerController
                                .descriptionController.value.text
                                .trim()
                                .isEmpty) {
                              MyToast.toast("Please Enter Description");
                            } else {
                              setState(() {
                                currentStep = 2;
                                addCustomerController.accountDetailsList
                                    .clear();
                                isPersonalDetailsFilled = true;
                                addCustomerController.accountDetailsList.isEmpty
                                    ? _isAccountDetail = false
                                    : _isAccountDetail = true;
                                addCustomerController.isSwitched=true;
                              });
                            }
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
                        // Adjust spacing between buttons
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => {
                                addCustomerController.clearAllAccount(),
                                _isAccountDetail
                                    ? addAccountPopup(context)
                                    : '',
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor: AppColors.appBlueColor),
                              child: const Text(
                                "Add More",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Add space between buttons
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                addCustomerController.accountDetailsList.clear();
                                addCustomerController.addAccountDetail();
                                addCustomerController.insertCustomerData();
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Account Details",
              style: TextStyle(
                fontFamily: 'Sofia Sans',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors.appBlackColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isAccountDetail = true;
                  addCustomerController.addAccountDetail();
                  addCustomerController.clearAllAccount();
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
        buildField(
            context,
            'Account Holder Name',
            'Enter Account Holder Name',
            addCustomerController.accountHolderNameController,
            TextInputType.text),
        buildMultilineField(
            context,
            'Routing Number',
            'Enter Routing Number',
            9,
            addCustomerController.routingNumberController,
            TextInputType.number),
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
                  Obx(() => _buildDetailRow("Bank Name", addCustomerController.bankName.value)),
                  const SizedBox(height: 4),
                  // Holder's Name Row
                  Obx(() => _buildDetailRow("Address", addCustomerController.bankAddress.value),),
                  const SizedBox(height: 4),
                  // Postal Code Row
                  Obx(() => _buildDetailRow("Postal Code", addCustomerController.postalCode.value),),
                  const SizedBox(height: 4),
                  // State Row
                  Obx(() =>  _buildDetailRow("State", addCustomerController.state.value),),
                  const SizedBox(height: 4),
                  // City Row
                  Obx(() => _buildDetailRow("City", addCustomerController.city.value),),
                ],
              ),
            ),
          ),
        ),
        Visibility(
            visible: addCustomerController.isRoutingNumberValid.value,
            child: SizedBox(height: 16,)),
        buildField(
            context,
            'Account Number',
            'Enter Account Number',
            addCustomerController.accountNumberController,
            TextInputType.number),
        buildField(
            context,
            'Confirm Account Number',
            'Enter Confirm Account Number',
            addCustomerController.confirmAccountNumberController,
            TextInputType.number),
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
        buildField(context, 'Suit/Apt', 'Enter Suit/Apt',
            addCustomerController.suitAptController, TextInputType.text),
        buildField(context, 'Street', 'Enter Street',
            addCustomerController.streetController, TextInputType.text),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: buildField(
                    context,
                    'Country',
                    'Enter Country',
                    addCustomerController.countryController,
                    TextInputType.text)),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
                child: buildField(context, 'State', 'Enter State',
                    addCustomerController.stateController, TextInputType.text)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: buildField(context, 'City', 'Enter City',
                  addCustomerController.cityController, TextInputType.text),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: buildField(context, 'Zip Code', 'Enter Zip Code',
                  addCustomerController.zipController, TextInputType.text),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Switch(
              value: addCustomerController.isSwitched=true,
              onChanged: (value) {
                setState(() {
                  addCustomerController.isSwitched =
                      value; // Update the state on toggle
                });
              },
              activeColor: AppColors.appBlueColor,
              // Color when switch is ON
              inactiveThumbColor:
                  AppColors.appGreyColor, // Color of the switch when OFF
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
        // CustomSwitchButton(
        //   onChanged: (value) {
        //     setState(() {
        //       addCustomerController.isSwitched =
        //           value;
        //     });
        //   },
        // ),
      ],
    );
  }

  Widget buildAccountAddView(
      List<Items> accountItems, BuildContext context, String title, int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Make the popup circular
                ),
                color: Colors.transparent,
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Circular dialog shape
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      setState(() {
                        editAccountPopup(context, index);
                      });
                    } else if (value == 'remove') {
                      setState(() {
                        addCustomerController.removeAccountDetail(index);
                        addCustomerController.clearAllAccount();
                        addCustomerController.accountDetailsList.isEmpty
                            ? buildAccountForm(context)
                            : '';
                      });
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined,
                                color: AppColors.appBlackColor),
                            // Icon for edit
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'remove',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline_outlined,
                                color: AppColors.appBlackColor),
                            // Icon for remove
                            SizedBox(width: 8),
                            Text('Remove'),
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
            // Ensure space between details and menu
            children: [
              // Account details section
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDetailRow(
                          "Holder's Name", accountItems[index].accountName),
                      const SizedBox(height: 4),
                      // Reduced spacing for a compact look
                      _buildDetailRow(
                          "Account Number", accountItems[index].accountNumber),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: accountItems[index].primary,
                            onChanged: (value) {
                              setState(() {
                                addCustomerController.isSwitched =
                                    value; // Update the state on toggle
                              });
                            },
                            activeColor: AppColors.appBlueColor,
                            // Color when switch is ON
                            inactiveThumbColor: AppColors
                                .appGreyColor, // Color of the switch when OFF
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Primary',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Sofia Sans',
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
          child: AddAccountPopup(''),
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
          const SizedBox(height: 4.0),
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
}
