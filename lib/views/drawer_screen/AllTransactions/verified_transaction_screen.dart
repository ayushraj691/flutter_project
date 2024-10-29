import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/Verified_transaction_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class TransactionVerifiedTab extends StatefulWidget {
  const TransactionVerifiedTab({super.key});

  @override
  State<TransactionVerifiedTab> createState() => _TransactionVerifiedTabState();
}

class _TransactionVerifiedTabState extends State<TransactionVerifiedTab> {
  TextEditingController searchController = TextEditingController();
  var verifiedTransactionTabController = Get.find<VerifiedTransactionController>();
  var variableController = Get.find<VariableController>();
  List<ResTransactionDetail> filteredItems = <ResTransactionDetail>[].obs;

  List<int> selectedItems = [];
  bool isSelectionMode = false;
  bool isAllSelected = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      CallMethod();
      searchController.addListener(_filterItems);
    });
  }

  Map<String, dynamic> sortMap = {
    "": "",
  };
  Map<String, dynamic> argumentMap = {
    "": "",
  };

  void CallMethod() async{
    await verifiedTransactionTabController.getAllTransactionData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      verifiedTransactionTabController.startDate.value,
      verifiedTransactionTabController.endDate.value,
      "$sortMap",
    );

    filteredItems = verifiedTransactionTabController.verifiedTransactionList;
  }
  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = verifiedTransactionTabController.verifiedTransactionList
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
      verifiedTransactionTabController.verifiedTransactionList.removeWhere(
              (transaction) => selectedItems.contains(verifiedTransactionTabController
              .verifiedTransactionList
              .indexOf(transaction)));
      selectedItems.clear();
      isSelectionMode = false;
      isAllSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // Header buttons for Date picker and Download
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBackgroundGreyColor,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),),
                      elevation: 4,
                      shadowColor: Colors.black45,
                    ),
                    onPressed: () => verifiedTransactionTabController
                        .showDatePickerDialog(context),
                    child: Obx(() {
                      return Text(
                        verifiedTransactionTabController.buttonText.value,
                        style:  TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: Constants.Sofiafontfamily,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: screenWidth,
                    height: 39,
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
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child:  Text(
                        'Download',
                        style: TextStyle(
                          fontFamily: Constants.Sofiafontfamily,
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

          // Search Field
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
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
          ),
          if (isSelectionMode)
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: AppColors.appWhiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                selectedItems.clear();
                                isSelectionMode = false;
                              });
                            },
                          ),
                          Text("${selectedItems.length} items selected"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Row(
                          children: [
                            Checkbox(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4)),
                              ),
                              value: isAllSelected,
                              activeColor: AppColors.appBlueColor,
                              onChanged: (value) {
                                toggleSelectAll();
                              },
                            ),
                             Text("Select all",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Constants.Sofiafontfamily,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appTextColor,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10,left: 10),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.appGreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () => {
                          GeneralMethods.showPopup(context, "verify ${selectedItems.length}",
                              "This will verify your item from transactions. Are you sure?",
                                  () {
                                Navigator.of(context).pop();
                              })
                        },
                        icon: const Icon(Icons.verified),
                        label: const Text('Verify'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.appNeutralColor5,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () => {
                          GeneralMethods.showPopup(context, "delete ${selectedItems.length}",
                              "This will delete your item from transactions. Are you sure?",
                                  () {
                                deleteSelectedItems;
                                Navigator.of(context).pop();
                              })
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.appNeutralColor5,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () => {
                          // GeneralMethods.showPopup(context, "${selectedItems.length}",
                          //     "This will delete your item from transactions. Are you sure?",
                          //     () {
                          //   Navigator.of(context).pop();
                          // })
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.appNeutralColor5,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          Expanded(
            child: Obx(() {
              if (verifiedTransactionTabController.verifiedTransactionList.isEmpty) {
                return variableController.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : NoDataFoundCard(); // Custom no-data widget
              } else {
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return listTransactionCard(filteredItems, index, context);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget listTransactionCard(
      List<ResTransactionDetail> allRecentTransaction, int index, context) {
    final subscription = allRecentTransaction[index];
    final createdDate = subscription.createdOn;
    DateTime dateTime = DateTime.parse(createdDate).toLocal();
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

    final isSelected = selectedItems.contains(index);

    return InkWell(
      onLongPress: () {
        toggleSelectionMode(index);
      },
      onTap: () {
        if (isSelectionMode) {
          toggleSelectionMode(index);
        }
      },
      child: Card(
        color: isSelected ? AppColors.appBlueLightColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      formattedDate,
                      style:  TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                        fontSize: 14,
                        fontFamily: Constants.Sofiafontfamily,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: subscription.isDeleted == "Added"
                              ? AppColors.appSkyBlueBackground
                              : AppColors.appSkyBlueBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FittedBox(
                          child: Text(
                            subscription.subscriptionType,
                            style: const TextStyle(
                                color: AppColors.appSkyBlueText, fontSize: 12),
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
                      "Customer Name: ${subscription.memo}",
                      style:  TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.appHeadingText,
                        fontSize: 14,
                        fontFamily: Constants.Sofiafontfamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$${subscription.payTotal}",
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
              Text(
                "Transaction ID: ${subscription.txnNumber}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appHeadingText,
                  fontSize: 14,
                  fontFamily: Constants.Sofiafontfamily,
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
