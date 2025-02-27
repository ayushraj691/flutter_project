import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/fund_controller/all_fund_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/funds_model/ResFundsDetails.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/widgets/FileViewerpage.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class AllFundsScreen extends StatefulWidget {
  const AllFundsScreen({super.key});

  @override
  State<AllFundsScreen> createState() => _AllFundsScreenState();
}

class _AllFundsScreenState extends State<AllFundsScreen> {
  TextEditingController searchController = TextEditingController();
  var allFundsTabController = Get.find<AllFundsController>();
  var variableController = Get.find<VariableController>();
  List<ResFundsDetails> filteredItems = <ResFundsDetails>[].obs;
  Map<String, dynamic> sortMap = {
    "is_created": -1,
  };
  Map<String, dynamic> argumentMap = {
    "\$or": [
      {"is_approved": "3"},
      {"is_approved": "4"},
      {"is_approved": "0"}
    ],
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void callMethod() async {
    await allFundsTabController.getAllFundsData(
      CommonVariable.businessId.value,
      '',
      jsonEncode(argumentMap),
      allFundsTabController.startDate.value,
      allFundsTabController.endDate.value,
      jsonEncode(sortMap),
    );
    filteredItems = allFundsTabController.allFundsList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allFundsTabController.allFundsList
          .where(
              (item) => item.allfunds!.txnNumber.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.appBackgroundGreyColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.black45,
                                ),
                                onPressed: () => allFundsTabController
                                    .showSelectDurationBottomSheet(context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() {
                                      return Text(
                                        allFundsTabController.buttonText.value,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Constants.Sofiafontfamily,
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
                                    allFundsTabController.downloadCSV();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                  child: Text(
                                    'Download',
                                    style: TextStyle(
                                      fontFamily: Constants.Sofiafontfamily,
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
                        ],
                      ),
                      Card(
                        elevation: 0.0,
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
                              if (allFundsTabController.allFundsList.isEmpty) {
                                return variableController.loading.value
                                    ? Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 50,
                                            child: Lottie.asset(
                                                "assets/lottie/half-circles.json"),
                                          ),
                                        ),
                                      )
                                    : NoDataFoundCard();
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredItems.length,
                                  itemBuilder: (context, index) {
                                    return listTransactionCard(
                                        filteredItems, index, context);
                                  },
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }

  Widget listTransactionCard(
      List<ResFundsDetails> allFundsTransaction, int index, context) {
    final subscription = allFundsTransaction[index].allfunds;
    final customer = allFundsTransaction[index];
    final createdDate = subscription?.isCreated;
    DateTime dateTime = DateTime.parse(createdDate!).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yy').format(dateTime);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Status Row
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "$formattedDate   $formattedTime",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                      fontSize: 14,
                      fontFamily: Constants.Sofiafontfamily,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: subscription?.isApproved == "0"
                            ? AppColors.appLightYellowColor
                            : (subscription?.isApproved == "3"
                                ? AppColors.appMintGreenColor
                                : AppColors.appRedLightColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FittedBox(
                        child: Text(
                          subscription?.isApproved == "0"
                              ? "Pending"
                              : (subscription?.isApproved == "3"
                                  ? "Successful"
                                  : "Unsuccessful"),
                          style: TextStyle(
                              color: subscription?.isApproved == "0"
                                  ? AppColors.appYellowColor
                                  : (subscription?.isApproved == "3"
                                      ? AppColors.appGreenTextColor
                                      : AppColors.appRedColor),
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
                Flexible(
                  flex: 3,
                  child: Text(
                    "${customer.fundSourcedetail?.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.appHeadingText,
                      fontSize: 14,
                      fontFamily: Constants.Sofiafontfamily,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "\$${subscription!.addedAmount}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appHeadingText,
                        fontSize: 16,
                        fontFamily: Constants.Sofiafontfamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                const SizedBox(width: 40.0),
                Flexible(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => FileViewerPage(
                          fileUrl:
                              'https://paycron.amazing7studios.com/merchant/api/static/${customer.allfunds?.proofPay}'));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "View Proof of payment",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.appBlueColor,
                          fontSize: 12,
                          fontFamily: Constants.Sofiafontfamily,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
