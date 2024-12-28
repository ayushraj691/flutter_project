import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/itemTransactionDetailController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResSinglePayment.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class InvoiceTransactionsDetails extends StatefulWidget {
  final String id;

  const InvoiceTransactionsDetails({super.key,required this.id});

  @override
  State<InvoiceTransactionsDetails> createState() => _InvoiceTransactionsDetailsState();
}

class _InvoiceTransactionsDetailsState extends State<InvoiceTransactionsDetails> {
  bool isCustomerDetailsExpanded = true;
  bool isBusinessDetailsExpanded = true;
  bool isAccountDetailsExpanded = true;
  bool isPurchaseDetailsExpanded = true;
  var itemTransactionController = Get.find<ItemTransactionDetailsController>();
  var variableController = Get.find<VariableController>();
  int selectedIndex = 0;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
    });
    super.initState();
  }
  void callMethod() async {
    await itemTransactionController.getSingleData(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
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
          title: const Text(
            "Transaction Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    if (itemTransactionController.allSinglePaymentDataList.isEmpty &&
                        !variableController.loading.value)
                      NoDataFoundCard()
                    else ...[
                      transactionCard(),
                      const SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03,
                          horizontal: screenWidth * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appTabBackgroundColor,
                          borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.02),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Date:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appNeutralColor2,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Obx(() => Text(
                                            itemTransactionController.date.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appNeutralColor2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                  color: AppColors.appBackgroundGreyColor,
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.02),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Transaction ID',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appNeutralColor2,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Obx(() => Text(
                                            itemTransactionController.transactionId.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.appNeutralColor2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                  color: AppColors.appBackgroundGreyColor,
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Amount',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Sofia Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appNeutralColor2,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Obx(() => Text(
                                        itemTransactionController.amount.value.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Sofia Sans',
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appBlackColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.05),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Due on:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Obx(() => Text(
                                          itemTransactionController.date.value.isNotEmpty?GeneralMethods.addTwoDays(itemTransactionController.date.value):"",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                  color: AppColors.appBackgroundGreyColor,
                                ),
                                const SizedBox(width: 26.0),
                                Column(
                                  children: [
                                    const Text(
                                      'Mode',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Sofia Sans',
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appNeutralColor2,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: itemTransactionController.payMode.value == "0"
                                              ? AppColors.appOrangeLightColor
                                              : AppColors.appLightBlueColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: FittedBox(
                                          child: Obx(() => Text(
                                            itemTransactionController.payMode.value == "0" ? "Manual" : "Auto",
                                            style: TextStyle(
                                              color: itemTransactionController.payMode.value == "0"
                                                  ? AppColors.appYellowColor
                                                  : AppColors.appTextBlueColor,
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                  color: AppColors.appBackgroundGreyColor,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.02),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildCustomerDetailCollapsibleSection(
                        title: "Customer Details",
                        isExpanded: isCustomerDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isCustomerDetailsExpanded =
                            !isCustomerDetailsExpanded;
                          });
                        },
                        child: _buildCustomerDetailsCard(),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      _buildCustomerDetailCollapsibleSection(
                        title: "Account Details",
                        isExpanded: isAccountDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isAccountDetailsExpanded =
                            !isAccountDetailsExpanded;
                          });
                        },
                        child: _buildAccountDetailsCard(),
                      ),
                      const SizedBox(height: 16),
                      _buildCustomerDetailCollapsibleSection(
                        title: "Purchase Details",
                        isExpanded: isPurchaseDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isPurchaseDetailsExpanded =
                            !isPurchaseDetailsExpanded;
                          });
                        },
                        child:
                        ListView.builder(
                          shrinkWrap: true, // Ensures the ListView takes minimal height
                          physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                          itemCount: itemTransactionController.allProductList.length,
                          itemBuilder: (context, index) {
                            return _buildPurchaseDetailsCard(itemTransactionController.allProductList,index,context);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (variableController.loading.value)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      child: Lottie.asset("assets/lottie/half-circles.json"),
                    ),
                  ),
                ),
            ],
          ),
      );
    });
  }

  Widget _buildCustomerDetailCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
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
                // PopupMenuButton<String>(
                //   icon: Icon(Icons.more_vert),
                //   onSelected: (value) {
                //     // Handle menu selection
                //     if (value == 'edit') {
                //       // Handle edit action
                //     } else if (value == 'delete') {
                //       // Handle delete action
                //     }
                //   },
                //   itemBuilder: (BuildContext context) {
                //     return [
                //       const PopupMenuItem<String>(
                //         value: 'edit',
                //         child: Text('Edit'),
                //       ),
                //       const PopupMenuItem<String>(
                //         value: 'delete',`
                //         child: Text('Delete'),
                //       ),
                //     ];
                //   },
                // ),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: AppColors.appBlackColor),
              ],
            ),
            onTap: onToggle,
          ),
          if (isExpanded) child,
        ],
      ),
    );
  }

  Widget _buildCustomerDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Customer Name", itemTransactionController.customerName),
          _buildDetailRow("Mobile ID", itemTransactionController.customerMobileNo),
          _buildDetailRow("Email ID", itemTransactionController.customerEmailId),
          // Add Menu Button Inline
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Business Name", itemTransactionController.businessName),
          _buildDetailRow("Business Email",itemTransactionController.businessEmail),
          _buildDetailRow("Phone Number", itemTransactionController.businessNumber),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Account Number", itemTransactionController.accountNumber),
          _buildDetailRow("Routing Number", itemTransactionController.routingNumber),
          _buildDetailRow("Bank Name", itemTransactionController.bankName),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetailsCard(List<ProDetail> allproductList,
      int index, context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPurchaseDetailRow("Product Name", allproductList[index].proName),
          _buildPurchaseDetailRow("Price", allproductList[index].proPrice),
          _buildPurchaseDetailRow("Quantity",allproductList[index].proQty),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
          Expanded(
            flex: 2,
            child:  Text(value,
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


  Widget _buildDetailRow(String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
          Expanded(
            flex: 2,
            child:  Obx(() => Text(value.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ))),
          ),
        ],
      ),
    );
  }

  Widget transactionCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "-Check Number ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
              Obx(() =>Text(':   ${itemTransactionController.checkNo.value}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  )))
              ,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Obx(() =>
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: itemTransactionController.decorationColor.value,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() =>
                          Text( itemTransactionController.isSchedule==true && itemTransactionController.payMode== '0'?'Scheduler'
                              :(
                              itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == true &&
                                  ![5, 6, 7].contains(itemTransactionController.payStatus)
                                  ? 'Delete request'
                                  : (itemTransactionController.isDeletedRequest == true &&
                                  itemTransactionController.isDeleted == true
                                  ? 'Reimbursement'
                                  : (itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.isDeleted == true
                                  ? 'Reimbursement'
                                  : (itemTransactionController.payStatus == '5' &&
                                  itemTransactionController.isDeletedRequest ==
                                      false &&
                                  itemTransactionController.isDeleted == false
                                  ? 'Cancelled'
                                  : (itemTransactionController.payStatus == '6' &&
                                  itemTransactionController.isDeletedRequest ==
                                      false &&
                                  itemTransactionController.isDeleted ==
                                      false &&
                                  itemTransactionController.downloadByMerchant ==
                                      true
                                  ? 'Successful'
                                  : (itemTransactionController.payStatus == '7' &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.isDeleted == false &&
                                  itemTransactionController.downloadByMerchant == true
                                  ? 'Unsuccessful'
                                  : (itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.downloadByMerchant == true &&
                                  ![5, 6, 7].contains(itemTransactionController.payStatus)
                                  ? 'Downloaded'
                                  : (itemTransactionController.verificationStatus == true &&
                                  itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.downloadByMerchant == false &&
                                  itemTransactionController.payStatus != '5'
                                  ? 'Verified'
                                  : (itemTransactionController.payStatus == '0' &&
                                  itemTransactionController.verificationStatus == false &&
                                  itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.downloadByMerchant == false ? 'New'
                                  : (itemTransactionController.payStatus == '4' &&
                                  itemTransactionController.verificationStatus == false &&
                                  itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.downloadByMerchant == false
                                  ? 'Incomplete'
                                  : (itemTransactionController.payStatus == '3' &&
                                  itemTransactionController.verificationStatus == false &&
                                  itemTransactionController.isDeleted == false &&
                                  itemTransactionController.isDeletedRequest == false &&
                                  itemTransactionController.downloadByMerchant == false
                                  ? 'Complete'
                                  : 'Unknown'))))))))))),
                            style: TextStyle(
                                color:  itemTransactionController.isSchedule==true && itemTransactionController.payMode== '0'?AppColors.appYellowColor
                                    :(itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == true &&
                                    ![5, 6, 7]
                                        .contains(itemTransactionController.payStatus)
                                    ? AppColors.appTextColor2
                                    : (itemTransactionController.isDeletedRequest == true &&
                                    itemTransactionController.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (itemTransactionController.payStatus == '5' &&
                                    itemTransactionController.isDeletedRequest ==
                                        false &&
                                    itemTransactionController.isDeleted == false
                                    ? AppColors.appRedColor
                                    : (itemTransactionController.payStatus == '6' &&
                                    itemTransactionController.isDeletedRequest ==
                                        false &&
                                    itemTransactionController.isDeleted ==
                                        false &&
                                    itemTransactionController.downloadByMerchant ==
                                        true
                                    ? AppColors.appGreenColor
                                    : (itemTransactionController.payStatus == '7' &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController.downloadByMerchant == true
                                    ? AppColors.appRedColor
                                    : (itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.downloadByMerchant == true &&
                                    ![5, 6, 7].contains(itemTransactionController.payStatus)
                                    ? AppColors
                                    .appTextBlueColor
                                    : (itemTransactionController.verificationStatus ==
                                    true && itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.downloadByMerchant == false &&
                                    itemTransactionController.payStatus != '5'
                                    ? AppColors
                                    .appTextGreenColor
                                    : (itemTransactionController.payStatus == '0' &&
                                    itemTransactionController.verificationStatus == false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.downloadByMerchant == false
                                    ? AppColors.appSkyBlueText
                                    : (itemTransactionController.payStatus == '4' &&
                                    itemTransactionController.verificationStatus == false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.downloadByMerchant == false
                                    ? AppColors.appOrangeTextColor
                                    : (itemTransactionController.payStatus == '3' &&
                                    itemTransactionController.verificationStatus == false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.downloadByMerchant == false
                                    ? AppColors.appGreenTextColor
                                    : AppColors.appTextBlueColor))))))))))),
                                fontSize: 12),
                          )),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              const Text(
                "-Memo                   ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
              Obx(() =>Text(':   ${itemTransactionController.memo}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ))),
            ],
          )
        ],
      ),
    );
  }
}
