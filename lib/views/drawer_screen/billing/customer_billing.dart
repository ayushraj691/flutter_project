import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/billing_controller/customer_billing.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/billing_model/ResCustomerBilling.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class CustomerBilling extends StatefulWidget {
  const CustomerBilling({super.key});

  @override
  State<CustomerBilling> createState() => _CustomerBillingState();
}

class _CustomerBillingState extends State<CustomerBilling> {
  var customerBillingController = Get.find<CustomerBillingController>();
  var variableController = Get.find<VariableController>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
    });
    super.initState();
  }

  void callMethod() async {
    await customerBillingController.getAllCustomerBilling(
        CommonVariable.businessId.value,
        '',
        customerBillingController.startDate.value,
        customerBillingController.endDate.value);
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
              onTap: () => {Get.to(const BusinessProfileScreen())},
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
            padding: const EdgeInsets.only(left: 16.0,right: 16.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                    child: Text(
                      "Customer Billing",
                      style: TextStyle(
                        fontFamily: 'Sofia Sans',
                        color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                          onPressed: () => customerBillingController
                              .showSelectDurationBottomSheet(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() {
                                return Text(
                                  customerBillingController.buttonText.value,
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
                      child: Container(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: GridView.builder(
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio:
                          1.7,
                    ),
                    itemBuilder: (context, index) {
                      String displayText;
                      String textIcon = '';
                      List<Color> containerColors = [
                        AppColors.appParrotGreenColor,
                        AppColors.appCreamColor,
                        AppColors.appCreamColor,
                        AppColors.appLightPurpleColor,
                      ];

                      switch (index) {
                        case 0:
                          displayText = "Total Customers";
                          textIcon = ImageAssets.customerPerson;
                          break;
                        case 1:
                          displayText = "Total Transaction";
                          textIcon = ImageAssets.totalTransaction;
                          break;
                        case 2:
                          displayText = "Cancelled Check";
                          textIcon = ImageAssets.cancelCheck;
                          break;
                        case 3:
                          displayText = "Processing Volume";
                          textIcon = ImageAssets.processingVolume;
                          break;
                        default:
                          displayText = ""; // Default text
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: containerColors[index],
                          borderRadius: BorderRadius.circular(22.0),
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
                              vertical: MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              // Ensures column takes as little space as needed
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() => Text(
                                            index == 0
                                                ? "${customerBillingController.totalCustomer.value.toInt()}"
                                                : index == 1
                                                    ? "${customerBillingController.totalTransaction.value.toInt()}"
                                                    : index == 2
                                                        ? "${customerBillingController.cancelledCheck.value.toInt()}"
                                                        : "${customerBillingController.processingVolume.value}",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.asset(
                                      textIcon,
                                      height: MediaQuery.of(context).size.height *
                                          0.05,
                                      width:
                                          MediaQuery.of(context).size.width * 0.1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  displayText,
                                  style: TextStyle(
                                    color: AppColors.appTextLightColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.04,
                                    fontFamily: 'Sofia Sans',
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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

  Widget _buildRecentTransactionsSection() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 16.0,top: 16.0,bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Billing History",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                      fontSize: 16,
                      fontFamily: 'Sofia Sans',
                    ),
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     "viewAll",
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       color: AppColors.appBlueColor,
                //       fontSize: 12,
                //       fontFamily: 'Sofia Sans',
                //     ),
                //     overflow: TextOverflow.ellipsis, // Handle text overflow
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (customerBillingController.customerList.isEmpty) {
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
                  itemCount: customerBillingController.customerList.length,
                  itemBuilder: (context, index) {
                    return listTransactionCard(
                      customerBillingController.customerList,
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

  Widget listTransactionCard(
      List<CustomerList> allCustomerList, int index, context) {
    final customerList = allCustomerList[index];
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            customerList.custName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.appHeadingText,
              fontSize: 14,
              fontFamily: Constants.Sofiafontfamily,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Number of Transactions:  ${customerList.totalPayments}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appHeadingText,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "\$${customerList.totalAmount.toString()}",
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
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
