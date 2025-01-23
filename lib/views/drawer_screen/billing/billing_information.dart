import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/billing_controller/BillingInformationController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/billing_model/ResfilterData.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/billing/all_billing_screen.dart';
import 'package:paycron/views/drawer_screen/billing/upgrade_plan_screen.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

import '../../../utils/general_methods.dart';

class BillingInformation extends StatefulWidget {
  const BillingInformation({super.key});

  @override
  State<BillingInformation> createState() => _BillingInformationState();
}

class _BillingInformationState extends State<BillingInformation> {
  var billingController = Get.find<BillingInformationController>();
  final variableController = Get.find<VariableController>();
  List<ResfilterData> filteredItems = <ResfilterData>[].obs;

  Map<String, dynamic> sortMap = {
    "is_created": "-1",
  };
  Map<String, dynamic> argumentMap = {
    "\$or": [
      {
        "\$and": [
          {"is_approved": 3},
          {
            "fund_type": {
              "\$in": [0, 1, 2, 3, 4],
            },
          },
        ],
      },
      {
        "\$and": [
          {"is_approved": 4},
          {
            "fund_type": {
              "\$in": [1, 2, 3, 4],
            },
          },
        ],
      },
    ],
  };

  @override
  void dispose() {
    billingController.clearData();
    super.dispose();
  }


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
    });
    super.initState();
  }

  void callMethod() async {
    await billingController.getSinglePlan();
    await billingController.getBillingTransactionData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      billingController.startDate.value,
      billingController.endDate.value,
      "$sortMap",
    );
    filteredItems = billingController.allBillingList;
    billingController.searchController.addListener(_filterItems);
  }

  void _filterItems() {
    String query = billingController.searchController.text.toLowerCase();
    setState(() {
      filteredItems = billingController.allBillingList
          .where((item) => item.txnNumber.toLowerCase().contains(query))
          .toList();
    });
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
        title: Obx(
          () => Text(
            CommonVariable.businessName.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Get.to(const BusinessProfileScreen()),
              child: CircleAvatar(
                radius: screenHeight / 45,
                backgroundImage: AssetImage(ImageAssets.profile),
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Image.asset(ImageAssets.closeDrawer),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, top: 20, bottom: 10),
                    child: Text(
                      "Billing Information",
                      style: TextStyle(
                        fontFamily: Constants.Sofiafontfamily,
                        color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appLightBlueColor,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppColors.appBlackColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Next Payment on   ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: Constants.Sofiafontfamily,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlackColor,
                        ),
                      ),
                      Obx(() => Text(
                            ':   ${billingController.dueDate.value}',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Constants.Sofiafontfamily,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appBlackColor,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  itemCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    String displayText;
                    String textIcons = "";
                    switch (index) {
                      case 0:
                        displayText = "Approval Pending";
                        textIcons = ImageAssets.approvedFund;
                        break;
                      case 1:
                        displayText = "Prepaid Balance";
                        textIcons = ImageAssets.pendingFund;
                        break;
                      default:
                        displayText = ""; // Default text
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: AppColors.appBlueColor,
                          style: BorderStyle.none,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(0, 0),
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height *
                              0.01, // Responsive vertical padding
                          horizontal: MediaQuery.of(context).size.width *
                              0.02, // Responsive horizontal padding
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              textIcons,
                              height: MediaQuery.of(context).size.height *
                                  0.05, // Responsive image height
                              width: MediaQuery.of(context).size.width *
                                  0.1, // Responsive image width
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.01), // Responsive space
                            Text(
                              displayText,
                              style: TextStyle(
                                color: AppColors.appTextLightColor,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04, // Responsive font size
                                fontFamily: Constants.Sofiafontfamily,
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.01),
                            Obx(() => Text(
                                  index == 1
                                      ? GeneralMethods.formatAmount(CommonVariable.approvedBalance.value)
                                      : "\$${CommonVariable.pendingBalance.value}",
                                  style: TextStyle(
                                    color: AppColors.appBlackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.width *
                                        0.06,
                                    fontFamily: Constants.Sofiafontfamily,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  billingController.name.value,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    fontFamily: Constants.Stolzlfontfamily,
                                  ),
                                )),
                            const SizedBox(height: 10.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10.0),
                                const Text(
                                  "\u2022",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: AppColors.appHeadingText,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Obx(() => Text(
                                        billingController.details.value,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          fontFamily: Constants.Sofiafontfamily,
                                          color: AppColors.appHeadingText,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      CommonVariable.temporaryPlanId.value =
                                          CommonVariable.planId.value;
                                      Get.to(const UpgradePlanScreen());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        backgroundColor: AppColors.appBlueColor),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Upgrade Plan",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Constants.Sofiafontfamily,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Transform.rotate(
                                          angle: 45 * (3.14159265359 / 180),
                                          child: const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showPlanBenefitPopup(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: const BorderSide(
                                            color: AppColors.appBlueColor),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      "Check Plan Benefits",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.appBlueColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildRecentTransactionsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }

  Widget listTransactionCard(
      List<ResfilterData> allBillingTransaction, int index, context) {
    final subscription = allBillingTransaction[index];
    final createdDate = subscription.isCreated;
    DateTime dateTime = DateTime.parse(createdDate).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yy').format(dateTime);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Status Row
            Row(
              children: [
                Text(
                  "$formattedDate   $formattedTime",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.03),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: subscription.fundType.toString() == '0' && subscription.isApproved.toString() == '3'
                        ? AppColors.appMintGreenColor
                        : subscription.fundType.toString() == '1' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedLightColor
                        : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '3'
                        ? AppColors.appMintGreenColor
                        : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedLightColor
                        : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '3'
                        ? AppColors.appMintGreenColor
                        : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedLightColor
                        : subscription.fundType.toString() == '4' && subscription.isApproved.toString() == '3'
                        ? AppColors.appRedLightColor
                        : AppColors.appMintGreenColor,

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FittedBox(
                    child: Text(
                      subscription.fundType.toString() == '0' && subscription.isApproved.toString() == '3'
                          ? 'Credit'
                          : subscription.fundType.toString() == '1' && subscription.isApproved.toString() == '4'
                          ? 'Debit'
                          : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '3'
                          ? 'Credit'
                          : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '4'
                          ? 'Debit'
                          : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '3'
                          ? 'Credit'
                          : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '4'
                          ? 'Debit'
                          : subscription.fundType.toString() == '4' && subscription.isApproved.toString() == '3'
                          ? 'Debit'
                          : "",
                      style: TextStyle(
                        color:
                        subscription.fundType.toString() == '0' && subscription.isApproved.toString() == '3'
                            ? AppColors.appGreenTextColor
                            : subscription.fundType.toString() == '1' && subscription.isApproved.toString() == '4'
                            ? AppColors.appRedColor
                            : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '3'
                            ? AppColors.appGreenTextColor
                            : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '4'
                            ? AppColors.appRedColor
                            : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '3'
                            ? AppColors.appGreenTextColor
                            : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '4'
                            ? AppColors.appRedColor
                            : subscription.fundType.toString() == '4' && subscription.isApproved.toString() == '3'
                            ? AppColors.appRedColor
                            : AppColors.appGreenTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Transaction ID: ${subscription.txnNumber}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.appHeadingText,
                      fontSize: 14,
                      fontFamily: 'Sofia Sans',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  subscription.fundType.toString() == '0' && subscription.isApproved.toString() == '3'
                      ? "+\$${double.parse(subscription.addedAmount.toString()).toStringAsFixed(2)}"
                      : subscription.debit.toString() == "0"
                      ? "+\$${double.parse(subscription.credit.toString()).toStringAsFixed(2)}"
                      : "-\$${double.parse(subscription.debit.toString()).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: subscription.fundType.toString() == '0' && subscription.isApproved.toString() == '3'
                        ? AppColors.appGreenTextColor
                        : subscription.fundType.toString() == '1' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedColor
                        : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '3'
                        ? AppColors.appGreenTextColor
                        : subscription.fundType.toString() == '2' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedColor
                        : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '3'
                        ? AppColors.appGreenTextColor
                        : subscription.fundType.toString() == '3' && subscription.isApproved.toString() == '4'
                        ? AppColors.appRedColor
                        : subscription.fundType.toString() == '4' && subscription.isApproved.toString() == '3'
                        ? AppColors.appRedColor
                        : AppColors.appGreenTextColor,
                    fontSize: 16,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Source: ${subscription.description}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.appHeadingText,
                      fontSize: 14,
                      fontFamily: Constants.Sofiafontfamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Prepaid Balance: ${subscription.balance}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appHeadingText,
                    fontSize: 10,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactionsSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Transactions History",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                      fontSize: 16,
                      fontFamily: Constants.Sofiafontfamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const AllBillingScreen());
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlueColor,
                      fontSize: 12,
                      fontFamily: Constants.Sofiafontfamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildSearchBar(),
            Obx(() {
              if (billingController.allBillingList.isEmpty) {
                return variableController.loading.value
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : NoDataFoundCard(); // Your custom widget
              } else {
                final itemsToShow = billingController.itemsToShow.value;

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemsToShow > billingController.allBillingList.length
                          ? billingController.allBillingList.length
                          : itemsToShow,
                      itemBuilder: (context, index) {
                        return listTransactionCard(
                          billingController.allBillingList,
                          index,
                          context,
                        );
                      },
                    ),
                    if (billingController.allBillingList.length > 10) // Show buttons only if list is larger than 10
                      TextButton(
                        onPressed: () {
                          if (itemsToShow >= billingController.allBillingList.length) {
                            billingController.itemsToShow.value = 10;
                          } else {
                            billingController.itemsToShow.value += 10;
                          }
                        },
                        child: Text(
                          itemsToShow >= billingController.allBillingList.length
                              ? "View Less"
                              : "View More",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: billingController.searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.appNeutralColor5,
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search by Id',
        hintStyle: const TextStyle(fontSize: 14.0,color: AppColors.appGreyColor
            ,fontWeight: FontWeight.w400
        ),
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.appNeutralColor5,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.appNeutralColor5,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void showPlanBenefitPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          billingController.name.value,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                            "\$${billingController.monthlyFee.value} USD/month",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(height: 20),
                      Obx(() => Text(
                            billingController.details.value,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: Constants.Sofiafontfamily,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appNeutralColor2,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(height: 20),
                      Card(
                        color: AppColors.appBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Plan Price",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: Constants.Sofiafontfamily,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appNeutralColor2,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const Divider(color: AppColors.appGreyColor),
                              // _buildPlanDetail("SetUp Fee", "${billingController.setupFee.value}"),
                              _buildPlanDetail("Monthly Fee",
                                  "${billingController.monthlyFee.value}"),
                              _buildPlanDetail("Processing Fee",
                                  billingController.processingFee.value),
                              _buildPlanDetail("Per Swipe Fee",
                                  "${billingController.perSwipeFee.value}%"),
                              _buildPlanDetail("Verification Fee",
                                  "${billingController.verificationFee.value}%"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.close,
                          color: Colors.black, size: 18),
                    ),
                  ),
                ),
                Positioned(
                  top: -35,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: AppColors.appLightBlueColor,
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(ImageAssets.planDialogImage),
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlanDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(':',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
          Expanded(
            flex: 2,
            child: Text(value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
        ],
      ),
    );
  }
}
