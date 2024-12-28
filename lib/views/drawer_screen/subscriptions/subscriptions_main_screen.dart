import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/subscriptions_controller/add_subscription_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/add_subscription_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/subscriptions_Scheduled_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/all_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/cancelled_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/deleted_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/downloaded_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/new_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/reimbursement_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/verified_subscriptions_screen.dart';
import 'package:paycron/views/widgets/common_button.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  final addSubscriptionController = Get.find<AddSubscriptionController>();
  final ScrollController _scrollController = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _showLeftArrow = _scrollController.position.pixels > 0;
      _showRightArrow = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              icon: Image.asset(ImageAssets.closeDrawer),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, top: 20, bottom: 10),
                child: Text(
                  "Subscriptions",
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
                length: 8,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Left Arrow
                        Visibility(
                          visible: _showLeftArrow,
                          child: IconButton(
                            icon: const SizedBox(
                              width: 24,
                              height: 24,
                              child: Icon(Icons.arrow_back_ios,
                                  color: AppColors.appBlueColor, size: 18),
                            ),
                            onPressed: _showLeftArrow ? _scrollLeft : null,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: const TabBar(
                              isScrollable: true,
                              labelColor: AppColors.appBlueColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: AppColors.appBlueColor,
                              tabs: [
                                Tab(text: 'All'),
                                Tab(text: 'Scheduled'),
                                Tab(text: 'New'),
                                Tab(text: 'Verified'),
                                Tab(text: 'Downloaded'),
                                Tab(text: 'Cancelled'),
                                Tab(text: 'Deleted'),
                                Tab(text: 'Reimbursement'),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _showRightArrow,
                          child: IconButton(
                            icon: const SizedBox(
                              width: 24, // Small width
                              height: 24, // Small height
                              child: Icon(Icons.arrow_forward_ios,
                                  color: AppColors.appBlueColor, size: 18),
                            ),
                            onPressed: _showRightArrow ? _scrollRight : null,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          AllSubscriptionsTab(),
                          SubscriptionsScheduledTab(),
                          SubscriptionsNewTab(),
                          SubscriptionsVerifiedTab(),
                          SubscriptionsDownloadedTab(),
                          SubscriptionsCancelledTab(),
                          SubscriptionsDeletedTab(),
                          SubscriptionsReimbursementTab(),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom : 12.0,
        ),
        child: CommonButton(
          buttonWidth: MediaQuery.of(context).size.width * 0.9,
          icon: Icons.add,
          buttonName: "Add Subscriptions",
          onPressed: () {
            addSubscriptionController.clearAllCustomer();
            Get.to(const AddSubscriptionPage());
          },
        ),
      ),

    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
