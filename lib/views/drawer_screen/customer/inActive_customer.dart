import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/Inactive_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/ResAllFilterCustomerDataModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/views/drawer_screen/customer/createCustomerForm.dart';
import 'package:paycron/views/drawer_screen/customer/customer_details_view.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import 'package:paycron/views/widgets/common_button.dart';

class InActiveTab extends StatefulWidget {
  const InActiveTab({super.key});

  @override
  State<InActiveTab> createState() => _InActiveTabState();
}

class _InActiveTabState extends State<InActiveTab> {
  TextEditingController searchController = TextEditingController();
  var inActiveTabController = Get.find<InActiveController>();
  var addCustomerController = Get.find<AddCustomerController>();
  var variableController = Get.find<VariableController>();
  List<ResAllFilterCustomerData> filteredItems = <ResAllFilterCustomerData>[].obs;


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0),(){
      CallMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void CallMethod() async{
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "\"is_deleted\"": true,
    };
    await inActiveTabController.getAllCustomerData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      inActiveTabController.startDate.value,
      inActiveTabController.endDate.value,
      "$sortMap",
    );
    filteredItems = inActiveTabController.allCustomerDataList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = inActiveTabController.allCustomerDataList
          .where(
              (item) => item.info.custName.toLowerCase().contains(query))
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackgroundGreyColor,
                              // Button color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              elevation: 4,
                              shadowColor: Colors.black45,
                            ),
                            onPressed: () =>
                                inActiveTabController.showDatePickerDialog(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() {
                                  return Text(
                                    inActiveTabController.buttonText.value,
                                    style: const TextStyle(
                                      fontSize: 14,
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
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: screenWidth ,
                            height: 39,
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
                                  fontSize: 16,
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
                    elevation: 2.0,
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
                          if (inActiveTabController.allCustomerDataList.isEmpty) {
                            return variableController.loading.value
                                ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                )
                                : NoDataFoundCard(); // Your custom widget
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                              filteredItems.length,
                              itemBuilder: (context, index) {
                                return listItem(
                                    filteredItems,
                                    index,
                                    context);
                              },
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Center(
              child: CommonButton(
                buttonWidth: screenWidth * 0.9,
                icon: Icons.add,
                buttonName: "Add Customer",
                onPressed: () {
                  Get.to(const AddCustomerForm());
                  addCustomerController.clearAllAccount();
                  addCustomerController.clearAllCustomer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget listItem(List<ResAllFilterCustomerData> allCustomerDataList, int index,
    BuildContext context) {
  final customer = allCustomerDataList[index];
  final customerName = customer.info.custName;
  final accountNumber = customer.bankId.isNotEmpty ? customer.bankId[0].accountNumber : 'N/A';
  final createdDate = customer.createdOn;
  final customerStatus = customer.isDeleted;
  DateTime dateTime = DateTime.parse(createdDate).toLocal();
  String formattedTime = DateFormat.jm().format(dateTime);
  String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

  return InkWell(
    onTap: customerStatus ? null : () async {
      Get.to(CustomerDetailsScreen(id: customer.sId,));
    },
    child: Opacity(
      opacity: customerStatus ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        GeneralMethods.getAcronym(customerName),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display customer name
                          Text(
                            customerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                          Text(
                            GeneralMethods.maskAccountNumber(accountNumber),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                          Text(
                            formattedTime,
                            style:  const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.appGreyColor,
                              fontSize: 12,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
