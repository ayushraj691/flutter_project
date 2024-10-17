import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResAllBussinessModel.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/company_dashboard/company_dashboard.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/all_Transaction_main_screen.dart';
import 'package:paycron/views/drawer_screen/customer/company_customer_main_screen.dart';
import 'package:paycron/views/drawer_screen/product/Company_product_screen.dart';
import 'package:paycron/views/funds/add_funds_screen.dart';
import 'package:paycron/views/funds/transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import '../../utils/color_constants.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedIndex = -1; // Store the index of the selected item
  int expandedIndex = -1; // Store the index of the expanded item
  TextEditingController searchController = TextEditingController();
  var allbusinessController = Get.find<AllBussinessController>();
  var variableController = Get.find<VariableController>();
  List<ResAllBussiness> filteredItems = [];
  bool showSwitchCompanyView = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0),(){
      _callMethod();
      searchController.addListener(_filterItems);
    });
  }

  void _callMethod() async {
    await allbusinessController.getAllBUssiness();
    filteredItems = allbusinessController.allBussinessList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allbusinessController.allBussinessList
          .where((item) =>
              item.businessDetail.businessName!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
      ),
      width: screenWidth * 0.85, // Responsive width
      child: showSwitchCompanyView
          ? _buildSwitchCompanyView(context) // Show column view
          : _buildDefaultDrawer(context),
    );
  }



  Widget _buildDefaultDrawer(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double percentageValue = double.parse(CommonVariable.Percentage.value.toString()) / 100;
    return ListView(
      padding: EdgeInsets.only(top: screenHeight * 0.05),
      children: <Widget>[
        PrepaidBalanceWidget(
            screenWidth: screenWidth, screenHeight: screenHeight),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular Progress Bar with Image in the center
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height / 12,
                        height: MediaQuery.of(context).size.height / 12,
                        child:  CircularProgressIndicator(
                          value: percentageValue,
                          strokeWidth: 4.0,
                          backgroundColor: AppColors.appBackgroundGreyColor,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.appGreenDarkColor),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 30,
                        backgroundImage: AssetImage(ImageAssets.profile),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.center,
                      child: Obx(
                            () => Text(
                          "${CommonVariable.Percentage.value}% done",
                          style: const TextStyle(
                            color: AppColors.appGreenDarkColor,
                            fontSize: 12,
                          ),
                        ),
                      )),
                ],
              ),

              const SizedBox(width: 10),

              // Account Information
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                        color: AppColors.appBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5),
                    Obx(
                          () => Text(
                        CommonVariable.businessName.value,
                        style: const TextStyle(
                          color: AppColors.appBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow
                              .ellipsis, // Text will truncate if too long
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(width: 10),
              // Switch Company Section
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssets.refresh,
                      color: AppColors.appBlueColor,
                    ),
                    // Icon(Icons.cameraswitch, color: AppColors.appBlueColor),
                    SizedBox(width: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          setState(() {
                            showSwitchCompanyView =
                            true; // Show the switch company view
                          })
                        },
                        child: const Text(
                          'Switch Company',
                          style: TextStyle(
                            color: AppColors.appBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow
                                .ellipsis, // Text will truncate if too long
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        _createDrawerItem(
            icon: Icons.dashboard_rounded,
            text: 'Dashboard',
            index: 0,
            onTap: () {
              Get.to(CompanyDashboard());
              Scaffold.of(context).closeEndDrawer();
              setState(() => selectedIndex = 0);
            }),
        _createDrawerItem(
            icon: Icons.people_outline,
            text: 'Customers',
            index: 1,
            onTap: () {
              Get.to(const DrawerCustomerDetailScreen());
              Scaffold.of(context).closeEndDrawer();
              setState(() => selectedIndex = 1);
            }),
        _createDrawerItem(
            icon: Icons.wallet_giftcard_rounded,
            text: 'Products',
            index: 2,
            onTap: () {
              Get.to(const CompanyDetailProductScreen());
              setState(() => selectedIndex = 2);
              Scaffold.of(context).closeEndDrawer();
            }),
        _createExpansionDrawerItem(
          icon: Icons.wallet_membership_outlined,
          text: 'All Transactions',
          index: 3,
          children: [
            _createDrawerItem(
                icon: Icons.account_balance_wallet_outlined,
                text: 'Transactions',
                index: 4,
                onTap: () {
                  setState(() => selectedIndex = 4);
                  Get.to(const AllTransactionScreen());
                  Scaffold.of(context).closeEndDrawer();
                }),
            _createDrawerItem(
                icon: Icons.terminal_outlined,
                text: 'Virtual Terminal',
                index: 5,
                onTap: () {
                  setState(() => selectedIndex = 5);
                  Scaffold.of(context).closeEndDrawer();
                }),
            _createDrawerItem(
                icon: Icons.subscriptions_rounded,
                text: 'Subscriptions',
                index: 6,
                onTap: () {
                  setState(() => selectedIndex = 6);
                  Scaffold.of(context).closeEndDrawer();
                }),
            _createDrawerItem(
                icon: Icons.inventory,
                text: 'Invoice',
                index: 7,
                onTap: () {
                  setState(() => selectedIndex = 7);
                  Scaffold.of(context).closeEndDrawer();
                }),
          ],
        ),
        _createExpansionDrawerItem(
          icon: Icons.report,
          text: 'Report',
          index: 8,
          children: [
            _createDrawerItem(
                icon: Icons.account_balance_wallet_outlined,
                text: 'Transactions',
                index: 9,
                onTap: () {
                  setState(() => selectedIndex = 9);
                  Scaffold.of(context).closeEndDrawer();
                }),
          ],
        ),
        _createDrawerItem(
            icon: Icons.library_books,
            text: 'Funds',
            index: 10,
            onTap: () {
              setState(() => selectedIndex = 10);
              Scaffold.of(context).closeEndDrawer();
            }),
        _createDrawerItem(
            icon: Icons.developer_mode,
            text: 'Developers',
            index: 11,
            onTap: () {
              setState(() => selectedIndex = 11);
              Scaffold.of(context).closeEndDrawer();
            }),
        _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            index: 12,
            onTap: () {
              setState(() => selectedIndex = 12);
              Scaffold.of(context).closeEndDrawer();
            }),
      ],
    );
  }

  Widget _buildSwitchCompanyView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.05), // Top padding
        PrepaidBalanceWidget(
            screenWidth: screenWidth, screenHeight: screenHeight),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            GestureDetector(
                onTap: () => {
                      setState(() {
                        showSwitchCompanyView = false;
                      })
                    },
                child: const Icon(Icons.arrow_back)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            const Text(
              "Back to Menu",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.appTextColor,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ],
        ),
        _searchBar(screenWidth: screenWidth),
        Expanded(
          child: Obx(() {
            if (allbusinessController.allBussinessList.isEmpty) {
              return variableController.loading.value ?
              const Center(child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ))
                  :NoDataFoundCard();
            }
            return ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return listItem(filteredItems, index, context);
              },
              physics: const AlwaysScrollableScrollPhysics(),
            );
          }),
        ),
      ],
    );
  }

  Widget _createExpansionDrawerItem({
    required IconData icon,
    required String text,
    required List<Widget> children,
    required int index,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor),
      title: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      children: children,
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? AppColors.appBlueColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : AppColors.appBlackColor,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => onTap(),
    );
  }

  Widget _searchBar({required double screenWidth}) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search by company name',
          filled: true,
          fillColor: AppColors.appNeutralColor5,
          prefixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.all(screenWidth * 0.04),
          // Responsive content padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.08),
            // Responsive border radius
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget listItem(List<ResAllBussiness> allbusinessList, int index, context) {
    var allbusinessController = Get.find<AllBussinessController>();
    double screenHeight = MediaQuery.of(context).size.height;
    int percent = 0; // Initial percent is 0
    if (allbusinessList[index].businessDetail.businessDetailstatus == '1') {
      percent += 25;
    }

    if (allbusinessList[index].support.supportStatus == '1') {
      percent += 25;
    }

    if (allbusinessList[index].bankDetails.bankDetailstatus == '1') {
      percent += 25;
    }

    if (allbusinessList[index].businessDetail.plan != null &&
        allbusinessList[index].businessDetail.plan!.isNotEmpty) {
      percent += 25;
    }
    String statusMessage = "${percent}";
    return InkWell(
        onTap: () async {
          CommonVariable.businessName.value=allbusinessList[index].businessDetail.businessName??"";
          CommonVariable.Percentage.value=percent.toString()??"";
          CommonVariable.businessId.value=allbusinessList[index].sId??"";
          setState(() {
            Get.to(const CompanyDashboard());
            Scaffold.of(context).closeEndDrawer();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenHeight / 35,
                    backgroundColor: allbusinessController
                        .hexToColor(allbusinessList[index].colorCode),
                    child: Text(
                      allbusinessList[index].prefix,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allbusinessList[index].businessDetail.businessName ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Sofia Sans',
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                         "profile: $statusMessage% done", // Assuming statusMessage is available
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            fontFamily: 'Sofia Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: allbusinessList[index].isApproved == '0'
                          ? AppColors.appYellowColor
                          : allbusinessList[index].isApproved == '1'
                              ? AppColors.appGreenDarkColor
                              : allbusinessList[index].isApproved == '2'
                                  ? AppColors.appRedColor
                                  : allbusinessList[index].isApproved == '3'
                                      ? AppColors.appBlueColor
                                      : allbusinessList[index].isApproved == '4'
                                          ? AppColors.appGreyColor
                                          : allbusinessList[index].isApproved ==
                                                  '5'
                                              ? AppColors.appYellowColor
                                              : AppColors.appRedColor,
                      backgroundColor: allbusinessList[index].isApproved == '0'
                          ? AppColors.appYellowLightColor
                          : allbusinessList[index].isApproved == '1'
                              ? AppColors.appGreenAcceptColor
                              : allbusinessList[index].isApproved == '2'
                                  ? AppColors.appRedLightColor
                                  : allbusinessList[index].isApproved == '3'
                                      ? AppColors.appBlueLightColor
                                      : allbusinessList[index].isApproved == '4'
                                          ? AppColors.appGreenLightColor
                                          : allbusinessList[index].isApproved ==
                                                  '5'
                                              ? AppColors.appYellowLightColor
                                              : AppColors.appRedLightColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),

                      ),
                    ),
                    child: Text(
                      allbusinessList[index].isApproved == '0'
                          ? "Pending"
                          : allbusinessList[index].isApproved == '1'
                              ? "Approved"
                              : allbusinessList[index].isApproved == '2'
                                  ? "Decline"
                                  : allbusinessList[index].isApproved == '3'
                                      ? "Review"
                                      : allbusinessList[index].isApproved == '4'
                                          ? "Revision"
                                          : allbusinessList[index].isApproved ==
                                                  '5'
                                              ? "Added"
                                              : "Discontinue",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 60, right: 15),
                child: Divider(color: AppColors.appGreyColor),
              ),
            ],
          ),
        ));
  }
}

class PrepaidBalanceWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  PrepaidBalanceWidget({required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Scaffold.of(context).closeEndDrawer(),
              child: Image.asset(ImageAssets.openDrawer),
            ),
          ),
          SizedBox(width: screenWidth * 0.02), // Responsive spacing
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03),
            decoration: BoxDecoration(
              color: AppColors.appBackgroundGreyColor,
              borderRadius: BorderRadius.circular(
                  screenWidth * 0.05), // Responsive border radius
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Image.asset(ImageAssets.walletIcon),
                    SizedBox(width: screenWidth * 0.02), // Responsive spacing
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prepaid Balance',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appTextColor),
                        ),
                        Text(
                          '\$50.00',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                VerticalDivider(
                    thickness: 2, color: AppColors.appBackgroundGreyColor),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).closeEndDrawer();
                    Get.to(const AddFunds());
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.add_circle, color: AppColors.appBlackColor),
                      Text('Add Fund',
                          style: TextStyle(color: AppColors.appBlackColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02), // Responsive spacing
        ],
      ),
    );
  }
}
