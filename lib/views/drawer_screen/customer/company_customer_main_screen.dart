import 'package:flutter/material.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/drawer_screen/customer/active_customer.dart';
import 'package:paycron/views/drawer_screen/customer/all_tab_customer.dart';
import 'package:paycron/views/drawer_screen/customer/inActive_customer.dart';

class DrawerCustomerDetailScreen extends StatefulWidget {
  const DrawerCustomerDetailScreen({super.key});

  @override
  State<DrawerCustomerDetailScreen> createState() => _DrawerCustomerDetailScreenState();
}

class _DrawerCustomerDetailScreenState extends State<DrawerCustomerDetailScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
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
          "Company Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(4.0),
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
            Expanded(
              child: DefaultTabController(
                length: 3,
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
                          AllTab(),
                          ActiveTab(),
                          InActiveTab(),
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
    );
  }
}
