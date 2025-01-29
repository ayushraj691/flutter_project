import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/drawer_Controller/subscriptions_controller/add_subscription_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/add_subscription_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/all_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/cancelled_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/deleted_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/downloaded_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/new_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/reimbursement_subscriptions_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/subscriptions_Scheduled_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/verified_subscriptions_screen.dart';
import 'package:paycron/views/widgets/common_button.dart';

import '../../../utils/string_constants.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen>
    with SingleTickerProviderStateMixin {
  final addSubscriptionController = Get.find<AddSubscriptionController>();
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  final double tabWidth = 100.0;
  late double screenWidth;

  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _scrollToSelectedTab(_tabController.index);
      }
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _showLeftArrow = _scrollController.position.pixels > 0;
      _showRightArrow = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollToSelectedTab(int index) {
    if (_scrollController.hasClients) {
      final targetScrollOffset =
          (index * tabWidth) - (screenWidth / 2) + (tabWidth / 2);

      final clampedOffset = targetScrollOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: AnimatedBuilder(
                      animation: _tabController.animation!,
                      builder: (context, child) {
                        return Row(
                          children: List.generate(8, (index) {
                            double animationValue = _tabController.animation!.value;
                            double activeWeight = 1.0 - (animationValue - index).abs().clamp(0.0, 1.0);
                            final text = [
                              'All',
                              'Scheduled',
                              'New',
                              'Verified',
                              'Downloaded',
                              'Cancelled',
                              'Deleted',
                              'Reimbursement',
                            ][index];

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Constants.Sofiafontfamily,
                                ),
                              ),
                              textDirection: TextDirection.ltr,
                            );
                            textPainter.layout();
                            final textWidth = textPainter.width;

                            return GestureDetector(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.center,
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Constants.Sofiafontfamily,
                                        color: Color.lerp(Colors.grey, AppColors.appBlueColor, activeWeight),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Background line (always visible)
                                  Container(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  // Animated indicator line
                                  Container(
                                    height: 1,
                                    width: textWidth,
                                    color: _tabController.index == index
                                        ? AppColors.appBlueColor
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
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
}
