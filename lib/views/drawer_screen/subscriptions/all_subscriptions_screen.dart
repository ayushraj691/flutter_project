import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/subscriptions_controller/all_subscriptions_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/views/funds/subscription_transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class AllSubscriptionsTab extends StatefulWidget {
  const AllSubscriptionsTab({super.key});

  @override
  State<AllSubscriptionsTab> createState() => _AllSubscriptionsTabState();
}

class _AllSubscriptionsTabState extends State<AllSubscriptionsTab> {

  TextEditingController searchController = TextEditingController();
  var allSubscriptionsTabController = Get.find<AllSubscriptionsController>();
  var variableController = Get.find<VariableController>();
  List<ResTransactionDetail> filteredItems = <ResTransactionDetail>[].obs;
  Map<String, dynamic> sortMap = {
    "": "",
  };

  Map<String, dynamic> argumentMap = {
    "": "",
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0),()async {
      callMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void callMethod() async{
    await allSubscriptionsTabController.getAllSubscriptionsData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      allSubscriptionsTabController.startDate.value,
      allSubscriptionsTabController.endDate.value,
      "$sortMap",
    );

    filteredItems = allSubscriptionsTabController.allSubscriptionsList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allSubscriptionsTabController.allSubscriptionsList
          .where(
              (item) => item.txnNumber.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: _refreshData,
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
                                      30),
                                ),
                                elevation: 0,
                                shadowColor: Colors.black45,
                              ),
                              onPressed: () => allSubscriptionsTabController
                                  .showSelectDurationBottomSheet(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() {
                                    return Text(
                                      allSubscriptionsTabController
                                          .buttonText.value,
                                      style: const TextStyle(
                                        fontSize: 10,
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
                                  width: 0,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
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
                      ],
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by name or email',
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
                            ),
                          ),
                          Obx(() {
                            if (allSubscriptionsTabController
                                .allSubscriptionsList.isEmpty) {
                              return variableController.loading.value
                                  ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 50,
                                  child: Lottie.asset(
                                      "assets/lottie/half-circles.json"),
                                ),
                              )
                                  : NoDataFoundCard(); // Your custom widget
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  return listTransactionCard(filteredItems, index, context);
                                },
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }


  Widget listTransactionCard(List<ResTransactionDetail> allRecentTransaction,
      int index, context) {
    final subscription = allRecentTransaction[index];
    final customer = allRecentTransaction[index];
    final createdDate = subscription.createdOn;
    DateTime dateTime = DateTime.parse(createdDate).toLocal();
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    return InkWell(
      onTap: () {
        Get.to(SubscriptionTransactionsDetails(id:subscription.sId));
      },
      child: Card(
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
                  Expanded(
                    flex: 3,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                        fontSize: 14,
                        fontFamily: 'Sofia Sans',
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.03),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                          subscription.isSchedule==true && subscription.payMode== '0'?AppColors.appOrangeLightColor
                          :(subscription.isDeleted == false &&
                              subscription.isDeletedRequest == true &&
                              ![5, 6, 7].contains(subscription.payStatus)
                              ? AppColors.appTextGreyColor
                              : (subscription.isDeletedRequest == true &&
                              subscription.isDeleted == true
                              ? AppColors.appMistyRoseColor
                              : (subscription.isDeletedRequest == false &&
                              subscription.isDeleted == true
                              ? AppColors.appMistyRoseColor
                              : (subscription.payStatus == '5' &&
                              subscription.isDeletedRequest ==
                                  false &&
                              subscription.isDeleted == false
                              ? AppColors.appRedLightColor
                              : (subscription.payStatus == '6' &&
                              subscription.isDeletedRequest ==
                                  false &&
                              subscription.isDeleted ==
                                  false &&
                              subscription.downloadBymerchant ==
                                  true
                              ? AppColors.appMintGreenColor
                              : (subscription.payStatus == '7' &&
                              subscription.isDeletedRequest == false &&
                              subscription.isDeleted == false &&
                              subscription.downloadBymerchant == true
                              ? AppColors.appRedLightColor
                              : (subscription.isDeleted == false &&
                              subscription.isDeletedRequest ==
                                  false &&
                              subscription.downloadBymerchant ==
                                  true &&
                              ![5, 6, 7].contains(subscription.payStatus)
                              ? AppColors
                              .appLightBlueColor
                              : (subscription.verificationStatus == true &&
                              subscription.isDeleted == false &&
                              subscription.isDeletedRequest == false &&
                              subscription.downloadBymerchant == false &&
                              subscription.payStatus != '5'
                              ? AppColors
                              .appGreenLightColor
                              : (subscription.payStatus == '0' &&
                              subscription.verificationStatus ==
                                  false &&
                              subscription.isDeleted == false &&
                              subscription.isDeletedRequest == false &&
                              subscription.downloadBymerchant == false
                              ? AppColors.appSoftSkyBlueColor
                              : (subscription.payStatus == '4' &&
                              subscription.verificationStatus == false &&
                              subscription.isDeleted == false &&
                              subscription.isDeletedRequest == false &&
                              subscription.downloadBymerchant == false
                              ? AppColors.appLightYellowColor
                              : (subscription.payStatus == '3' &&
                              subscription.verificationStatus == false &&
                              subscription.isDeleted == false &&
                              subscription.isDeletedRequest == false &&
                              subscription.downloadBymerchant == false
                              ? AppColors.appMintGreenColor
                              : AppColors.appLightBlueColor))))))))))),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FittedBox(
                          child: Text(
                              subscription.isSchedule==true && subscription.payMode== '0'?'Scheduler'
                            :(subscription.isDeleted == false &&
                                subscription.isDeletedRequest == true &&
                                ![5, 6, 7].contains(subscription.payStatus)
                                ? 'Delete request'
                                : (subscription.isDeletedRequest == true &&
                                subscription.isDeleted == true
                                ? 'Reimbursement'
                                : (subscription.isDeletedRequest == false &&
                                subscription.isDeleted == true
                                ? 'Reimbursement'
                                : (subscription.payStatus == '5' &&
                                subscription.isDeletedRequest ==
                                    false &&
                                subscription.isDeleted == false
                                ? 'Cancelled'
                                : (subscription.payStatus == '6' &&
                                subscription.isDeletedRequest ==
                                    false &&
                                subscription.isDeleted ==
                                    false &&
                                subscription.downloadBymerchant ==
                                    true
                                ? 'Successful'
                                : (subscription.payStatus == '7' &&
                                subscription.isDeletedRequest == false &&
                                subscription.isDeleted == false &&
                                subscription.downloadBymerchant == true
                                ? 'Unsuccessful'
                                : (subscription.isDeleted == false &&
                                subscription.isDeletedRequest == false &&
                                subscription.downloadBymerchant == true &&
                                ![5, 6, 7].contains(subscription.payStatus)
                                ? 'Downloaded'
                                : (subscription.verificationStatus == true &&
                                subscription.isDeleted == false &&
                                subscription.isDeletedRequest == false &&
                                subscription.downloadBymerchant == false &&
                                subscription.payStatus != '5'
                                ? 'Verified'
                                : (subscription.payStatus == '0' &&
                                subscription.verificationStatus == false &&
                                subscription.isDeleted == false &&
                                subscription.isDeletedRequest == false &&
                                subscription.downloadBymerchant == false ? 'New'
                                : (subscription.payStatus == '4' &&
                                subscription.verificationStatus == false &&
                                subscription.isDeleted == false &&
                                subscription.isDeletedRequest == false &&
                                subscription.downloadBymerchant == false
                                ? 'Incomplete'
                                : (subscription.payStatus == '3' &&
                                subscription.verificationStatus == false &&
                                subscription.isDeleted == false &&
                                subscription.isDeletedRequest == false &&
                                subscription.downloadBymerchant == false
                                ? 'Complete'
                                :'Unknown'))))))))))),
                            style: TextStyle(
                                color:
                                subscription.isSchedule==true && subscription.payMode== '0'?AppColors.appYellowColor
                                    :(
                                subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == true &&
                                    ![5, 6, 7]
                                        .contains(subscription.payStatus)
                                    ? AppColors.appTextColor2
                                    : (subscription.isDeletedRequest == true &&
                                    subscription.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (subscription.isDeletedRequest == false &&
                                    subscription.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (subscription.payStatus == '5' &&
                                    subscription.isDeletedRequest ==
                                        false &&
                                    subscription.isDeleted == false
                                    ? AppColors.appRedColor
                                    : (subscription.payStatus == '6' &&
                                    subscription.isDeletedRequest ==
                                        false &&
                                    subscription.isDeleted ==
                                        false &&
                                    subscription.downloadBymerchant ==
                                        true
                                    ? AppColors.appGreenColor
                                    : (subscription.payStatus == '7' &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.isDeleted == false &&
                                    subscription.downloadBymerchant == true
                                    ? AppColors.appRedColor
                                    : (subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.downloadBymerchant == true &&
                                    ![5, 6, 7].contains(subscription.payStatus)
                                    ? AppColors
                                    .appTextBlueColor
                                    : (subscription.verificationStatus ==
                                    true && subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.downloadBymerchant == false &&
                                    subscription.payStatus != '5'
                                    ? AppColors
                                    .appTextGreenColor
                                    : (subscription.payStatus == '0' &&
                                    subscription.verificationStatus == false &&
                                    subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.downloadBymerchant == false
                                    ? AppColors.appSkyBlueText
                                    : (subscription.payStatus == '4' &&
                                    subscription.verificationStatus == false &&
                                    subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.downloadBymerchant == false
                                    ? AppColors.appOrangeTextColor
                                    : (subscription.payStatus == '3' &&
                                    subscription.verificationStatus == false &&
                                    subscription.isDeleted == false &&
                                    subscription.isDeletedRequest == false &&
                                    subscription.downloadBymerchant == false
                                    ? AppColors.appGreenTextColor
                                    : AppColors.appTextBlueColor))))))))))),
                                fontSize: 12),
                          ),
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
                      "Customer Name: ${customer.custId?.info.custName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.appHeadingText,
                        fontSize: 14,
                        fontFamily: 'Sofia Sans',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$${subscription.payTotal}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.appHeadingText,
                          fontSize: 16,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Transaction ID: ${subscription.txnNumber}",
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
      ),
    );
  }
}