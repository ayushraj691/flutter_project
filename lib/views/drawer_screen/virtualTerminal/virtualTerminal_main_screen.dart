import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/all_virtual_terminal_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/cancelled_virtual_terminal_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/deleted_virtual_terminal_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/downloaded_virtual_terminal_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/new_virtual_terminal_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/reimbursement_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/verified_transaction_screen.dart';
import 'package:paycron/views/single_company_dashboard/create_payment_page.dart';
import 'package:paycron/views/widgets/common_button.dart';

class VirtualTerminalScreen extends StatefulWidget {
  const VirtualTerminalScreen({super.key});

  @override
  State<VirtualTerminalScreen> createState() => _VirtualTerminalScreenState();
}

class _VirtualTerminalScreenState extends State<VirtualTerminalScreen> {
  final ScrollController _scrollController = ScrollController();
  var addCustomerController = Get.find<AddCustomerController>();
  final createPaymentController = Get.find<CreatePaymentController>();
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
                  "Virtual Terminal",
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
                length: 7,
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
                          AllVirtualTerminalTab(),
                          VirtualTerminalNewTab(),
                          VirtualTerminalVerifiedTab(),
                          VirtualTerminalDownloadedTab(),
                          VirtualTerminalCancelledTab(),
                          VirtualTerminalDeletedTab(),
                          VirtualTerminalReimbursementTab(),
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
          buttonName: "Add",
          onPressed: () {
            createPaymentController.clearAllCustomer();
            Get.to(const CreatePaymentPage());
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
