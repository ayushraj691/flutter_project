import 'dart:convert';
import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResSingleCustomerModel.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllRecentTransaction.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/drawer_screen/customer/add_account_popup.dart';
import 'package:paycron/views/drawer_screen/customer/edit_screen/edit_customer_popup.dart';
import 'package:paycron/views/drawer_screen/customer/edit_screen/edit_update_account.dart';
import 'package:paycron/views/funds/transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String id;

  const CustomerDetailsScreen({super.key, required this.id});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  var customerDetailViewController = Get.find<CustomerDetailViewController>();
  var variableController = Get.find<VariableController>();
  var addCustomerController = Get.find<AddCustomerController>();
  List<ResAllRecentTransaction> filteredItems = <ResAllRecentTransaction>[].obs;

  bool isPersonalDetailsExpanded = true;
  bool isAccountDetailsExpanded = true;

  Map<String, dynamic> sortMap = {
    "": "",
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod(customerDetailViewController.filterValue.value);
    });
    super.initState();
  }

  void callMethod(String filterValue) async {
    await customerDetailViewController.getSingleData(widget.id);
    await customerDetailViewController.getAllRecentTransactionData(
      widget.id,
      '',
      jsonEncode(customerDetailViewController.getArgumentMap(filterValue)),
      "$sortMap",
    );
    filteredItems = customerDetailViewController.allRecentTransactionList;
    customerDetailViewController.searchController.addListener(_filterItems);
  }

  void _filterItems() {
    String query =
        customerDetailViewController.searchController.text.toLowerCase();
    setState(() {
      filteredItems = customerDetailViewController.allRecentTransactionList
          .where((item) => item.custId.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBackgroundColor,
          leading: IconButton(
            color: AppColors.appBlackColor,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Action for back arrow
            },
          ),
          titleSpacing: 0, // Removes extra space between arrow and title
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            // Adjust title text to fit within screen width
            child: Text(
              "Customer Details",
              style: TextStyle(
                fontSize: 16, // Dynamic font size
                fontWeight: FontWeight.w600,
                color: AppColors.appTextColor,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *
                      0.05,
                  vertical: MediaQuery.of(context).size.height *
                      0.02,
                ),
                child: ListView(
                  children: [
                    if (customerDetailViewController
                            .allSingleDataList.isEmpty &&
                        !variableController.loading.value)
                      NoDataFoundCard()
                    else ...[
                      _buildPersonalDetailCollapsibleSection(
                        title: "Personal Details",
                        isExpanded: isPersonalDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isPersonalDetailsExpanded =
                                !isPersonalDetailsExpanded;
                          });
                        },
                        child: _buildPersonalDetailsCard(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      _buildAccountDetailCollapsibleSection(
                        title: "Account Details",
                        isExpanded: isAccountDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isAccountDetailsExpanded =
                                !isAccountDetailsExpanded;
                          });
                        },
                        child: _buildAccountDetailsSection(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      _buildRecentTransactionsSection(),
                    ]
                  ],
                ),
              ),
              // if (variableController.loading.value)
              //   Container(
              //     color: Colors.black.withOpacity(0.6),
              //     child: Center(
              //       child: Container(
              //         alignment: Alignment.center,
              //         height: 150,
              //         width: 150,
              //         child: Lottie.asset(
              //             "assets/lottie/half-circles.json"),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _refreshData() async {
    callMethod(customerDetailViewController.filterValue.value);
    setState(() {});
  }

  Widget _buildPersonalDetailCollapsibleSection({
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
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Circular dialog shape
                  ),
                  onSelected: (value) {
                    // Handle menu selection
                    if (value == 'edit') {
                      editCustomerPopup(context,widget.id);
                    } else if (value == 'remove') {
                      // Handle delete action
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined,
                                color: AppColors.appBlackColor),
                            // Icon for edit
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      // const PopupMenuItem<String>(
                      //   value: 'remove',
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.delete_outline_outlined,
                      //           color: AppColors.appBlackColor),
                      //       // Icon for remove
                      //       SizedBox(width: 8),
                      //       Text('Remove'),
                      //     ],
                      //   ),
                      // ),
                    ];
                  },
                ),
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

  Widget _buildPersonalDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Name:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                customerDetailViewController.personName.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
            ),
          ),
          // Obx(
          //   () => _buildDetailRow("Mobile number",
          //       customerDetailViewController.personMobileNumber.value),
          // ),
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Mobile number:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                customerDetailViewController.personMobileNumber.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
            ),
          ),
          // Obx(
          //   () => _buildDetailRow(
          //       "Email", customerDetailViewController.personEmail.value),
          // ),
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Email:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                customerDetailViewController.personEmail.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
            ),
          ),
          // Obx(
          //   () => _buildDetailRow("Description",
          //       customerDetailViewController.personDescription.value),
          // )
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                customerDetailViewController.personDescription.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAccountDetailsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (customerDetailViewController.allBankList.isEmpty) {
              return variableController.loading.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        child: Lottie.asset("assets/lottie/half-circles.json"),
                      ),
                    )
                  : NoDataFoundCard();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: customerDetailViewController.allBankList.length,
                itemBuilder: (context, index) {
                  return accountDetailListItem(
                      customerDetailViewController
                          .allBankList[index].accountName,
                      customerDetailViewController
                          .allBankList[index].accountNumber,
                      customerDetailViewController.allBankList[index].bankName,
                      customerDetailViewController.allBankList,
                      index,
                      context);
                },
                physics: const ScrollPhysics(),
              );
            }
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget accountDetailListItem(String holderName, String accountNumber,
      String bankName, List<BankId> allBankList, int index, context) {
    bool isSelected = allBankList[index].primary;
    bool isStatus = allBankList[index].status;
    return Opacity(
      opacity: isStatus ? 1.0 : 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appWhiteColor
                          : AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(20.0),
                      // Slightly smaller radius for a cleaner look
                      border: Border.all(
                        color: isSelected
                            ? AppColors.appBlueColor
                            : AppColors.appNeutralColor5,
                        width: 2,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Ensure space between details and menu
                        children: [
                          // Account details section
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Vertically center content
                              children: [
                                _buildDetailRow("Holder's Name", holderName),
                                const SizedBox(height: 4),
                                // Reduced spacing for a compact look
                                _buildDetailRow(
                                    "Account Number",
                                    GeneralMethods.maskAccountNumber(
                                        accountNumber)),
                                const SizedBox(height: 4),
                                _buildDetailRow("Bank Name", bankName),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Circular dialog shape
                            ),
                            onSelected: (value) {
                              if (value == 'edit') {
                                editUpdateAccountPopup(context,index,widget.id);
                              } else if (value == 'disable') {
                                showDisableConfirmationDialog(allBankList[index].sId,allBankList[index].status?'Disable':'Enable');
                              }else if (value == 'enable') {
                                showDisableConfirmationDialog(allBankList[index].sId,allBankList[index].status?'Disable':'Enable');
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                if(allBankList[index].status)
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_outlined,
                                          color: AppColors.appBlackColor),
                                      // Icon for edit
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                if(!allBankList[index].primary)
                                PopupMenuItem<String>(
                                  value: allBankList[index].status?'disable':'enable',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.disabled_visible,
                                          color: AppColors.appBlackColor),
                                      // Icon for remove
                                      SizedBox(width: 8),
                                      Text(allBankList[index].status?'Disable':'Enable'),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: -13,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.appBlueColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Primary Account',
                          style: TextStyle(
                            color: AppColors.appWhiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget listTransactionCard(
      List<ResAllRecentTransaction> allRecentTransaction, int index, context) {
    final subscription = allRecentTransaction[index];
    final createdDate = subscription.createdOn;
    DateTime dateTime = DateTime.parse(createdDate).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    return InkWell(
      onTap: () {
        Get.to(TransactionsDetails(id:subscription.sId));
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
                  Flexible(
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: subscription.isDeleted == false &&
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
                              : AppColors.appLightBlueColor)))))))))),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FittedBox(
                          child: Text(
                            subscription.isDeleted == false &&
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
                                : 'Unknown')))))))))),
                            style: TextStyle(
                                color: subscription.isDeleted == false &&
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
                                    : AppColors.appTextBlueColor)))))))))),
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Transaction ID and Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      "Transaction ID: ${subscription.txnNumber}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.appHeadingText,
                        fontSize: 14,
                        fontFamily: 'Sofia Sans',
                      ),
                      overflow:
                          TextOverflow.ellipsis, // Handle overflow gracefully
                    ),
                  ),
                  Flexible(
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

              // Source Text
              Text(
                "Source: ${subscription.memo}",
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

  void addAccountPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddAccountPopup(widget.id, onSave: () {
            setState(() {
              callMethod(customerDetailViewController.filterValue.value);
            });
          }),
        );
      },
    );
  }


  void editCustomerPopup(BuildContext context,String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: EditCustomerPopup(id,
              onSave: () {
                setState(() {
                  callMethod(customerDetailViewController.filterValue.value);
                });
              },),
        );
      },
    );
  }

  void editUpdateAccountPopup(BuildContext context,int index,String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: EditUpdateAccountPopup(index,id,
              onSave: () {
                setState(() {
                  callMethod(customerDetailViewController.filterValue.value);
                });
              },),
        );
      },
    );
  }

  void showDisableConfirmationDialog(String bankId,String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: Text("Are you sure you want to $text this account?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                  customerDetailViewController.disableAccount(bankId);
                  callMethod(customerDetailViewController.filterValue.value);
                  Navigator.of(context).pop();
              },
              child: Text(
                text,
                style: const TextStyle(color: AppColors.appBlueColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecentTransactionsSection() {
    final customerDetailController = Get.find<CustomerDetailViewController>();
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
                // Text Widget inside Flexible to prevent overflow
                const Flexible(
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                      fontSize: 16,
                      fontFamily: 'Sofia Sans',
                    ),
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.appBackgroundGreyColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: AppColors.appBlueColor,
                      style: BorderStyle.none,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.appBackgroundGreyColor,
                        offset: Offset(0, 0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  height: 22,
                  width: MediaQuery.of(context).size.width * 0.30,
                  // Dynamically set the width based on screen size
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'form',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: 'Sofia Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      items: customerDetailController.filterItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle text overflow in dropdown
                                  ),
                                ),
                              ))
                          .toList(),
                      value: customerDetailController.filterValue.value,
                      onChanged: (value) {
                        customerDetailController.filterValue.value =
                            value as String;
                        final selectedIndex =
                            customerDetailController.filterItems.indexOf(value);
                        if (selectedIndex != -1) {
                          debugPrint('Selected index: ${selectedIndex + 1}');
                          callMethod(value);
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        height: 40,
                        width: 110,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            _buildSearchBar(),

            Obx(() {
              if (customerDetailViewController
                  .allRecentTransactionList.isEmpty) {
                return variableController.loading.value
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : NoDataFoundCard(); // Your custom widget
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable scrolling inside ListView
                  itemCount: customerDetailViewController
                      .allRecentTransactionList.length,
                  itemBuilder: (context, index) {
                    return listTransactionCard(
                      customerDetailViewController.allRecentTransactionList,
                      index,
                      context,
                    );
                  },
                );
              }
            }),
            // Obx(
            //   () => customerDetailViewController
            //           .allRecentTransactionList.isEmpty
            //       ? const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(child: CircularProgressIndicator()),
            //         )
            //       : ListView.builder(
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           // Disable scrolling inside ListView
            //           itemCount: customerDetailViewController
            //               .allRecentTransactionList.length,
            //           itemBuilder: (context, index) {
            //             return listTransactionCard(
            //               customerDetailViewController.allRecentTransactionList,
            //               index,
            //               context,
            //             );
            //           },
            //         ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: TextEditingController(),
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

  Widget _buildAccountDetailCollapsibleSection({
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
                InkWell(
                  onTap: () {
                    addCustomerController.clearAllAccount();
                    addAccountPopup(context);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.add_circle, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Add Account',
                        style: TextStyle(
                            fontFamily: 'Sofia Sans',
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
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

  Widget _buildDetailRow(String label, String value) {
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
