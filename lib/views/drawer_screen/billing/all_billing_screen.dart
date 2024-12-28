import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/billing_controller/BillingInformationController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/billing_model/ResfilterData.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

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
                            onPressed: () =>
                                billingController.showSelectDurationBottomSheet(context),
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  // padding: const EdgeInsets.symmetric(
                                  //     vertical: 10),
                                ),
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.appWhiteColor, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01),
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
              if (billingController
                  .allBillingList.isEmpty) {
                return variableController.loading.value
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: Lottie.asset(
                              "assets/lottie/half-circles.json"),
                        ),
                      ),
                    )
                    : NoDataFoundCard(); // Your custom widget
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable scrolling inside ListView
                  itemCount: billingController
                      .allBillingList.length,
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
        contentPadding: const EdgeInsets.all(16),
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
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Status Row
            Row(
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: subscription.credit.toString() == '0'
                        ? AppColors.appRedLightColor
                        : AppColors.appMintGreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FittedBox(
                    child: Text(
                      subscription.credit.toString() == '0' ? 'Debit' : 'Credit',
                      style: TextStyle(
                        color: subscription.credit.toString() == '0'
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
                const SizedBox(width: 8), // Space between the two columns
                Text(
                  subscription.credit.toString() == '0'
                      ? "-\$${subscription.balance}"
                      : "+\$${subscription.balance}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: subscription.credit.toString() == '0'
                        ? AppColors.appRedColor
                        : AppColors.appGreenTextColor,
                    fontSize: 16,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Source Text
            Text(
              "Source: ${subscription.description}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appHeadingText,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
