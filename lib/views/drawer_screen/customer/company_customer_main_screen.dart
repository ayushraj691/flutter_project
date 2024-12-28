import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/customer/active_customer.dart';
import 'package:paycron/views/drawer_screen/customer/all_tab_customer.dart';
import 'package:paycron/views/drawer_screen/customer/createCustomerForm.dart';
import 'package:paycron/views/drawer_screen/customer/inActive_customer.dart';
import 'package:paycron/views/widgets/common_button.dart';

class DrawerCustomerDetailScreen extends StatefulWidget {
  const DrawerCustomerDetailScreen({super.key});

  @override
  State<DrawerCustomerDetailScreen> createState() =>
      _DrawerCustomerDetailScreenState();
}

class _DrawerCustomerDetailScreenState
    extends State<DrawerCustomerDetailScreen> {
  var addCustomerController = Get.find<AddCustomerController>();

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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0, // Removes extra space between arrow and title
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
              onTap: () => {
                Get.to(const BusinessProfileScreen())
              },
              child: CircleAvatar(
                radius: screenHeight / 45,
                backgroundImage: AssetImage(ImageAssets.profile),
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Image.asset(ImageAssets.closeDrawer), // Your drawer icon
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, top: 20, bottom: 10),
                child: Text(
                  "Customers",
                  style: TextStyle(
                    fontFamily: 'Sofia Sans',
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: AppColors.appBlueColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.appBlueColor,
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Active'),
                      Tab(text: 'Inactive'),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight *0.72,
                    child: const TabBarView(
                      children: [
                        AllTab(),
                        ActiveTab(),
                        InActiveTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom : 12.0,
        ),
        child: CommonButton(
          buttonWidth: screenWidth * 0.9,
          icon: Icons.add,
          buttonName: "Add Customer",
          onPressed: () {
            Get.to(const AddCustomerForm());
            addCustomerController.accountDetailsList.clear();
            addCustomerController.clearAllAccount();
            addCustomerController.clearAllCustomer();
          },
        ),
      ),
    );
  }
}
