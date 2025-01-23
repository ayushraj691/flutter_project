import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/subscriptions_controller/new_subscriptions_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/funds/subscription_transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class SubscriptionsNewTab extends StatefulWidget {
  const SubscriptionsNewTab({super.key});

  @override
  State<SubscriptionsNewTab> createState() => _SubscriptionsNewTabState();
}

class _SubscriptionsNewTabState extends State<SubscriptionsNewTab> {
  TextEditingController searchController = TextEditingController();
  var newSubscriptionsTabController = Get.find<NewSubscriptionsController>();
  var variableController = Get.find<VariableController>();
  List<ResTransactionDetail> filteredItems = <ResTransactionDetail>[].obs;

  @override
  void dispose() {
    newSubscriptionsTabController.selectedItems.clear();
    newSubscriptionsTabController.selectedIdList.clear();
    newSubscriptionsTabController.isSelectionMode = false;
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
      searchController.addListener(_filterItems);
    });
  }

  Map<String, dynamic> sortMap = {
    "": "",
  };
  Map<String, dynamic> argumentMap = {
    "pay_status": "0",
    "is_deleted_request": false,
    "is_deleted": false,
    "verification_status": false,
    "download_bymerchant": false,
    "\$or": [
      {
        "\$and": [
          {"pay_mode": "0"},
          {"is_schedule": false}
        ]
      },
      {
        "\$and": [
          {"pay_mode": "1"},
          {"is_schedule": true}
        ]
      }
    ]
  };

  void callMethod() async {
    await newSubscriptionsTabController.getAllSubscriptionsData(
      CommonVariable.businessId.value,
      '',
      jsonEncode(argumentMap),
      newSubscriptionsTabController.startDate.value,
      newSubscriptionsTabController.endDate.value,
      "$sortMap",
    );

    filteredItems = newSubscriptionsTabController.newSubscriptionsList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = newSubscriptionsTabController.newSubscriptionsList
          .where((item) => item.txnNumber.toLowerCase().contains(query))
          .toList();
    });
  }

  void toggleSelectionMode(int index, String id) {
    setState(() {
      if (newSubscriptionsTabController.isSelectionMode) {
        if (newSubscriptionsTabController.selectedItems.contains(index)) {
          newSubscriptionsTabController.selectedItems.remove(index);
          newSubscriptionsTabController.selectedIdList.remove(id);
        } else {
          newSubscriptionsTabController.selectedItems.add(index);
          newSubscriptionsTabController.selectedIdList.add(id);
        }
        if (newSubscriptionsTabController.selectedItems.length ==
            filteredItems.length) {
          newSubscriptionsTabController.isAllSelected = true;
        } else {
          newSubscriptionsTabController.isAllSelected = false;
        }
        if (newSubscriptionsTabController.selectedItems.isEmpty) {
          newSubscriptionsTabController.isSelectionMode = false;
        }
      } else {
        newSubscriptionsTabController.isSelectionMode = true;
        newSubscriptionsTabController.selectedItems.add(index);
        newSubscriptionsTabController.selectedIdList.add(id);
        newSubscriptionsTabController.isAllSelected =
            newSubscriptionsTabController.selectedItems.length ==
                filteredItems.length;
      }
    });
  }

  void toggleSelectAll() {
    setState(() {
      if (newSubscriptionsTabController.isAllSelected) {
        newSubscriptionsTabController.selectedItems.clear();
        newSubscriptionsTabController.selectedIdList.clear();
      } else {
        newSubscriptionsTabController.selectedItems =
            List.generate(filteredItems.length, (index) => index);
        newSubscriptionsTabController.selectedIdList =
            List.generate(filteredItems.length, (id) => id.toString());
      }
      newSubscriptionsTabController.isAllSelected =
      !newSubscriptionsTabController.isAllSelected;
    });
  }

  void deleteSelectedItems() {
    setState(() {
      newSubscriptionsTabController.deleteData(
          newSubscriptionsTabController.selectedIdList);
      callMethod();
      newSubscriptionsTabController.selectedItems.clear();
      newSubscriptionsTabController.selectedIdList.clear();
      newSubscriptionsTabController.isSelectionMode = false;
      newSubscriptionsTabController.isAllSelected = false;
    });
  }

  void downloadSelectedItems() {
    setState(() {
      newSubscriptionsTabController.downloadData(
          newSubscriptionsTabController.selectedIdList);
      callMethod();
      newSubscriptionsTabController.selectedItems.clear();
      newSubscriptionsTabController.selectedIdList.clear();
      newSubscriptionsTabController.isSelectionMode = false;
      newSubscriptionsTabController.isAllSelected = false;
    });
  }

  void verifySelectedItems() {
    setState(() {
      newSubscriptionsTabController.verifyData(
          newSubscriptionsTabController.selectedIdList);
      callMethod();
      newSubscriptionsTabController.selectedItems.clear();
      newSubscriptionsTabController.selectedIdList.clear();
      newSubscriptionsTabController.isSelectionMode = false;
      newSubscriptionsTabController.isAllSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors
                                    .appBackgroundGreyColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                                shadowColor: Colors.black45,
                              ),
                              onPressed: () =>
                                  newSubscriptionsTabController
                                      .showSelectDurationBottomSheet(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() {
                                    return Text(
                                      newSubscriptionsTabController
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
                                  newSubscriptionsTabController.downloadCSV();
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
                                    color: AppColors.appWhiteColor,
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
                            padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
                            child: TextField(
                              controller: searchController,
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
                            ),
                          ),
                          if (newSubscriptionsTabController.isSelectionMode)
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              color: AppColors.appWhiteColor,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              setState(() {
                                                newSubscriptionsTabController
                                                    .selectedItems.clear();
                                                newSubscriptionsTabController
                                                    .selectedIdList.clear();
                                                newSubscriptionsTabController
                                                    .isSelectionMode = false;
                                              });
                                            },
                                          ),
                                          Text("${newSubscriptionsTabController
                                              .selectedItems
                                              .length} items selected"),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12.0),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              value: newSubscriptionsTabController
                                                  .isAllSelected,
                                              activeColor: AppColors
                                                  .appBlueColor,
                                              onChanged: (value) {
                                                toggleSelectAll();
                                              },
                                            ),
                                            const Text("Select all",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Sofia Sans',
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.appTextColor,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Divider(
                                      thickness: 1,
                                      color: AppColors.appGreyColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () =>
                                          {
                                            GeneralMethods.showPopup(
                                                context,
                                                "verify ${newSubscriptionsTabController
                                                    .selectedItems.length}",
                                                "This will verify your item from transactions. Are you sure?",
                                                    () {
                                                  verifySelectedItems();
                                                  Navigator.of(context).pop();
                                                }, AppColors.appGreenDarkColor,
                                                "verify")
                                          },
                                          icon: const Icon(
                                            Icons.verified, size: 14,),
                                          label: const Text(
                                            'Verify',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Sofia Sans',
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: AppColors
                                                .appNeutralColor5,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () =>
                                          {
                                            GeneralMethods.showPopup(
                                                context,
                                                "delete ${newSubscriptionsTabController
                                                    .selectedItems.length}",
                                                "This will delete your item from transactions. Are you sure?",
                                                    () {
                                                  deleteSelectedItems();
                                                  Navigator.of(context).pop();
                                                }, AppColors.appRedColor,
                                                "delete")
                                          },
                                          icon: const Icon(
                                            Icons.delete, size: 14,),
                                          label: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Sofia Sans',
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: AppColors
                                                .appNeutralColor5,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () =>
                                          {
                                            downloadSelectedItems()
                                          },
                                          icon: const Icon(
                                            Icons.download, size: 14,),
                                          label: const Text(
                                            'Download',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Sofia Sans',
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: AppColors
                                                .appNeutralColor5,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Obx(() {
                            if (newSubscriptionsTabController
                                .newSubscriptionsList.isEmpty) {
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
                ),
              ),
            ],
          ),
        ),
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
    String formattedDate = DateFormat('dd MMM, yy').format(dateTime);

    final isSelected = newSubscriptionsTabController.selectedItems.contains(
        index);

    return InkWell(
      onLongPress: () {
        toggleSelectionMode(index, subscription.sId);
      },
      onTap: () {
        if (newSubscriptionsTabController.isSelectionMode) {
          toggleSelectionMode(index, subscription.sId);
        } else {
          Get.to(SubscriptionTransactionsDetails(id: subscription.sId));
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
        color: isSelected ? AppColors.appBlueLightColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 8.0,bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

                  // This will comment as per the suggestion request on 20/01/25

                  // SizedBox(width: MediaQuery
                  //     .of(context)
                  //     .size
                  //     .width * 0.03),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 12, vertical: 4),
                  //     decoration: BoxDecoration(
                  //       color:
                  //       subscription.isSchedule == true && subscription
                  //           .payMode == '0' ? AppColors.appOrangeLightColor
                  //           : (subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest == true &&
                  //           ![5, 6, 7].contains(subscription.payStatus)
                  //           ? AppColors.appTextGreyColor
                  //           : (subscription.isDeletedRequest == true &&
                  //           subscription.isDeleted == true
                  //           ? AppColors.appMistyRoseColor
                  //           : (subscription.isDeletedRequest == false &&
                  //           subscription.isDeleted == true
                  //           ? AppColors.appMistyRoseColor
                  //           : (subscription.payStatus == '5' &&
                  //           subscription.isDeletedRequest ==
                  //               false &&
                  //           subscription.isDeleted == false
                  //           ? AppColors.appRedLightColor
                  //           : (subscription.payStatus == '6' &&
                  //           subscription.isDeletedRequest ==
                  //               false &&
                  //           subscription.isDeleted ==
                  //               false &&
                  //           subscription.downloadBymerchant ==
                  //               true
                  //           ? AppColors.appMintGreenColor
                  //           : (subscription.payStatus == '7' &&
                  //           subscription.isDeletedRequest == false &&
                  //           subscription.isDeleted == false &&
                  //           subscription.downloadBymerchant == true
                  //           ? AppColors.appRedLightColor
                  //           : (subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest ==
                  //               false &&
                  //           subscription.downloadBymerchant ==
                  //               true &&
                  //           ![5, 6, 7].contains(subscription.payStatus)
                  //           ? AppColors
                  //           .appLightBlueColor
                  //           : (subscription.verificationStatus == true &&
                  //           subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest == false &&
                  //           subscription.downloadBymerchant == false &&
                  //           subscription.payStatus != '5'
                  //           ? AppColors
                  //           .appGreenLightColor
                  //           : (subscription.payStatus == '0' &&
                  //           subscription.verificationStatus ==
                  //               false &&
                  //           subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest == false &&
                  //           subscription.downloadBymerchant == false
                  //           ? AppColors.appSoftSkyBlueColor
                  //           : (subscription.payStatus == '4' &&
                  //           subscription.verificationStatus == false &&
                  //           subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest == false &&
                  //           subscription.downloadBymerchant == false
                  //           ? AppColors.appLightYellowColor
                  //           : (subscription.payStatus == '3' &&
                  //           subscription.verificationStatus == false &&
                  //           subscription.isDeleted == false &&
                  //           subscription.isDeletedRequest == false &&
                  //           subscription.downloadBymerchant == false
                  //           ? AppColors.appMintGreenColor
                  //           : AppColors.appLightBlueColor))))))))))),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: FittedBox(
                  //       child: Text(
                  //         subscription.isSchedule == true &&
                  //             subscription.payMode == '0' ? 'Scheduler'
                  //             : (subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == true &&
                  //             ![5, 6, 7].contains(subscription.payStatus)
                  //             ? 'Delete request'
                  //             : (subscription.isDeletedRequest == true &&
                  //             subscription.isDeleted == true
                  //             ? 'Reimbursement'
                  //             : (subscription.isDeletedRequest == false &&
                  //             subscription.isDeleted == true
                  //             ? 'Reimbursement'
                  //             : (subscription.payStatus == '5' &&
                  //             subscription.isDeletedRequest ==
                  //                 false &&
                  //             subscription.isDeleted == false
                  //             ? 'Cancelled'
                  //             : (subscription.payStatus == '6' &&
                  //             subscription.isDeletedRequest ==
                  //                 false &&
                  //             subscription.isDeleted ==
                  //                 false &&
                  //             subscription.downloadBymerchant ==
                  //                 true
                  //             ? 'Successful'
                  //             : (subscription.payStatus == '7' &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.isDeleted == false &&
                  //             subscription.downloadBymerchant == true
                  //             ? 'Unsuccessful'
                  //             : (subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.downloadBymerchant == true &&
                  //             ![5, 6, 7].contains(subscription.payStatus)
                  //             ? 'Downloaded'
                  //             : (subscription.verificationStatus == true &&
                  //             subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.downloadBymerchant == false &&
                  //             subscription.payStatus != '5'
                  //             ? 'Verified'
                  //             : (subscription.payStatus == '0' &&
                  //             subscription.verificationStatus == false &&
                  //             subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.downloadBymerchant == false ? 'New'
                  //             : (subscription.payStatus == '4' &&
                  //             subscription.verificationStatus == false &&
                  //             subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.downloadBymerchant == false
                  //             ? 'Incomplete'
                  //             : (subscription.payStatus == '3' &&
                  //             subscription.verificationStatus == false &&
                  //             subscription.isDeleted == false &&
                  //             subscription.isDeletedRequest == false &&
                  //             subscription.downloadBymerchant == false
                  //             ? 'Complete'
                  //             : 'Unknown'))))))))))),
                  //         style: TextStyle(
                  //             color:
                  //             subscription.isSchedule == true &&
                  //                 subscription.payMode == '0' ? AppColors
                  //                 .appYellowColor
                  //                 : (
                  //                 subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest == true &&
                  //                     ![5, 6, 7]
                  //                         .contains(subscription.payStatus)
                  //                     ? AppColors.appTextColor2
                  //                     : (subscription.isDeletedRequest ==
                  //                     true &&
                  //                     subscription.isDeleted == true
                  //                     ? AppColors.appPurpleColor
                  //                     : (subscription.isDeletedRequest ==
                  //                     false &&
                  //                     subscription.isDeleted == true
                  //                     ? AppColors.appPurpleColor
                  //                     : (subscription.payStatus == '5' &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.isDeleted == false
                  //                     ? AppColors.appRedColor
                  //                     : (subscription.payStatus == '6' &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.isDeleted ==
                  //                         false &&
                  //                     subscription.downloadBymerchant ==
                  //                         true
                  //                     ? AppColors.appGreenColor
                  //                     : (subscription.payStatus == '7' &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.isDeleted == false &&
                  //                     subscription.downloadBymerchant == true
                  //                     ? AppColors.appRedColor
                  //                     : (subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.downloadBymerchant ==
                  //                         true &&
                  //                     ![5, 6, 7].contains(
                  //                         subscription.payStatus)
                  //                     ? AppColors
                  //                     .appTextBlueColor
                  //                     : (subscription.verificationStatus ==
                  //                     true &&
                  //                     subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.downloadBymerchant ==
                  //                         false &&
                  //                     subscription.payStatus != '5'
                  //                     ? AppColors
                  //                     .appTextGreenColor
                  //                     : (subscription.payStatus == '0' &&
                  //                     subscription.verificationStatus ==
                  //                         false &&
                  //                     subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.downloadBymerchant == false
                  //                     ? AppColors.appSkyBlueText
                  //                     : (subscription.payStatus == '4' &&
                  //                     subscription.verificationStatus ==
                  //                         false &&
                  //                     subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.downloadBymerchant == false
                  //                     ? AppColors.appOrangeTextColor
                  //                     : (subscription.payStatus == '3' &&
                  //                     subscription.verificationStatus ==
                  //                         false &&
                  //                     subscription.isDeleted == false &&
                  //                     subscription.isDeletedRequest ==
                  //                         false &&
                  //                     subscription.downloadBymerchant == false
                  //                     ? AppColors.appGreenTextColor
                  //                     : AppColors.appTextBlueColor))))))))))),
                  //             fontSize: 12),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
