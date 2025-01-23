import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/virtual_terminal_comtroller/delete_virtual_terminal_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/views/funds/transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class VirtualTerminalDeletedTab extends StatefulWidget {
  const VirtualTerminalDeletedTab({super.key});

  @override
  State<VirtualTerminalDeletedTab> createState() =>
      _VirtualTerminalDeletedTabState();
}

class _VirtualTerminalDeletedTabState extends State<VirtualTerminalDeletedTab> {
  TextEditingController searchController = TextEditingController();
  var deleteVirtualTerminalTabController = Get.find<
      DeleteVirtualTerminalController>();
  var variableController = Get.find<VariableController>();
  List<ResTransactionDetail> filteredItems = <ResTransactionDetail>[].obs;

  List<int> selectedItems = [];
  bool isSelectionMode = false;
  bool isAllSelected = false;

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
    "is_deleted_request": true,
    "is_deleted": false,
    "pay_status": {
      "\$nin": [5, 6, 7],
    },
  };

  void callMethod() async {
    await deleteVirtualTerminalTabController.getAlldeleteVirtualTerminalData(
      CommonVariable.businessId.value,
      '',
      jsonEncode(argumentMap),
      deleteVirtualTerminalTabController.startDate.value,
      deleteVirtualTerminalTabController.endDate.value,
      "$sortMap",
    );
    filteredItems =
        deleteVirtualTerminalTabController.deleteVirtualTerminalList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          deleteVirtualTerminalTabController.deleteVirtualTerminalList
              .where((item) => item.txnNumber.toLowerCase().contains(query))
              .toList();
    });
  }

  void toggleSelectionMode(int index) {
    setState(() {
      if (isSelectionMode) {
        if (selectedItems.contains(index)) {
          selectedItems.remove(index);
        } else {
          selectedItems.add(index);
        }
        if (selectedItems.length == filteredItems.length) {
          isAllSelected = true;
        } else {
          isAllSelected = false;
        }
        if (selectedItems.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        isSelectionMode = true;
        selectedItems.add(index);
        isAllSelected = selectedItems.length == filteredItems.length;
      }
    });
  }

  void toggleSelectAll() {
    setState(() {
      if (isAllSelected) {
        selectedItems.clear();
      } else {
        selectedItems = List.generate(filteredItems.length, (index) => index);
      }
      isAllSelected = !isAllSelected;
    });
  }

  void deleteSelectedItems() {
    setState(() {
      deleteVirtualTerminalTabController.deleteVirtualTerminalList.removeWhere(
              (transaction) =>
              selectedItems.contains(deleteVirtualTerminalTabController
                  .deleteVirtualTerminalList
                  .indexOf(transaction)));
      selectedItems.clear();
      isSelectionMode = false;
      isAllSelected = false;
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
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackgroundGreyColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                              shadowColor: Colors.black45,
                            ),
                            onPressed: () =>
                                deleteVirtualTerminalTabController
                                    .showSelectDurationBottomSheet(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() {
                                  return Text(
                                    deleteVirtualTerminalTabController
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
                              onPressed: () async {
                                await deleteVirtualTerminalTabController
                                    .downloadCSV();
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
                          padding: const EdgeInsets.all(16.0),
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
                        Obx(() {
                          if (deleteVirtualTerminalTabController
                              .deleteVirtualTerminalList.isEmpty) {
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

    final isSelected = selectedItems.contains(index);

    return InkWell(
      onTap: () {
        if (isSelectionMode) {
          toggleSelectionMode(index);
        } else {
          Get.to(TransactionsDetails(id: subscription.sId));
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
                  //       color: subscription.isDeleted == false &&
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
                  //           : AppColors.appLightBlueColor)))))))))),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: FittedBox(
                  //       child: Text(
                  //         subscription.isDeleted == false &&
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
                  //             : 'Unknown')))))))))),
                  //         style: TextStyle(
                  //             color: subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == true &&
                  //                 ![5, 6, 7]
                  //                     .contains(subscription.payStatus)
                  //                 ? AppColors.appTextColor2
                  //                 : (subscription.isDeletedRequest == true &&
                  //                 subscription.isDeleted == true
                  //                 ? AppColors.appPurpleColor
                  //                 : (subscription.isDeletedRequest == false &&
                  //                 subscription.isDeleted == true
                  //                 ? AppColors.appPurpleColor
                  //                 : (subscription.payStatus == '5' &&
                  //                 subscription.isDeletedRequest ==
                  //                     false &&
                  //                 subscription.isDeleted == false
                  //                 ? AppColors.appRedColor
                  //                 : (subscription.payStatus == '6' &&
                  //                 subscription.isDeletedRequest ==
                  //                     false &&
                  //                 subscription.isDeleted ==
                  //                     false &&
                  //                 subscription.downloadBymerchant ==
                  //                     true
                  //                 ? AppColors.appGreenColor
                  //                 : (subscription.payStatus == '7' &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.isDeleted == false &&
                  //                 subscription.downloadBymerchant == true
                  //                 ? AppColors.appRedColor
                  //                 : (subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.downloadBymerchant == true &&
                  //                 ![5, 6, 7].contains(subscription.payStatus)
                  //                 ? AppColors
                  //                 .appTextBlueColor
                  //                 : (subscription.verificationStatus ==
                  //                 true && subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.downloadBymerchant == false &&
                  //                 subscription.payStatus != '5'
                  //                 ? AppColors
                  //                 .appTextGreenColor
                  //                 : (subscription.payStatus == '0' &&
                  //                 subscription.verificationStatus == false &&
                  //                 subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.downloadBymerchant == false
                  //                 ? AppColors.appSkyBlueText
                  //                 : (subscription.payStatus == '4' &&
                  //                 subscription.verificationStatus == false &&
                  //                 subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.downloadBymerchant == false
                  //                 ? AppColors.appOrangeTextColor
                  //                 : (subscription.payStatus == '3' &&
                  //                 subscription.verificationStatus == false &&
                  //                 subscription.isDeleted == false &&
                  //                 subscription.isDeletedRequest == false &&
                  //                 subscription.downloadBymerchant == false
                  //                 ? AppColors.appGreenTextColor
                  //                 : AppColors.appTextBlueColor)))))))))),
                  //             fontSize: 12),
                  //       ),),
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
                          color: AppColors.appBlackColor,
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
