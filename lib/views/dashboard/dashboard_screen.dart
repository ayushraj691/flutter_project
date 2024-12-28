import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/dashboard/overall_statistic_screen.dart';
import 'package:paycron/views/dashboard/report_overview_screen.dart';
import 'package:paycron/views/single_company_dashboard/profile_Screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.01;
    double verticalPadding = screenHeight * 0.02;

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello,",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            fontFamily: 'Sofia Sans',
                          ),
                        ),
                        Text(
                          CommonVariable.userName.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Sofia Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => {
                        Get.to(const ProfileScreen())
                      },
                      child: CircleAvatar(
                        radius: screenHeight / 40,
                        backgroundImage: AssetImage(ImageAssets.profile),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child : SegmentedTabControl(
                          barDecoration: BoxDecoration(
                            color: AppColors.appTabBackgroundColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          indicatorDecoration: BoxDecoration(
                            color: AppColors.appWhiteColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          indicatorPadding:  const EdgeInsets.all(6.0),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sofia Sans',
                          ),
                          tabTextColor: AppColors.appGreyColor,
                          selectedTabTextColor: AppColors.appTextColor,
                          tabPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          // Define tabs
                          tabs: const [
                            SegmentTab(
                              label: 'Overall Statistics',
                            ),
                            SegmentTab(
                              label: 'Reports Overview',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const OverallStatistics(),
                            ReportOverview(),
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
    );
  }
}
