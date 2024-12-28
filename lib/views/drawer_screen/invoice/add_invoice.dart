import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/invoice_controller/add_invoice_controller.dart';
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

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final addInvoiceController = Get.find<AddInvoiceController>();
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
    addInvoiceController.filteredCustomers = addInvoiceController.customerList;
  }

  void callMethods() async {
    await addInvoiceController.getCustomerList(CommonVariable.businessId.value);
    await addInvoiceController.getProductList(CommonVariable.businessId.value);
    addInvoiceController.paymentDueController.value = TextEditingController(text: "01");
  }

  void filterSearchResults(String query) {
    setState(() {
      addInvoiceController.filteredCustomers = addInvoiceController.customerList
          .where((customer) => customer.info.custName
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterProductSearchResults(String query) {
    setState(() {
      addInvoiceController.filteredProduct = addInvoiceController.productList
          .where((product) =>
              product.proName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void selectCustomer(String name, int index,String id) {
    setState(() {
      addInvoiceController.selectedCustomer = name;
      addInvoiceController.selectedCount = index;
      addInvoiceController.isDropdownOpen = false;
      addInvoiceController.searchController.clear();
      addInvoiceController.customerId = id;

    });
  }

  void selectProduct(String productName, RxInt index,String proId) {
    var selectedProduct = addInvoiceController.filteredProduct[index.value];
    var selectedPrice = selectedProduct.price;
    addInvoiceController.selectedProduct = productName;
    addInvoiceController.productPricingTextController.value.text =
        selectedPrice.toString();
    addInvoiceController.isProductDropdownOpen.value = false;
    addInvoiceController.productId = proId;
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double quantity = double.tryParse(
            addInvoiceController.productQuantityTextController.value.text) ??
        0.0;
    double price = double.tryParse(
            addInvoiceController.productPricingTextController.value.text) ??
        0.0;
    addInvoiceController.productTotalAmount.value = quantity * price;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          "Add Invoice",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Customers List',
                                    style: TextStyle(
                                      fontFamily: 'Sofia Sans',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'CustomerList ',
                                      style: TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      children: [
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
                                          addInvoiceController.isDropdownOpen =
                                              !addInvoiceController
                                                  .isDropdownOpen;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 16.0,
                                            left: 16.0,
                                            top: 12.0,
                                            bottom: 12.0),
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
                                                addInvoiceController
                                                    .selectedCustomer,
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            Icon(addInvoiceController
                                                    .isDropdownOpen
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (addInvoiceController.isDropdownOpen)
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.appNeutralColor5,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0),
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
                                                            addInvoiceController
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
                                                            const InputDecoration(
                                                          isDense: true,
                                                          // Helps align the content within the fixed height
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                            vertical: 8.0,
                                                            // Fine-tune vertical padding for alignment
                                                            horizontal:
                                                                12.0, // Space for horizontal padding
                                                          ),
                                                          hintText:
                                                              'Search customers',
                                                          hintStyle: TextStyle(
                                                            fontFamily:
                                                                'Sofia Sans',
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                          prefixIcon: Icon(
                                                              Icons.search,
                                                              color:
                                                                  Colors.grey),
                                                          border:
                                                              InputBorder.none,
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
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        Get.to(
                                                            const AddCustomerForm());
                                                      },
                                                      icon: const Icon(
                                                        Icons.add_circle,
                                                        size: 16,
                                                      ),
                                                      label: const Text(
                                                        "Create",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Sofia Sans',
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
                                                              BorderRadius.circular(
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
                                                  children: addInvoiceController
                                                      .filteredCustomers
                                                      .asMap()
                                                      .entries
                                                      .map((entry) {
                                                    int index = entry.key;
                                                    var customer = entry.value;
                                                    return GestureDetector(
                                                      onTap: () => {
                                                        selectCustomer(
                                                            customer
                                                                .info.custName,
                                                            index,customer.sId),
                                                        customerDetailViewController
                                                            .getSingleData(customer.sId),
                                                        addInvoiceController
                                                            .isVisibilityAccount
                                                            .value = true
                                                      },
                                                      child: CustomerTile(
                                                        name: customer
                                                            .info.custName,
                                                        email:
                                                            customer.info.email,
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Check number ',
                                      style: TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      children: [
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
                                  controller: addInvoiceController
                                      .checkNumberTextController.value,
                                  focusNode:
                                  addInvoiceController.checkNoFocusNode,
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
                                        addInvoiceController.checkNoValid = false.obs;
                                      } else if (regExp.hasMatch(value)) {
                                        addInvoiceController.checkNoValid = true.obs;
                                        addInvoiceController.checkNoErrorMessage = "check No Must be 4 digit";
                                      } else {
                                        addInvoiceController.checkNoValid = false.obs;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                    contentPadding: const EdgeInsets.only(right: 16,left: 16),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: addInvoiceController.checkNoValid.value
                                            ? AppColors.appNeutralColor5
                                            : AppColors.appRedColor,
                                        width: 1, // Thickness for the underline
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.appNeutralColor5,
                                        // Default color for enabled state
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.appRedColor,
                                        // Error border for invalid input
                                        width: 1,
                                      ),
                                    ),
                                    errorText: addInvoiceController.checkNoValid.value
                                        ? null
                                        : 'CheckNo is required',
                                    // Error message when invalid
                                    hintText: "Enter CheckNo",
                                    filled: true,
                                    fillColor: AppColors.appNeutralColor5,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'CheckNo is required';
                                    }
                                    return null;
                                  },

                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Memo ',
                                      style: TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      children: [
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
                                  controller: addInvoiceController
                                      .memoTextController.value,
                                  focusNode: addInvoiceController.memoFocusNode,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[a-zA-Z0-9\s]*$')),
                                  ],
                                  onChanged: (value) {
                                    String pattern = r'^[a-zA-Z0-9\s]*$';
                                    RegExp regExp = RegExp(pattern);
                                    setState(() {
                                      if (value.isEmpty) {
                                        addInvoiceController.memoValid = false.obs;
                                      } else if (regExp.hasMatch(value)) {
                                        addInvoiceController.memoValid = true.obs;
                                      } else {
                                        addInvoiceController.memoValid = false.obs;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(color: AppColors.appBlueColor),
                                    contentPadding: const EdgeInsets.only(right: 16,left: 16),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: addInvoiceController.memoValid.value
                                            ? AppColors.appNeutralColor5
                                            : AppColors.appRedColor,
                                        width: 1, // Thickness for the underline
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.appNeutralColor5,
                                        // Default color for enabled state
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.appRedColor,
                                        // Error border for invalid input
                                        width: 1,
                                      ),
                                    ),
                                    errorText: addInvoiceController.memoValid.value
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
                    visible: addInvoiceController.isVisibilityAccount.value,
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
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Select Account',
                                    style: TextStyle(
                                      fontFamily: 'Sofia Sans',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                    return  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: (customerDetailViewController.allBankList.isNotEmpty &&
                                          addInvoiceController.selectedCustomer != "Select Customer")
                                          ? customerDetailViewController.allBankList.length
                                          : 0,
                                      itemBuilder: (context, index) {
                                        return accountListItem(customerDetailViewController.allBankList,index,context);
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
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    // Optional: Adds padding around the frame
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
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: GestureDetector(
                              onTap: (){
                                itemParticularPopup(context);
                                setState(() {
                                  addInvoiceController.productQuantityTextController.value = TextEditingController(text: "1");
                                  addInvoiceController.isDropdownOpen = false;
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.add_circle,
                                      color: Colors.blue, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Add Item',
                                    style: TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        color: Colors.blue,
                                        fontSize: 14,
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
                                addInvoiceController.addProductList.length,
                            itemBuilder: (context, index) {
                              return ProductListItem(
                                quantity: addInvoiceController
                                    .addProductList[index].qantity,
                                price: addInvoiceController
                                    .addProductList[index].price,
                                productName: addInvoiceController
                                    .addProductList[index].productName,
                                totalPrice: addInvoiceController
                                    .addProductList[index].totalPrice,
                              );
                            },
                            physics: const ScrollPhysics(),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Invoice Mode',
                              style: TextStyle(
                                fontFamily: 'Sofia Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Payment due in',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Sans',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 30,
                                  height: 20,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: addInvoiceController
                                        .paymentDueController.value,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Sofia Sans',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'days',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Sans',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoice is sent after due days.',
                              style: TextStyle(
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Obx(() {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 30,
                                    child: Radio<int>(
                                      value: 1,
                                      groupValue: addInvoiceController
                                          .selectedInvoiceMode.value,
                                      onChanged: (value) {
                                        addInvoiceController
                                            .selectedInvoiceMode.value = value!;
                                      },
                                      activeColor: AppColors.appBlueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  const Text(
                                    'Send invoice for pre-approved transaction.',
                                    style: TextStyle(
                                      fontFamily: 'Sofia Sans',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            Obx(() {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 30,
                                    child: Radio<int>(
                                        value: 2,
                                        groupValue: addInvoiceController
                                            .selectedInvoiceMode.value,
                                        onChanged: (value) {
                                          addInvoiceController
                                              .selectedInvoiceMode
                                              .value = value!;
                                        },
                                        activeColor: AppColors.appBlueColor),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Send invoice for authorization (Include a payment page to capture user details and signature).',
                                      style: TextStyle(
                                        fontFamily: 'Sofia Sans',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
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
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontFamily: 'Sofia Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                // Icon(Icons.add_circle, color: Colors.blue),
                                const SizedBox(width: 8),
                                Obx(() => Text(
                                      "\$${addInvoiceController.totalAmount.value}",
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Add space from the bottom
              child: CommonButton(
                buttonWidth: screenWidth * 0.9, // Adjust button width
                buttonName: "Submit",
                onPressed: () {
                  if (addInvoiceController.selectedCustomer != "Select Customer") {
                    if (addInvoiceController.customerValidation(context)) {
                      addInvoiceController.productDetailList();
                      if (addInvoiceController.finalProductList.isNotEmpty) {
                        GeneralMethods.loadingDialog(context);
                        addInvoiceController.insertInvoicePaymentData();
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
    );
  }

  Widget accountListItem(List<BankId> allBusinessList, int index, context) {
    bool isSelected = allBusinessList[index].primary ;
    addInvoiceController.bankId = allBusinessList[index].sId;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          addInvoiceController.bankId = allBusinessList[selectedIndex].sId;
          for (int i = 0; i < allBusinessList.length; i++) {
            allBusinessList[i].primary = i == selectedIndex;  // Update primary flag for selected account
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none, // Allows overflow
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height *
                          0.02, // Responsive bottom padding
                      left: MediaQuery.of(context).size.width *
                          0.05, // Responsive left padding
                      right: MediaQuery.of(context).size.width *
                          0.05, // Responsive right padding
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appBlueLightColor
                          : AppColors.appNeutralColor5,
                      borderRadius: BorderRadius.circular(30.0),
                      border: isSelected
                          ? Border.all(color: AppColors.appBlueColor, width: 2)
                          : Border.all(
                              color: AppColors.appNeutralColor5, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.02), // Responsive height
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Flexible(
                              child: Text(
                                'Account Number  :  ',
                                style: TextStyle(
                                  color: AppColors.appGreyColor,
                                  fontSize: 16,
                                  fontFamily: 'Sofia Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
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
                      top: -13,
                      left: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: const BoxDecoration(
                          color: AppColors.appBlueColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
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

  void itemParticularPopup(BuildContext context) {
    addInvoiceController.filteredProduct
        .assignAll(addInvoiceController.productList);
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: AppColors.appGreyColor,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                            color: AppColors.appGreyColor, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Item Particulars",
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlackColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: const TextSpan(
                      text: 'Find or Add Product ',
                      style: TextStyle(
                        fontFamily: 'Sofia Sans',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appBlackColor,
                      ),
                      children: [
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
                            addInvoiceController.isProductDropdownOpen.value =
                                !addInvoiceController
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
                                  Text(addInvoiceController.selectedProduct,
                                      style: const TextStyle(fontSize: 16)),
                                  Icon(addInvoiceController
                                          .isProductDropdownOpen.value
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down),
                                ],
                              ),
                            )),
                      ),
                      Obx(() {
                        if (addInvoiceController.isProductDropdownOpen.value) {
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
                                            controller: addInvoiceController
                                                .productSearchController,
                                            onChanged: (value) =>
                                                filterProductSearchResults(
                                                    value),
                                            maxLines: 1,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0,
                                              ),
                                              hintText: 'Search product',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Sofia Sans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              prefixIcon: Icon(Icons.search,
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
                                          label: const Text(
                                            "Create",
                                            style: TextStyle(
                                              fontFamily: 'Sofia Sans',
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
                                      children: addInvoiceController
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
                                              proName.value, index,proId.value),
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
                          text: const TextSpan(
                            text: 'Quantity ',
                            style: TextStyle(
                              fontFamily: 'Sofia Sans',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appBlackColor,
                            ),
                            children: [
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
                          text: const TextSpan(
                            text: 'Pricing ',
                            style: TextStyle(
                              fontFamily: 'Sofia Sans',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appBlackColor,
                            ),
                            children: [
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
                          controller: addInvoiceController
                              .productQuantityTextController.value,
                          labelText: 'Quantity',
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            calculateTotalAmount();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonTextField(
                          hintText: 'Pricing',
                          controller: addInvoiceController
                              .productPricingTextController.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                            "\$${addInvoiceController.productTotalAmount.value.toStringAsFixed(2)}",
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
                          if(addInvoiceController.selectedProduct=="Select Product"){
                            MyToast.toast("Please Select product");
                          }else if (addInvoiceController.productQuantityTextController.value.text.isEmpty){
                            MyToast.toast("Please Select Quantity");
                          }else if (addInvoiceController.productPricingTextController.value.text.isEmpty){
                            MyToast.toast("Please Select Price");
                          }else{
                            addInvoiceController.addProductDetail();
                            addInvoiceController.calculateTotalAmount();
                            addInvoiceController.clearAllProduct();
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

void CreateCustomerPopup(BuildContext context) {
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

  const ProductListItem(
      {super.key,
      required this.quantity,
      required this.price,
      required this.productName,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            children: [
              Text(
                productName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.Sofiafontfamily),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Quantity :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appGreyColor,
                        fontFamily: 'Sofia Sans'),
                  ),
                  Text(
                    '\$$quantity',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                  const Text(
                    'Price(USD) :',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.appGreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sofia Sans'),
                  ),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.appBlackColor,
                      fontFamily: 'Sofia Sans',
                      fontWeight: FontWeight.w500,
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
                  const Text(
                    'TotalPrice :',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.appGreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sofia Sans'),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sofia Sans'),
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
