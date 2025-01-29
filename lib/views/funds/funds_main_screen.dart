import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/funds/add_funds_screen.dart';
import 'package:paycron/views/funds/all_funds_screen.dart';
import 'package:paycron/views/funds/pending_screen.dart';
import 'package:paycron/views/funds/successful_screen.dart';
import 'package:paycron/views/funds/unsuccessful_screen.dart';
import 'package:paycron/views/widgets/common_button.dart';

import '../../utils/string_constants.dart';

class FundsMainScreen extends StatefulWidget {
  const FundsMainScreen({super.key});

  @override
  State<FundsMainScreen> createState() => _FundsMainScreenState();
}

class _FundsMainScreenState extends State<FundsMainScreen>
    with SingleTickerProviderStateMixin {
  var addCustomerController = Get.find<AddCustomerController>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
        title: Obx(
          () => Text(
            CommonVariable.businessName.value,
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: Constants.Sofiafontfamily,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => {Get.to(const BusinessProfileScreen())},
              child: CircleAvatar(
                radius: screenHeight / 45,
                backgroundImage: AssetImage(ImageAssets.profile),
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Image.asset(ImageAssets.closeDrawer),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Container(
        color: AppColors.appBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                  child: Text(
                    "Funds",
                    style: TextStyle(
                      fontFamily: Constants.Sofiafontfamily,
                      color: AppColors.appBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                labelColor: AppColors.appBlueColor,
                                unselectedLabelColor: Colors.grey,
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
                                  Tab(text: 'Pending'),
                                  Tab(text: 'Successful'),
                                  Tab(text: 'Unsuccessful'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.0,
                        child: Row(
                          children: List.generate(4, (index) {
                            return Expanded(
                              child: Container(
                                color: index == _tabController.index
                                    ? Colors.grey
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                      ),

                      // TabBarView for tab content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            AllFundsScreen(),
                            PendingScreen(),
                            SuccessfullScreen(),
                            UnsuccessfullScreen(),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom: 12.0,
        ),
        child: CommonButton(
          buttonWidth: MediaQuery.of(context).size.width * 0.9,
          icon: Icons.add,
          buttonName: "Add Funds",
          onPressed: () {
            Get.to(const AddFunds());
          },
        ),
      ),
    );
  }
}
