import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/active_product_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/product_model/ResAllFilterProductData.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/drawer_screen/product/product_detail_view.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class ActiveTabProduct extends StatefulWidget {
  const ActiveTabProduct({super.key});

  @override
  State<ActiveTabProduct> createState() => _ActiveTabProductState();
}

class _ActiveTabProductState extends State<ActiveTabProduct> {
  TextEditingController searchController = TextEditingController();
  var activeTabProductController = Get.find<ActiveProductController>();
  var variableController = Get.find<VariableController>();
  List<ResAllFilterProductData> filteredItems = <ResAllFilterProductData>[].obs;
  Map<String, dynamic> sortMap = {
    "": "",
  };
  Map<String, dynamic> argumentMap = {
    "is_deleted": false,
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      callMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void callMethod() async {
    Map<String, dynamic> sortMap = {
      "": "",
    };
    Map<String, dynamic> argumentMap = {
      "\"is_deleted\"": false,
    };
    await activeTabProductController.getAllProductData(
      CommonVariable.businessId.value,
      '',
      "$argumentMap",
      activeTabProductController.startDate.value,
      activeTabProductController.endDate.value,
      "$sortMap",
    );
    filteredItems = activeTabProductController.allProductDataList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = activeTabProductController.allProductDataList
          .where((item) => item.proName.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.only( bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                                backgroundColor:
                                    AppColors.appBackgroundGreyColor,
                                // Button color
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Rounded corners
                                ),
                                elevation: 0,
                                shadowColor: Colors.black45,
                              ),
                              onPressed: () => activeTabProductController
                                  .showSelectDurationBottomSheet(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() => Text(
                                        activeTabProductController
                                            .buttonText.value,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.appBlackColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Sofia Sans',
                                        ),
                                      )),
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
                              decoration: BoxDecoration(
                                color: AppColors.appBlackColor,
                                // Button background color
                                borderRadius: BorderRadius.circular(30),
                                // Rounded corners
                                border: Border.all(
                                  color: AppColors.appBlackColor,
                                  // Button border color
                                  width: 0, // Border thickness
                                ),
                              ),
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await activeTabProductController
                                      .downloadCSV();
                                }, // Button press callback
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  // Transparent to show container color
                                  shadowColor: Colors.transparent,
                                  // Remove button shadow
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10), // Button height padding
                                ),
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Sans',
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
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0),
                      child: Card(
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
                                  hintText: 'Search by name',
                                  filled: true,
                                  fillColor: AppColors.appNeutralColor5,
                                  prefixIcon: const Icon(Icons.search),
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
                              if (activeTabProductController
                                  .allProductDataList.isEmpty) {
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
                                  // Disable scrolling inside ListView
                                  itemCount: filteredItems.length,
                                  itemBuilder: (context, index) {
                                    return listItem(
                                        filteredItems, index, context);
                                  },
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Add extra space to avoid button overlap with content
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5.0),
            //   child: Center(
            //     child: CommonButton(
            //       buttonWidth: screenWidth * 0.9,
            //       icon: Icons.add,
            //       buttonName: "Add Product",
            //       onPressed: () {
            //         Get.to(AllProcductScreen());
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }
}

Widget listItem(
    List<ResAllFilterProductData> allProductDataList, int index, context) {
  final product = allProductDataList[index];
  final productName = product.proName;
  final productId = product.proId;
  final createdDate = product.createdOn;
  final productPrice = product.price;
  final productValue = product.priceValue;
  final productImage = product.image;
  final productstatus = product.isDeleted;
  DateTime dateTime = DateTime.parse(createdDate).toLocal();
  String formattedTime = DateFormat.jm().format(dateTime);
  String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

  return InkWell(
      onTap: productstatus
          ? null
          : () async {
              Get.to(ProductDetailsScreen(
                id: product.sId,
              ));
            },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Opacity(
        opacity: productstatus ? 0.5 : 1.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.network(
                          '${ImageAssets.imageUrl}/$productImage',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(ImageAssets.productImage);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.appBlackColor,
                                fontSize: 14,
                                fontFamily: 'Sofia Sans',
                              ),
                            ),
                            // Text(
                            //   "Name :$productName",
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.w500,
                            //     color: AppColors.appGreyColor,
                            //     fontSize: 14,
                            //     fontFamily: 'Sofia Sans',
                            //   ),
                            // ),
                            Text(
                              "ID :$productId",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.appGreyColor,
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
                              "\$$productPrice",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.appBlackColor,
                                fontSize: 12,
                                fontFamily: 'Sofia Sans',
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
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
      ));
}
