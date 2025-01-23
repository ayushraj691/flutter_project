import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/itemTransactionDetailController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResSinglePayment.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import '../../utils/string_constants.dart';

class TransactionsDetails extends StatefulWidget {
  final String id;

  const TransactionsDetails({super.key, required this.id});

  @override
  State<TransactionsDetails> createState() => _TransactionsDetailsState();
}

class _TransactionsDetailsState extends State<TransactionsDetails> {
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
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
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
            "Transaction Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: Constants.Sofiafontfamily,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  if (itemTransactionController.allSinglePaymentDataList
                      .isEmpty &&
                      !variableController.loading.value)
                    NoDataFoundCard() // Show "No Data" widget when the list is empty and not loading
                  else
                    ...[
                      transactionCard(),
                      const SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.02,
                        ), // Responsive padding
                        decoration: BoxDecoration(
                          color: AppColors.appTabBackgroundColor,
                          borderRadius: BorderRadius.circular(
                              screenWidth * 0.05),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: screenWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appNeutralColor2,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.006),
                                    Obx(() =>
                                        Text(
                                          itemTransactionController.date.value,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.04, // Adjust height
                              child: const VerticalDivider(
                                thickness: 2,
                                color: AppColors.appBackgroundGreyColor,
                                width: 20,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: screenWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transaction ID',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appNeutralColor2,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.006),
                                    Obx(() =>
                                        Text(
                                          itemTransactionController
                                              .transactionId.value,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.appNeutralColor2,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.04, // Adjust height
                              child: const VerticalDivider(
                                thickness: 2,
                                color: AppColors.appBackgroundGreyColor,
                                width: 20,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Constants.Sofiafontfamily,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appNeutralColor2,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.006),
                                Obx(() =>
                                    Text(
                                      GeneralMethods.formatAmount(itemTransactionController.amount.value)
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.appBlackColor,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                      const SizedBox(height: 8),
                      _buildCustomerDetailCollapsibleSection(
                        title: "Business Details",
                        isExpanded: isBusinessDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isBusinessDetailsExpanded =
                            !isBusinessDetailsExpanded;
                          });
                        },
                        child: _buildBusinessDetailsCard()
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
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
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemTransactionController.allProductList
                              .length,
                          itemBuilder: (context, index) {
                            return _buildPurchaseDetailsCard(
                                itemTransactionController.allProductList, index,
                                context);
                          },
                        ),
                      ),
                    ],
                ],
              ),
            ),
            // Loader overlay
            if (variableController.loading.value)
              Container(
                color: Colors.black.withOpacity(0.6),
                // Semi-transparent overlay
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: Lottie.asset(
                        "assets/lottie/half-circles.json"),
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

  Widget _buildCustomerDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
              "Customer Name", itemTransactionController.customerName),
          _buildDetailRow(
              "Mobile ID", itemTransactionController.customerMobileNo),
          _buildDetailRow(
              "Email ID", itemTransactionController.customerEmailId),
          // Add Menu Button Inline
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
              "Business Name", itemTransactionController.businessName),
          _buildDetailRow(
              "Business Email", itemTransactionController.businessEmail),
          _buildDetailRow(
              "Phone Number", itemTransactionController.businessNumber),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
              "Account Number", itemTransactionController.accountNumber),
          _buildDetailRow(
              "Routing Number", itemTransactionController.routingNumber),
          _buildDetailRow("Bank Name", itemTransactionController.bankName),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetailsCard(List<ProDetail> allproductList,
      int index, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPurchaseDetailRow(
              "Product Name", allproductList[index].proName),
          _buildPurchaseDetailRow("Price", "\$${allproductList[index].proPrice}"),
          _buildPurchaseDetailRow("Quantity", allproductList[index].proQty),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Text
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.appBlackColor,
              fontSize: 14,
              fontFamily: Constants.Sofiafontfamily,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.appBlackColor,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDetailRow(String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.006,),
          Text(
            ':',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.appBlackColor,
              fontSize: 14,
              fontFamily: Constants.Sofiafontfamily,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
          Expanded(
            flex: 3,
            child: Obx(() => Text(
              value.value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.appBlackColor,
                fontSize: 14,
                fontFamily: Constants.Sofiafontfamily,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget transactionCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "-Check Number ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
              Obx(() =>
                  Text(':   ${itemTransactionController.checkNo.value}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                        fontSize: 14,
                        fontFamily: Constants.Sofiafontfamily,
                      ))),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03,
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
                          Text(  itemTransactionController.isDeleted == false &&
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
                              itemTransactionController.isDeletedRequest == false &&
                              itemTransactionController.isDeleted == false
                              ? 'Cancelled'
                              : (itemTransactionController.payStatus == '6' &&
                              itemTransactionController.isDeletedRequest == false &&
                              itemTransactionController.isDeleted == false &&
                              itemTransactionController.downloadByMerchant == true
                              ? 'Successful'
                              : (itemTransactionController.payStatus == '7' &&
                              itemTransactionController.isDeletedRequest ==
                                  false &&
                              itemTransactionController.isDeleted == false &&
                              itemTransactionController.downloadByMerchant ==
                                  true
                              ? 'Unsuccessful'
                              : (itemTransactionController.isDeleted == false &&
                              itemTransactionController.isDeletedRequest ==
                                  false &&
                              itemTransactionController.downloadByMerchant ==
                                  true &&
                              ![5, 6, 7].contains(
                                  itemTransactionController.payStatus)
                              ? 'Downloaded'
                              : (itemTransactionController.verificationStatus ==
                              true &&
                              itemTransactionController.isDeleted ==
                                  false &&
                              itemTransactionController
                                  .isDeletedRequest ==
                                  false &&
                              itemTransactionController
                                  .downloadByMerchant ==
                                  false &&
                              itemTransactionController.payStatus != '5'
                              ? 'Verified'
                              : (itemTransactionController.payStatus == '0' &&
                              itemTransactionController
                                  .verificationStatus ==
                                  false &&
                              itemTransactionController.isDeleted ==
                                  false &&
                              itemTransactionController
                                  .isDeletedRequest ==
                                  false &&
                              itemTransactionController
                                  .downloadByMerchant ==
                                  false
                              ? 'New'
                              : (itemTransactionController.payStatus ==
                              '4' &&
                              itemTransactionController
                                  .verificationStatus ==
                                  false &&
                              itemTransactionController
                                  .isDeleted ==
                                  false &&
                              itemTransactionController
                                  .isDeletedRequest ==
                                  false &&
                              itemTransactionController
                                  .downloadByMerchant ==
                                  false
                              ? 'Incomplete'
                              : (itemTransactionController
                              .payStatus ==
                              '3' &&
                              itemTransactionController
                                  .verificationStatus ==
                                  false &&
                              itemTransactionController
                                  .isDeleted ==
                                  false &&
                              itemTransactionController
                                  .isDeletedRequest ==
                                  false &&
                              itemTransactionController
                                  .downloadByMerchant ==
                                  false
                              ? 'Complete'
                              : 'Unknown')))))))))),
                            style: TextStyle(
                                color: itemTransactionController.isDeleted == false &&
                                    itemTransactionController.isDeletedRequest == true &&
                                    ![5, 6, 7].contains(itemTransactionController.payStatus)
                                    ? AppColors.appTextColor2
                                    : (itemTransactionController.isDeletedRequest == true &&
                                    itemTransactionController.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.isDeleted == true
                                    ? AppColors.appPurpleColor
                                    : (itemTransactionController.payStatus == '5' &&
                                    itemTransactionController.isDeletedRequest == false &&
                                    itemTransactionController.isDeleted == false
                                    ? AppColors.appRedColor
                                    : (itemTransactionController.payStatus == '6' &&
                                    itemTransactionController.isDeletedRequest ==
                                        false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController.downloadByMerchant == true
                                    ? AppColors.appGreenColor
                                    : (itemTransactionController.payStatus == '7' &&
                                    itemTransactionController.isDeletedRequest ==
                                        false &&
                                    itemTransactionController.isDeleted == false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        true
                                    ? AppColors.appRedColor
                                    : (itemTransactionController.isDeleted == false &&
                                    itemTransactionController
                                        .isDeletedRequest ==
                                        false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        true &&
                                    ![5, 6, 7].contains(
                                        itemTransactionController.payStatus)
                                    ? AppColors.appTextBlueColor
                                    : (itemTransactionController
                                    .verificationStatus ==
                                    true &&
                                    itemTransactionController.isDeleted ==
                                        false &&
                                    itemTransactionController
                                        .isDeletedRequest ==
                                        false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        false &&
                                    itemTransactionController.payStatus !=
                                        '5'
                                    ? AppColors.appTextGreenColor
                                    : (itemTransactionController.payStatus ==
                                    '0' &&
                                    itemTransactionController
                                        .verificationStatus ==
                                        false &&
                                    itemTransactionController
                                        .isDeleted ==
                                        false &&
                                    itemTransactionController
                                        .isDeletedRequest ==
                                        false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        false
                                    ? AppColors.appSkyBlueText
                                    : (itemTransactionController.payStatus ==
                                    '4' &&
                                    itemTransactionController
                                        .verificationStatus ==
                                        false &&
                                    itemTransactionController
                                        .isDeleted ==
                                        false &&
                                    itemTransactionController
                                        .isDeletedRequest ==
                                        false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        false
                                    ? AppColors.appOrangeTextColor
                                    : (itemTransactionController
                                    .payStatus ==
                                    '3' &&
                                    itemTransactionController
                                        .verificationStatus ==
                                        false &&
                                    itemTransactionController
                                        .isDeleted ==
                                        false &&
                                    itemTransactionController
                                        .isDeletedRequest ==
                                        false &&
                                    itemTransactionController
                                        .downloadByMerchant ==
                                        false
                                    ? AppColors.appGreenTextColor
                                    : AppColors
                                    .appTextBlueColor)))))))))),
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
              Text(
                "-Memo                   ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
              Obx(() =>
                  Text(':   ${itemTransactionController.memo}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                        fontSize: 14,
                        fontFamily: Constants.Sofiafontfamily,))),
            ],
          )
        ],
      ),
    );
  }
}
