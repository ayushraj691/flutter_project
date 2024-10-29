import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/drawer_screen/product/Inactive_screen_product.dart';
import 'package:paycron/views/drawer_screen/product/active_screen_product.dart';
import 'package:paycron/views/drawer_screen/product/add_product_screen.dart';
import 'package:paycron/views/drawer_screen/product/all_screen_product.dart';
import 'package:paycron/views/widgets/common_button.dart';

class CompanyDetailProductScreen extends StatefulWidget {

  const CompanyDetailProductScreen({super.key});

  @override
  State<CompanyDetailProductScreen> createState() => _CompanyDetailProductScreenState();
}

class _CompanyDetailProductScreenState extends State<CompanyDetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Obx(() => Text(
          CommonVariable.businessName.value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: screenHeight / 45,
              backgroundImage: AssetImage(ImageAssets.profile),
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
      endDrawer: AppDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, top: 20, bottom: 10),
                child: Text(
                  "Products",
                  style: TextStyle(
                    fontFamily: 'Sofia Sans',
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded( // Expanded widget added here
              child: DefaultTabController(
                length: 3, // Number of tabs
                child: Column(
                  children: [
                    TabBar(
                      labelColor: AppColors.appBlueColor, // Color of the selected tab text
                      unselectedLabelColor: Colors.grey, // Color of the unselected tab text
                      indicatorColor: AppColors.appBlueColor, // Color of the indicator line
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Active'),
                        Tab(text: 'Inactive'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AllTabProduct(),
                          ActiveTabProduct(),
                          InactiveTabProduct(),
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
      // Move the "Add Product" button to the bottomNavigationBar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12, // Avoid overlapping with keyboard
        ),
        child: CommonButton(
          buttonWidth: screenWidth * 0.9,
          icon: Icons.add,
          buttonName: "Add Product",
          onPressed: () {
            Get.to(const AllProcductScreen());
          },
        ),
      ),
    );
  }
}
