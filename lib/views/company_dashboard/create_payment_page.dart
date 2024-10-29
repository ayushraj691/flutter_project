
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResCustomerListModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/views/company_dashboard/add_customer_popup.dart';
import 'package:paycron/views/drawer_screen/customer/createCustomerForm.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class CreatePaymentPage extends StatefulWidget {
  const CreatePaymentPage({super.key});

  @override
  State<CreatePaymentPage> createState() => _CreatePaymentPageState();
}

class _CreatePaymentPageState extends State<CreatePaymentPage> {
  final createPaymentController = Get.find<CreatePaymentController>();
  int selectedIndex = 0;  // State variable to track the currently selected index  final int currentStep; // Keep track of the current step
  final int currentStep =0;

  List<String> allBusinessList = [
    "Business 1",
    "Business 2",
    "Business 3",
    "Business 4"
  ];


  TextEditingController searchController = TextEditingController();
  List<ResCustomerList> filteredCustomers =  <ResCustomerList>[].obs;
  bool isDropdownOpen = false;
  String selectedCustomer = "Select Customer";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      callMethods();
    });
    filteredCustomers = createPaymentController.customerList;
  }

  void callMethods() async{
    await createPaymentController.getCustomerList(CommonVariable.businessId.value);
  }


  void filterSearchResults(String query) {
    setState(() {
      filteredCustomers = createPaymentController.customerList
          .where((customer) =>
          customer.info.custName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void selectCustomer(String name) {
    setState(() {
      selectedCustomer = name; // Update selected customer name
      isDropdownOpen = false; // Close the dropdown menu
      searchController.clear(); // Clear the search box
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Action for back arrow
          },
        ),
        titleSpacing: 0, // Removes extra space between arrow and title
        title: const Text(
          "Create Payment",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                 width: screenWidth,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                          SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
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
                          SizedBox(
                            height: 4.0,
                          ),
                          // CommonTextField(
                          //     hintText: 'Customer List',
                          //     controller: createPaymentController
                          //         .customerListTextController.value,
                          //     labelText: 'Customer List'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Dropdown button to toggle the menu
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDropdownOpen = !isDropdownOpen;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.appNeutralColor5,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(selectedCustomer, style: TextStyle(fontSize: 16)),
                                      Icon(isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                              // Dropdown Menu
                              if (isDropdownOpen)
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.appNeutralColor5,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 300, // Fixed height for the dropdown container
                                  child: Column(
                                    children: [
                                      // Search box with a side "Create" button
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.2), // Shadow color
                                                      blurRadius: 2, // Blur radius
                                                      offset: Offset(0, 1), // Changes position of shadow (x, y)
                                                    ),
                                                  ],
                                                  color: AppColors.appWhiteColor,
                                                  borderRadius: BorderRadius.circular(30), // Circular shape
                                                  border: Border.all(color: AppColors.appWhiteColor),
                                                ),
                                                child: TextField(
                                                  controller: searchController,
                                                  onChanged: (value) => filterSearchResults(value),
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 15.0, horizontal: 12.0), // Padding inside the TextField
                                                    hintText: 'Search customers', // Placeholder text
                                                    hintStyle: TextStyle(color: Colors.grey.shade600), // Hint text color
                                                    prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30), // Circular shape
                                              ),
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  Get.to(AddCustomerForm());
                                                },
                                                icon: Icon(Icons.add_circle),
                                                label: Text("Create"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.appBlueColor,
                                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30), // Circular shape
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Scrollable List of filtered items
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: filteredCustomers.map((customer) {
                                              return GestureDetector(
                                                onTap: () => selectCustomer(customer.info.custName), // Select customer
                                                child: CustomerTile(
                                                  name: customer.info.custName,
                                                  email: customer.info.email,
                                                  phone: customer.info.mobile,
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
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
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
                            controller: createPaymentController
                                .checkNumberTextController.value,
                            labelText: "Check number",
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
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
                            controller: createPaymentController
                                .memoTextController.value,
                            labelText: "Enter Memo",
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
              visible: true,
              child: Container(
                width: screenWidth,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                          SizedBox(height: 20,),
                          // Obx(() => allBusinessList.isEmpty
                          //     ? Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: const Center(
                          //             child: CircularProgressIndicator()),
                          //       )
                          //     : )
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return accountListItem(allBusinessList,index,context);                                },
                            physics: const ScrollPhysics(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              // Optional: Adds padding around the frame
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Item Particulars',
                      style: TextStyle(
                        fontFamily: 'Sofia Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ), // Customizes text appearance
                    ),
                    GestureDetector(
                      onTap: () {
                        ItemParticularPopup(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the button
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_circle, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Add Item',
                              style: TextStyle(
                                  fontFamily: 'Sofia Sans',
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
            Container(
              width: screenWidth,
              child: Column(
                children: [
                  // Obx(() => allBusinessList.isEmpty
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: const Center(
                  //             child: CircularProgressIndicator()),
                  //       )
                  //     : )
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ProductListItem(quantity: 2, price: 20.0,);                                },
                    physics: const ScrollPhysics(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                    child: Center(
                      child: CommonButton(
                        buttonWidth: screenWidth * 0.9,
                        buttonName: "Submit",
                        onPressed: () {
                          Get.to(CreatePaymentPage());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget accountListItem(List<String> allBusinessList, int index, context) {
    bool isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02), // Responsive padding
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none, // Allows overflow
                children: [
                  // Main container for account information
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02, // Responsive bottom padding
                      left: MediaQuery.of(context).size.width * 0.05, // Responsive left padding
                      right: MediaQuery.of(context).size.width * 0.05, // Responsive right padding
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.appWhiteColor : AppColors.appNeutralColor5,
                      borderRadius: BorderRadius.circular(30.0),
                      border: isSelected
                          ? Border.all(color: AppColors.appBlueColor, width: 2)
                          : Border.all(color: AppColors.appNeutralColor5, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Responsive height
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Using Flexible to avoid overflow
                            Flexible(
                              child: Text(
                                'Account Number  :  ',
                                style: TextStyle(
                                  color: AppColors.appGreyColor,
                                  fontSize: 16,
                                  fontFamily: 'Sofia Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'xxxxxxxxxxxx6789',
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontSize: 16,
                                  fontFamily: 'Sofia Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Show the "Primary Account" label only for the selected item
                  if (isSelected)
                    Positioned(
                      top: -13,
                      left: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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

  void ItemParticularPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to adjust its size dynamically
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // Adjusts the padding when the keyboard appears
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60,
                     padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: AppColors.appGreyColor,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: AppColors.appGreyColor, width: 1.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Item Particulars",
                  style: TextStyle(
                    fontFamily: 'Sofia Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                  ),
                ),
                SizedBox(height: 15),
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
                CommonTextField(
                  hintText: 'Find or Add Product',
                  controller: createPaymentController.customerListTextController.value,
                  labelText: 'Find or Add Product',
                ),
                SizedBox(height: 15),
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
                    SizedBox(width: 10),
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
                        controller: createPaymentController.customerListTextController.value,
                        labelText: 'Quantity',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Pricing',
                        controller: createPaymentController.customerListTextController.value,
                        labelText: 'Pricing',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(thickness: 1.0),
                SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$ 5367",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appBlackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
  final int quantity;
  final double price;

  ProductListItem({
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * price;
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'productName',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                    fontFamily: 'Sofia Sans'
                ),
              ),
              Icon(Icons.more_vert),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min, // Minimize the column height
                children: [
                  const Text(
                    'Quantity :',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appGreyColor,
                        fontFamily: 'Sofia Sans'
                    ),
                  ),
                  Text(
                    '\$$quantity',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appBlackColor,
                      fontFamily: 'Sofia Sans'
                    ),
                    textAlign: TextAlign.center, // Center align the price text
                  ),
                ],
              ),
              Container(
                height: 40, // Adjust height as needed
                child: const VerticalDivider(
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
                      fontFamily: 'Sofia Sans'
                    ),
                  ),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.appBlackColor,
                        fontFamily: 'Sofia Sans',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center, // Center align the price text
                  ),
                ],
              ),
              Container(
                height: 40, // Adjust height as needed
                child: const VerticalDivider(
                  thickness: 2,
                  color: AppColors.appBackgroundGreyColor,
                  width: 20, // Width is the total space the divider will take
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min, // Minimize the column height
                children: [
                  const Text(
                    'TotalPrice :',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.appGreyColor,
                        fontWeight: FontWeight.w400,
                      fontFamily: 'Sofia Sans'
                    ),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sofia Sans'
                    ),
                    textAlign: TextAlign.center, // Center align the price text
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
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(email, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(phone, style: TextStyle(fontSize: 12, color: Colors.grey)),
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
