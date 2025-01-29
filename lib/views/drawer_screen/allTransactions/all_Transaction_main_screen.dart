import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/dashboard/business_profile_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/all_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/cancelled_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/deleted_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/downloaded_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/new_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/reimbursement_transaction_screen.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/verified_transaction_screen.dart';

class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionScreenState();
}

class _AllTransactionScreenState extends State<AllTransactionScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  final double tabWidth = 100.0;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _scrollToSelectedTab(_tabController.index);
      }
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
    screenWidth = MediaQuery.of(context).size.width; // Get screen width
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
                  "All Transactions",
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
                          children: List.generate(7, (index) {
                            double animationValue = _tabController.animation!.value;
                            double activeWeight = 1.0 - (animationValue - index).abs().clamp(0.0, 1.0);
                            final text = [
                              'All',
                              'New',
                              'Verified',
                              'Downloaded',
                              'Cancelled',
                              'Deleted',
                              'Reimbursement'
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
                                  Container(
                                    height: 1,
                                    width: textWidth,
                                    color: _tabController.index == index
                                        ? Colors.blue
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
                        AllTransactionTab(),
                        TransactionNewTab(),
                        TransactionVerifiedTab(),
                        TransactionDownloadedTab(),
                        TransactionCancelledTab(),
                        TransactionDeletedTab(),
                        TransactionReimbursementTab(),
                      ],
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
}
