import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/product/Inactive_screen_product.dart';
import 'package:paycron/views/drawer_screen/product/active_screen_product.dart';
import 'package:paycron/views/drawer_screen/product/add_product_screen.dart';
import 'package:paycron/views/drawer_screen/product/all_screen_product.dart';
import 'package:paycron/views/widgets/common_button.dart';

import '../../../utils/string_constants.dart';

class CompanyDetailProductScreen extends StatefulWidget {
  const CompanyDetailProductScreen({super.key});

  @override
  State<CompanyDetailProductScreen> createState() =>
      _CompanyDetailProductScreenState();
}

class _CompanyDetailProductScreenState extends State<CompanyDetailProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    // Listen to tab changes and rebuild UI
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
              onTap: () {
                Get.to(const BusinessProfileScreen());
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child:  Container(
                width: screenHeight / 20,
                height: screenHeight / 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.profile),
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Image.asset(ImageAssets.closeDrawer),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
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
                padding: EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
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
            Container(
              margin: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    labelColor: AppColors.appBlueColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,fontFamily: Constants.Sofiafontfamily),
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.appBlueColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Active'),
                      Tab(text: 'Inactive'),
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        AllTabProduct(),
                        ActiveTabProduct(),
                        InactiveTabProduct(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom: 12.0,
        ),
        child: CommonButton(
          buttonWidth: screenWidth * 0.9,
          icon: Icons.add,
          buttonName: "Add Product",
          onPressed: () {
            Get.to(const AddProcductScreen());
          },
        ),
      ),
    );
  }
}
