import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/all_company_controller/businessProfileController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  bool isBusinessDetailsExpanded = true;
  bool isPricipalOwnerDetailsExpanded = true;
  bool isBankDetailsExpanded = true;
  bool isSupportDetailsExpanded = true;

  var businessProfileController = Get.find<BusinessProfileController>();
  var variableController = Get.find<VariableController>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      callMethod();
    });
    super.initState();
  }

  void callMethod() async {
    await businessProfileController.getBusinessData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.01;
    double verticalPadding = screenHeight * 0.02;
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
          'Set up your account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: Constants.Sofiafontfamily,
          ),
        ),
      ),
      body: variableController.loading.value
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                child: Lottie.asset("assets/lottie/half-circles.json"),
              ),
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Business Profile",
                          style: TextStyle(
                            fontFamily: Constants.Sofiafontfamily,
                            color: AppColors.appBlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 16,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Details Summary",
                            style: TextStyle(
                              fontFamily: Constants.Sofiafontfamily,
                              color: AppColors.appBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 12.0, bottom: 6),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageAssets.EditIcon,
                                  width: 24,
                                  height: 24,
                                  color: AppColors.appBlueColor,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  "Send edit request",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    fontFamily: Constants.Sofiafontfamily,
                                    color: AppColors.appBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildCustomerDetailCollapsibleSection(
                      title: "Business Details",
                      isExpanded: isBusinessDetailsExpanded,
                      onToggle: () {
                        setState(() {
                          isBusinessDetailsExpanded =
                              !isBusinessDetailsExpanded;
                        });
                      },
                      child: _buildBusinessDetailsCard(),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _buildCustomerDetailCollapsibleSection(
                      title: "Plan Detail",
                      isExpanded: isPricipalOwnerDetailsExpanded,
                      onToggle: () {
                        setState(() {
                          isPricipalOwnerDetailsExpanded =
                              !isPricipalOwnerDetailsExpanded;
                        });
                      },
                      child: _buildPrincipalOwnerDetailsCard(),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _buildCustomerDetailCollapsibleSection(
                      title: "Bank Details",
                      isExpanded: isBankDetailsExpanded,
                      onToggle: () {
                        setState(() {
                          isBankDetailsExpanded = !isBankDetailsExpanded;
                        });
                      },
                      child: _buildBankDetailsCard(),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _buildCustomerDetailCollapsibleSection(
                      title: "Support Information",
                      isExpanded: isSupportDetailsExpanded,
                      onToggle: () {
                        setState(() {
                          isSupportDetailsExpanded = !isSupportDetailsExpanded;
                        });
                      },
                      child: _buildSupportInformationCard(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCustomerDetailCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: AppColors.appBlackColor),
              ],
            ),
            onTap: onToggle,
          ),
          if (isExpanded) child,
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Legal Business Name",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.legalBusinessName.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Complete Business Address",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.completeBusinessAddress.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Business License",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.businessLicense.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Employer Identification Number (EIN)",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.employerIdentificationNumber.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Industry",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.industry.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Business Website",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.businessWebsite.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product Description",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.productDescription.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Account Name",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.accountHolderName.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Account Number",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.accountNumber.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Routing Number",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.routingNumber.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportInformationCard() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Official Business Email",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.officialBusinessEmail.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Official Business phone",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.officialBusinessPhone.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Customer Support Email",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.customerSupportEmail.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Customer Support Phone",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                businessProfileController.customerSupportPhone.value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrincipalOwnerDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Plan Name",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.planName.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Plan Description",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.planDescription.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Monthly Fees",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                '\$${businessProfileController.monthlyFees.value}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Per Swipe Fees",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  "\$${businessProfileController.perSwipeFees.value}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Setup Fees",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  "\$${businessProfileController.setupFees.value}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Verification Fees",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.verificationFees.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
          const SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Processing Fees",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          const SizedBox(height: 4.0,),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  businessProfileController.processingFee.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
