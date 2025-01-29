import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResSingleCustomerModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/drawer_screen/customer/createCustomerForm.dart';
import 'package:paycron/views/drawer_screen/product/add_product_screen.dart';
import 'package:paycron/views/single_company_dashboard/add_customer_popup.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import '../../utils/image_assets.dart';
import '../../utils/style.dart';

class CreatePaymentPage extends StatefulWidget {
  const CreatePaymentPage({super.key});

  @override
  State<CreatePaymentPage> createState() => _CreatePaymentPageState();
}

class _CreatePaymentPageState extends State<CreatePaymentPage> {
  final createPaymentController = Get.find<CreatePaymentController>();
  var variableController = Get.find<VariableController>();
  final customerDetailViewController = Get.find<CustomerDetailViewController>();

  int selectedIndex = 0;
  final int currentStep = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      callMethods();
    });
    createPaymentController.filteredCustomers =
        createPaymentController.customerList;
  }

  void callMethods() async {
    await createPaymentController
        .getCustomerList(CommonVariable.businessId.value);
    await createPaymentController
        .getProductList(CommonVariable.businessId.value);
  }

  void filterSearchResults(String query) {
    setState(() {
      createPaymentController.filteredCustomers = createPaymentController
          .customerList
          .where((customer) => customer.info.custName
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterProductSearchResults(String query) {
    setState(() {
      createPaymentController.filteredProduct = createPaymentController
          .productList
          .where((product) =>
              product.proName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void selectCustomer(String name, int index, var id) {
    setState(() {
      createPaymentController.selectedCustomer = name;
      createPaymentController.selectedCount = index;
      createPaymentController.isDropdownOpen = false;
      createPaymentController.searchController.clear();
      createPaymentController.customerId = id;
    });
  }

  void selectProduct(String productName, RxInt index, String proId) {
    var selectedProduct = createPaymentController.filteredProduct[index.value];
    var selectedPrice = selectedProduct.price;
    createPaymentController.selectedProduct = productName;
    createPaymentController.productPricingTextController.value.text =
        selectedPrice.toString();
    createPaymentController.isProductDropdownOpen.value = false;
    createPaymentController.productId = proId;
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double quantity = double.tryParse(
            createPaymentController.productQuantityTextController.value.text) ??
        0.0;
    double price = double.tryParse(
            createPaymentController.productPricingTextController.value.text) ??
        0.0;
    createPaymentController.productTotalAmount.value = quantity * price;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          "Create Payment",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: Constants.Sofiafontfamily,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
                      child: SizedBox(
                        width: screenWidth,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Customers List',
                                      style: TextStyle(
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.24,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'CustomerList ',
                                        style: TextStyle(
                                          fontFamily: Constants.Sofiafontfamily,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            createPaymentController
                                                    .isDropdownOpen =
                                                !createPaymentController
                                                    .isDropdownOpen;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 16.0,
                                              left: 16.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.appNeutralColor5,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  createPaymentController
                                                      .selectedCustomer,
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                              Icon(createPaymentController
                                                      .isDropdownOpen
                                                  ? Icons.arrow_drop_up
                                                  : Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (createPaymentController
                                          .isDropdownOpen)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.appNeutralColor5,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 300,
                                          // Fixed height for the dropdown container
                                          child: Column(
                                            children: [
                                              // Search box with a side "Create" button
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 36,
                                                        // Fixed height for the container
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0),
                                                              // Shadow color
                                                              blurRadius: 0,
                                                              // Blur radius
                                                              offset: const Offset(
                                                                  0,
                                                                  0), // Position of shadow (x, y)
                                                            ),
                                                          ],
                                                          color: AppColors
                                                              .appWhiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          // Circular shape
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .appWhiteColor),
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              createPaymentController
                                                                  .searchController,
                                                          onChanged: (value) =>
                                                              filterSearchResults(
                                                                  value),
                                                          maxLines: 1,
                                                          // Ensures single-line input with horizontal scrolling
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          // Centers text vertically within TextField
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            // Helps align the content within the fixed height
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 8.0,
                                                              // Fine-tune vertical padding for alignment
                                                              horizontal:
                                                                  12.0, // Space for horizontal padding
                                                            ),
                                                            hintText:
                                                                'Search customers',
                                                            hintStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  Constants.Sofiafontfamily,
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            prefixIcon: const Icon(
                                                                Icons.search,
                                                                color: Colors
                                                                    .grey),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Container(
                                                      height: 36,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // Circular shape
                                                      ),
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          Get.to(
                                                              const AddCustomerForm());
                                                        },
                                                        icon: const Icon(
                                                          Icons.add_circle,
                                                          size: 16,
                                                        ),
                                                        label: Text(
                                                          "Create",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                Constants.Sofiafontfamily,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .appBlueColor,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12.5,
                                                                  vertical: 7),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30), // Circular shape
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children:
                                                        createPaymentController
                                                            .filteredCustomers
                                                            .asMap()
                                                            .entries
                                                            .map((entry) {
                                                      int index = entry.key;
                                                      var customer =
                                                          entry.value;
                                                      return GestureDetector(
                                                        onTap: () => {
                                                          selectCustomer(
                                                              customer.info
                                                                  .custName,
                                                              index,
                                                              customer.sId),
                                                          customerDetailViewController
                                                              .getSingleData(
                                                                  customer.sId),
                                                          createPaymentController
                                                              .isVisibilityAccount
                                                              .value = true,
                                                        },
                                                        child: CustomerTile(
                                                          name: customer
                                                              .info.custName,
                                                          email: customer
                                                              .info.email,
                                                          phone: customer
                                                              .info.mobile,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 12.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.24,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Check number ',
                                        style: TextStyle(
                                          fontFamily: Constants.Sofiafontfamily,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 4.0,
                                  ),
                                  CommonTextField(
                                    hintText: "Check number",
                                    controller: createPaymentController
                                        .checkNumberTextController.value,
                                    focusNode: createPaymentController
                                        .checkNoFocusNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    onChanged: (value) {
                                      String pattern = r'^\d{4}$';
                                      RegExp regExp = RegExp(pattern);
                                      setState(() {
                                        if (value.isEmpty) {
                                          createPaymentController.checkNoValid =
                                              false.obs;
                                        } else if (regExp.hasMatch(value)) {
                                          createPaymentController.checkNoValid =
                                              true.obs;
                                          createPaymentController
                                                  .checkNoErrorMessage =
                                              "check No Must be 4 digit";
                                        } else {
                                          createPaymentController.checkNoValid =
                                              false.obs;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelStyle: const TextStyle(
                                          color: AppColors.appBlueColor),
                                      isDense: true,
                                      contentPadding: const EdgeInsets.only(
                                          right: 16, left: 16,top: 12,bottom: 12),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: createPaymentController
                                                  .checkNoValid.value
                                              ? AppColors.appNeutralColor5
                                              : AppColors.appRedColor,
                                          width:
                                              1, // Thickness for the underline
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: AppColors.appNeutralColor5,
                                          // Default color for enabled state
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0)
                                      ),
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.appRedColor,
                                          // Error border for invalid input
                                          width: 1,
                                        ),
                                      ),
                                      errorText: createPaymentController
                                              .checkNoValid.value
                                          ? null
                                          : (createPaymentController
                                          .checkNumberTextController
                                          .value
                                          .text
                                          .isEmpty
                                          ? 'check number is required'
                                          : 'check No Must be 4 digit'),
                                      hintText: "Enter CheckNo",
                                      filled: true,
                                      fillColor: AppColors.appNeutralColor5,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'CheckNo is required';
                                      }else if (value.trim().length < 4) {
                                        return 'check No Must be 4 digit';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 12.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.24,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Memo ',
                                        style: TextStyle(
                                          fontFamily: Constants.Sofiafontfamily,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              // Set a different color for the asterisk
                                              fontSize: 12.0,
                                              // Same or different size
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 4.0,
                                  ),
                                  CommonTextField(
                                    hintText: "Enter Memo",
                                    controller: createPaymentController
                                        .memoTextController.value,
                                    focusNode:
                                        createPaymentController.memoFocusNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^[a-zA-Z0-9\s]*$')),
                                    ],
                                    onChanged: (value) {
                                      String pattern = r'^[a-zA-Z0-9\s]*$';
                                      RegExp regExp = RegExp(pattern);
                                      setState(() {
                                        if (value.isEmpty) {
                                          createPaymentController.memoValid =
                                              false.obs;
                                        } else if (regExp.hasMatch(value)) {
                                          createPaymentController.memoValid =
                                              true.obs;
                                        } else {
                                          createPaymentController.memoValid =
                                              false.obs;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: AppColors.appBlueColor),
                                      isDense: true,
                                      contentPadding: const EdgeInsets.only(
                                          right: 16, left: 16,top: 12,bottom: 12),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: createPaymentController
                                                  .memoValid.value
                                              ? AppColors.appNeutralColor5
                                              : AppColors.appRedColor,
                                          width:
                                              1, // Thickness for the underline
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: AppColors.appNeutralColor5,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0)
                                      ),
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.appRedColor,
                                          // Error border for invalid input
                                          width: 1,
                                        ),
                                      ),
                                      errorText: createPaymentController
                                              .memoValid.value
                                          ? null
                                          : 'Memo is required',
                                      // Error message when invalid
                                      hintText: "Enter Memo",
                                      filled: true,
                                      fillColor: AppColors.appNeutralColor5,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Memo is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 12.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: createPaymentController.isVisibilityAccount.value,
                      child: SizedBox(
                        width: screenWidth * 0.96,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Select Account',
                                      style: TextStyle(
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Obx(() {
                                    if (customerDetailViewController
                                        .allBankList.isEmpty) {
                                      return variableController.loading.value
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 50,
                                                width: 50,
                                                child: Lottie.asset(
                                                    "assets/lottie/half-circles.json"),
                                              ),
                                            )
                                          : NoDataFoundCard();
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: (customerDetailViewController
                                                    .allBankList.isNotEmpty &&
                                                createPaymentController
                                                        .selectedCustomer !=
                                                    "Select Customer")
                                            ? customerDetailViewController
                                                .allBankList.length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          return accountListItem(
                                              customerDetailViewController
                                                  .allBankList,
                                              index,
                                              context);
                                        },
                                        physics: const ScrollPhysics(),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0,top: 0.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item Particulars',
                              style: TextStyle(
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ), // Customizes text appearance
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 12.0),
                              child: InkWell(
                                onTap: () {
                                  itemParticularPopup(context);
                                  setState(() {
                                    createPaymentController
                                            .productQuantityTextController
                                            .value =
                                        TextEditingController(text: "1");
                                    createPaymentController.isDropdownOpen =
                                        false;
                                    createPaymentController
                                        .isProductDropdownOpen = false.obs;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.add_circle, color: Colors.blue),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Add Item',
                                      style: TextStyle(
                                          fontFamily: Constants.Sofiafontfamily,
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: Column(
                        children: [
                          Obx(() {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  createPaymentController.addProductList.length,
                              itemBuilder: (context, index) {
                                return ProductListItem(
                                  quantity: createPaymentController
                                      .addProductList[index].qantity,
                                  price: createPaymentController
                                      .addProductList[index].price,
                                  productName: createPaymentController
                                      .addProductList[index].productName,
                                  totalPrice: createPaymentController
                                      .addProductList[index].totalPrice, index: index,
                                );
                              },
                              physics: const ScrollPhysics(),
                            );
                            // }
                          }),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 26),
                      child: Divider(color: AppColors.appGreyColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Obx(() => Text(
                                        "\$${createPaymentController.totalAmount.value}",
                                        style: TextStyle(
                                            fontFamily:
                                                Constants.Sofiafontfamily,
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Center(
                child: CommonButton(
                  buttonWidth: screenWidth * 0.9,
                  buttonName: "Submit",
                  onPressed: () {
                    if (createPaymentController.selectedCustomer !=
                        "Select Customer") {
                      if (createPaymentController.customerValidation(context)) {
                        createPaymentController.productDetailList();
                        if (createPaymentController
                            .finalProductList.isNotEmpty) {
                          GeneralMethods.loadingDialog(context);
                          createPaymentController.insertCustomerPaymentData();
                          Get.back();
                          setState(() {
                          });
                        } else {
                          MyToast.toast('Add Item');
                        }
                      }
                    } else {
                      MyToast.toast("Customer is required");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    callMethods();
    createPaymentController.isProductDropdownOpen.value = false;
    createPaymentController.isDropdownOpen = false;
    setState(() {});
  }

  Widget accountListItem(List<BankId> allBusinessList, int index, context) {
    bool isSelected = index == selectedIndex;
    createPaymentController.bankId = allBusinessList[selectedIndex].sId;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          createPaymentController.bankId = allBusinessList[selectedIndex].sId;
          for (int i = 0; i < allBusinessList.length; i++) {
            allBusinessList[i].primary = i == selectedIndex;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height *
                          0.02,
                      left: MediaQuery.of(context).size.width *
                          0.04,
                      right: MediaQuery.of(context).size.width *
                          0.04,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appBlueLightColor
                          : AppColors.appNeutralColor5,
                      borderRadius: BorderRadius.circular(30.0),
                      border: isSelected
                          ? Border.all(color: AppColors.appBlueColor, width: 1)
                          : Border.all(
                              color: AppColors.appBackgroundGreyColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'Account Number ',
                                style: TextStyle(
                                  color: AppColors.appGreyColor,
                                  fontSize: 12,
                                  fontFamily: Constants.Sofiafontfamily,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow:
                                    TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              ':',
                              style: AppTextStyles.subtitleText,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Flexible(
                              child: Text(
                                GeneralMethods.maskAccountNumber(
                                    allBusinessList[index].accountNumber),
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontSize: 16,
                                  fontFamily: Constants.Sofiafontfamily,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: -10,
                      left: 30,
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
                            fontSize: 10,
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

  void itemParticularPopup(BuildContext context) {
    createPaymentController.filteredProduct
        .assignAll(createPaymentController.productList);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Rounded top-left corner
                  topRight: Radius.circular(20.0), // Rounded top-right corner
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Item Particulars",
                    style: TextStyle(
                      fontFamily: Constants.Sofiafontfamily,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: 'Find or Add Product ',
                      style: TextStyle(
                        fontFamily: Constants.Sofiafontfamily,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appBlackColor,
                      ),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            createPaymentController
                                    .isProductDropdownOpen.value =
                                !createPaymentController
                                    .isProductDropdownOpen.value;
                          });
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.only(
                                  right: 16.0,
                                  left: 16.0,
                                  top: 12.0,
                                  bottom: 12.0),
                              decoration: BoxDecoration(
                                color: AppColors.appNeutralColor5,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(createPaymentController.selectedProduct,
                                      style: const TextStyle(fontSize: 16)),
                                  Icon(createPaymentController
                                          .isProductDropdownOpen.value
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down),
                                ],
                              ),
                            )),
                      ),
                      Obx(() {
                        if (createPaymentController
                            .isProductDropdownOpen.value) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.appNeutralColor5,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 36,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(0),
                                                blurRadius: 0,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                            color: AppColors.appWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: AppColors.appWhiteColor),
                                          ),
                                          child: TextField(
                                            controller: createPaymentController
                                                .productSearchController,
                                            onChanged: (value) =>
                                                filterProductSearchResults(
                                                    value),
                                            maxLines: 1,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0,
                                              ),
                                              hintText: 'Search product',
                                              hintStyle: TextStyle(
                                                fontFamily: Constants.Sofiafontfamily,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              prefixIcon: const Icon(Icons.search,
                                                  color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Get.to(const AddProcductScreen());
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            size: 16,
                                          ),
                                          label: Text(
                                            "Create",
                                            style: TextStyle(
                                              fontFamily: Constants.Sofiafontfamily,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.appBlueColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.5, vertical: 7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: createPaymentController
                                          .filteredProduct
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        RxInt index = entry.key.obs;
                                        var product = entry.value;
                                        var proName = "".obs;
                                        var proId = "".obs;
                                        proName.value = product.proName;
                                        proId.value = product.sId;
                                        return GestureDetector(
                                          onTap: () => selectProduct(
                                              proName.value,
                                              index,
                                              proId.value),
                                          child: ProductTile(
                                            productName: proName.value,
                                            productId: proId.value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Quantity ',
                            style: TextStyle(
                              fontFamily: Constants.Sofiafontfamily,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appBlackColor,
                            ),
                            children: const [
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Pricing ',
                            style: TextStyle(
                              fontFamily: Constants.Sofiafontfamily,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appBlackColor,
                            ),
                            children: const [
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          hintText: 'Quantity',
                          controller: createPaymentController
                              .productQuantityTextController.value,
                          labelText: 'Quantity',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            calculateTotalAmount();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonTextField(
                          hintText: 'Pricing',
                          controller: createPaymentController
                              .productPricingTextController.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          labelText: 'Pricing',
                          onChanged: (value) {
                            calculateTotalAmount();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(thickness: 1.0),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.Sofiafontfamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() => Text(
                            "\$${createPaymentController.productTotalAmount.value.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: Constants.Sofiafontfamily,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appBlackColor,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (createPaymentController.selectedProduct ==
                              "Select Product") {
                            MyToast.toast("Please Select product");
                          } else if (createPaymentController
                              .productQuantityTextController
                              .value
                              .text
                              .isEmpty) {
                            MyToast.toast("Please Select Quantity");
                          } else if (createPaymentController
                              .productPricingTextController
                              .value
                              .text
                              .isEmpty) {
                            MyToast.toast("Please Select Price");
                          } else {
                            createPaymentController.addProductDetail();
                            createPaymentController.calculateTotalAmount();
                            createPaymentController.clearAllProduct();
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void createCustomerPopup(BuildContext context) {
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
        child: const CreateCustomerForm(),
      );
    },
  );
}

class ProductListItem extends StatelessWidget {
  final String productName;
  final String quantity;
  final String price;
  final String totalPrice;
  final int index;

  const ProductListItem(
      {super.key,
      required this.quantity,
      required this.price,
      required this.productName,
      required this.totalPrice, required this.index});

  @override
  Widget build(BuildContext context) {
    final createPaymentController = Get.find<CreatePaymentController>();
    return Container(
      padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(  // Ensures text takes available space without overflow
                child: Text(
                  productName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                  overflow: TextOverflow.ellipsis,  // Handle long text with ellipsis
                  maxLines: 1,  // Ensure it fits in a single line
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.transparent,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (value) {
                     if (value == 'remove') {
                       createPaymentController.removeAccountDetail(index);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'remove',
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage( ImageAssets.removeImage),
                              width: 16,
                              height: 16,
                              color: AppColors.appBlackColor,
                            ),
                            const SizedBox(width: 4),
                            const Text('Remove'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Quantity :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appGreyColor,
                        fontFamily: Constants.Sofiafontfamily),
                  ),
                  Text(
                    '\$$quantity',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                        fontFamily: Constants.Sofiafontfamily),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 40, // Adjust height as needed
                child: VerticalDivider(
                  thickness: 2,
                  color: AppColors.appBackgroundGreyColor,
                  width: 20, // Width is the total space the divider will take
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min, // Minimize the column height
                children: [
                  Text(
                    'Price(USD) :',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.appGreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.Sofiafontfamily),
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.appBlackColor,
                      fontFamily: Constants.Sofiafontfamily,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
                child: VerticalDivider(
                  thickness: 2,
                  color: AppColors.appBackgroundGreyColor,
                  width: 20,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TotalPrice :',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.appGreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.Sofiafontfamily),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.Sofiafontfamily),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomerTile extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const CustomerTile({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.email, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(email,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(phone,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String productName;
  final String productId;

  const ProductTile({
    super.key,
    required this.productName,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(productId,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
