import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/billing_controller/BillingInformationController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/billing_model/ResfilterData.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

import '../../../utils/string_constants.dart';

class AllBillingScreen extends StatefulWidget {
  const AllBillingScreen({super.key});

  @override
  State<AllBillingScreen> createState() => _AllBillingScreenState();
}

class _AllBillingScreenState extends State<AllBillingScreen> {
  var billingController = Get.find<BillingInformationController>();
  final variableController = Get.find<VariableController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "All Billing",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackgroundGreyColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              elevation: 0,
                              shadowColor: Colors.black45,
                            ),
                            onPressed: () => billingController
                                .showSelectDurationBottomSheet(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() {
                                  return Text(
                                    billingController.buttonText.value,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Sofia Sans',
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: screenWidth / 4,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.appBlackColor,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: AppColors.appBlackColor,
                                  width: 0, // Border thickness
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  billingController.downloadCSV();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                ),
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color:
                                        AppColors.appWhiteColor, // Text color
                                  ),
                                ),
                              ),
                            ),
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
        ],
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Transactions History",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                      fontSize: 16,
                      fontFamily: 'Sofia Sans',
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
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child:
                                Lottie.asset("assets/lottie/half-circles.json"),
                          ),
                        ),
                      )
                    : NoDataFoundCard(); // Your custom widget
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable scrolling inside ListView
                  itemCount: billingController.allBillingList.length,
                  itemBuilder: (context, index) {
                    return listTransactionCard(
                      billingController.allBillingList,
                      index,
                      context,
                    );
                  },
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
        hintText: 'Search by ID or Customer',
        filled: true,
        fillColor: AppColors.appNeutralColor5,
        prefixIcon: const Icon(Icons.search),
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
                    // subscription.credit.toString() == '0'
                    //     ? AppColors.appRedLightColor
                    //     : AppColors.appMintGreenColor,
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
}
