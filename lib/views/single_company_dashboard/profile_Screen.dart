import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/views/single_company_dashboard/merchant_screen/merchantProfile.dart';
import 'package:paycron/views/single_company_dashboard/submember.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {

  var merchantController = Get.find<MerchantController>();


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
    });
    super.initState();
  }

  callMethod() async{
    await merchantController.getSingleUser(CommonVariable.userId.value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.01;
    double verticalPadding = screenHeight * 0.02;
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
          CommonVariable.businessName.value==""?'Profile Detail': CommonVariable.businessName.value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, top: 20, bottom: 10),
                child: Text(
                  "Profile",
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
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      child: SegmentedTabControl(
                        barDecoration: BoxDecoration(
                          color: AppColors.appTabBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        indicatorDecoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sofia Sans',
                        ),
                        tabTextColor: AppColors.appGreyColor,
                        selectedTabTextColor: AppColors.appTextColor,
                        tabPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        indicatorPadding: const EdgeInsets.all(5.0),
                        tabs: const [
                          SegmentTab(
                            label: 'Merchant Profile',
                          ),
                          SegmentTab(
                            label: 'Submember',
                          ),
                        ],
                      ),
                    ),
                     const Expanded(
                      child: TabBarView(
                        children: [
                          MerchantProfile(),
                          SubMember(),
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
