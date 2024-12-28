import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResAllBussinessModel.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/drawer_screen/AllTransactions/all_Transaction_main_screen.dart';
import 'package:paycron/views/drawer_screen/billing/billing_information.dart';
import 'package:paycron/views/drawer_screen/billing/customer_billing.dart';
import 'package:paycron/views/drawer_screen/customer/company_customer_main_screen.dart';
import 'package:paycron/views/drawer_screen/invoice/invoice_main_screen.dart';
import 'package:paycron/views/drawer_screen/product/Company_product_screen.dart';
import 'package:paycron/views/drawer_screen/subscriptions/subscriptions_main_screen.dart';
import 'package:paycron/views/drawer_screen/virtualTerminal/virtualTerminal_main_screen.dart';
import 'package:paycron/views/funds/add_funds_screen.dart';
import 'package:paycron/views/funds/funds_main_screen.dart';
import 'package:paycron/views/single_company_dashboard/company_dashboard.dart';
import 'package:paycron/views/single_company_dashboard/profile_Screen.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import '../../utils/color_constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedIndex = -1;
  int expandedIndex = -1;
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
                      InkWell(
                        onTap: () => {
                          Get.to(const ProfileScreen()),
                          Scaffold.of(context).closeEndDrawer()
                      },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height / 30,
                          backgroundImage: AssetImage(ImageAssets.profile),
                        ),
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
                              .ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssets.refresh,
                      color: AppColors.appBlueColor,
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          setState(() {
                            showSwitchCompanyView =
                            true; // Show the switch company view
                          })
                        },
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return const Text(
                                'Switch \nCompany',
                                style: TextStyle(
                                  color: AppColors.appBlueColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis, // Text will truncate if too long
                                ),
                                softWrap: true, // Allows the text to wrap if it's too long
                              );
                            },
                          )
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
            image: Image.asset(ImageAssets.dashboardIcon),
            text: 'Dashboard',
            index: 0,
            onTap: () {
              Get.off(const CompanyDashboard());
              Scaffold.of(context).closeEndDrawer();
              setState(() => selectedIndex = 0);
            }),
        _createDrawerItem(
            image: Image.asset(ImageAssets.twoPerson),
            text: 'Customers',
            index: 1,
            onTap: () {
              Get.to(const DrawerCustomerDetailScreen());
              Scaffold.of(context).closeEndDrawer();
              setState(() => selectedIndex = 1);
            }),
        _createDrawerItem(
            image: Image.asset(ImageAssets.productIcon),
            text: 'Products',
            index: 2,
            onTap: () {
              Get.to(const CompanyDetailProductScreen());
              setState(() => selectedIndex = 2);
              Scaffold.of(context).closeEndDrawer();
            }),
        _createExpansionDrawerItem(
          image: Image.asset(ImageAssets.transactionIcon),
          text: 'All Transactions',
          index: 3,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: _createExpandedDrawerItem(
                  image: Image.asset(ImageAssets.blueCircle),
                  text: 'Transactions',
                  index: 4,
                  onTap: () {
                    setState(() => selectedIndex = 4);
                    Get.to(const AllTransactionScreen());
                    Scaffold.of(context).closeEndDrawer();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: _createExpandedDrawerItem(
                  image: Image.asset(ImageAssets.blueCircle),
                  text: 'Virtual Terminal',
                  index: 5,
                  onTap: () {
                    setState(() => selectedIndex = 5);
                    Get.to(const VirtualTerminalScreen());
                    Scaffold.of(context).closeEndDrawer();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: _createExpandedDrawerItem(
                  image: Image.asset(ImageAssets.blueCircle),
                  text: 'Subscriptions',
                  index: 6,
                  onTap: () {
                    setState(() => selectedIndex = 6);
                    Get.to(const SubscriptionsScreen());
                    Scaffold.of(context).closeEndDrawer();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: _createExpandedDrawerItem(
                  image: Image.asset(ImageAssets.blueCircle),
                  text: 'Invoice',
                  index: 7,
                  onTap: () {
                    setState(() => selectedIndex = 7);
                    Get.to(const InvoiceScreen());
                    Scaffold.of(context).closeEndDrawer();
                  }),
            ),
          ],
        ),
        _createDrawerItem(
            image: Image.asset(ImageAssets.customerBillingIcon),
            text: 'Customer Billing',
            index: 8,
            onTap: () {
              setState(() => selectedIndex = 8);
              Get.to(const CustomerBilling());
              Scaffold.of(context).closeEndDrawer();
            }),
        _createExpansionDrawerItem(
            image: Image.asset(ImageAssets.fundsIcon),
            text: 'Funds',
            index: 9,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: _createExpandedDrawerItem(
                    image: Image.asset(ImageAssets.blueCircle),
                    text: 'Funds',
                    index: 10,
                    onTap: () {
                    setState(() => selectedIndex = 10);
                    Get.to(const FundsMainScreen());
                    Scaffold.of(context).closeEndDrawer();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child:  _createExpandedDrawerItem(
                    image: Image.asset(ImageAssets.blueCircle),
                    text: 'Billing Information',
                    index: 11,
                    onTap: () {
                      setState(() => selectedIndex = 11);
                      Get.to(const BillingInformation());
                      Scaffold.of(context).closeEndDrawer();
                    }),
              ),
            ],
        ),

        // _createDrawerItem(
        //     icon: Icons.settings,
        //     text: 'Settings',
        //     index: 11,
        //     onTap: () {
        //       setState(() => selectedIndex = 11);
        //       Get.to(const RangeDatePickerScreen());
        //       Scaffold.of(context).closeEndDrawer();
        //     }),
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
    required Image image,
    required String text,
    required List<Widget> children,
    required int index,
  }) {
    return ExpansionTile(
      leading: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? AppColors.appBlueColor :  AppColors.appTabBackgroundColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: image.image, // Use the image property of the Image widget
          color: selectedIndex == index ? Colors.white : AppColors.appBlackColor, // Apply color dynamically if the image supports it
          height: 24.0, // Set height for consistency
          width: 24.0, // Set width for consistency
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.bold,
          fontFamily: Constants.Sofiafontfamily,
          height: 2
        ),
      ),
      children: children,
    );
  }

  Widget _createExpandedDrawerItem({
    required Image image, // Accept an Image instead of IconData
    required String text,
    required int index,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlueColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6.0),
        child: Image(
          image: image.image, // Use the Image widget's image property
          color: selectedIndex == index ? Colors.white : AppColors.appLightBlueColor,
          height: 8.0, // Adjust the size as needed
          width: 8.0,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
            color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor,
            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.bold,
            fontFamily: Constants.Sofiafontfamily,
            height: 2
        ),
      ),
      onTap: () => onTap(),
    );
  }


  Widget _createDrawerItem({
    required Image image, // Accept an Image instead of IconData
    required String text,
    required int index,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appTabBackgroundColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: image.image, // Use the Image widget's image property
          color: selectedIndex == index ? Colors.white : AppColors.appBlackColor,
          height: 24.0, // Adjust the size as needed
          width: 24.0,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? AppColors.appBlueColor : AppColors.appBlackColor,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.bold,
            fontFamily: Constants.Sofiafontfamily,
            height: 2
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
    String statusMessage = "Profile: $percent% done";
    return InkWell(
        onTap: () async {
      if(allbusinessList[index].isApproved == '1' ){
        CommonVariable.businessName.value=allbusinessList[index].businessDetail.businessName??"";
          CommonVariable.Percentage.value=percent.toString()??"";
          CommonVariable.businessId.value=allbusinessList[index].sId??"";
          allbusinessController.getFunds(CommonVariable.businessId.value);
          setState(() {
            Get.to(const CompanyDashboard());
            Scaffold.of(context).closeEndDrawer();
          });
      }else{
        MyToast.toast('Business not approved');
      }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,  // Align items to the start
                crossAxisAlignment: CrossAxisAlignment.center, // Align vertically centered
                children: [
                  CircleAvatar(
                    radius: screenHeight / 30,
                    backgroundColor: allbusinessController.hexToColor(allbusinessList[index].colorCode),
                    child: Text(
                      allbusinessList[index].prefix.toUpperCase(),
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
                          allbusinessList[index].businessDetail.businessName ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: Constants.Sofiafontfamily,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          statusMessage,  // Assuming statusMessage is available
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            fontFamily: Constants.Sofiafontfamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: allbusinessList[index].isApproved == '0' ? AppColors.appLightYellowColor :
                      allbusinessList[index].isApproved == '1' ? AppColors.appGreenAcceptColor :
                      allbusinessList[index].isApproved == '2' ? AppColors.appRedLightColor :
                      allbusinessList[index].isApproved == '3' ? AppColors.appBlueLightColor :
                      allbusinessList[index].isApproved == '4' ? AppColors.appGreenLightColor :
                      allbusinessList[index].isApproved == '5' ? AppColors.appSoftSkyBlueColor :
                      AppColors.appRedLightColor1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FittedBox(
                      child: Text(
                        allbusinessList[index].isApproved == '0' ? "Pending" :
                        allbusinessList[index].isApproved == '1' ? "Approved" :
                        allbusinessList[index].isApproved == '2' ? "Decline" :
                        allbusinessList[index].isApproved == '3' ? "Review" :
                        allbusinessList[index].isApproved == '4' ? "Revision" :
                        allbusinessList[index].isApproved == '5' ? "Added" :
                        "Discontinue",
                        style: TextStyle(
                            color: allbusinessList[index].isApproved == '0' ? AppColors.appOrangeTextColor :
                            allbusinessList[index].isApproved == '1' ? AppColors.appGreenDarkColor :
                            allbusinessList[index].isApproved == '2' ? AppColors.appRedColor :
                            allbusinessList[index].isApproved == '3' ? AppColors.appBlueColor :
                            allbusinessList[index].isApproved == '4' ? AppColors.appGreyColor :
                            allbusinessList[index].isApproved == '5' ? AppColors.appSkyBlueText :
                            AppColors.appRedColor,
                            fontSize: 12),
                      ),                        ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 65, ),
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

  const PrepaidBalanceWidget({super.key, required this.screenWidth, required this.screenHeight});

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
                    Image.asset(
                      ImageAssets.walletIcon,
                      height: MediaQuery.of(context).size.height * 0.05, // 5% of screen height
                      width: MediaQuery.of(context).size.width * 0.1,  // 10% of screen width
                      fit: BoxFit.contain, // Ensures the image fits within the defined space
                    ),
                    SizedBox(width: screenWidth * 0.02), // Responsive spacing
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prepaid Balance',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appTextColor),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            "\$${CommonVariable.approvedBalance.value}",
                            style: TextStyle(
                              color: AppColors.appBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              fontFamily: Constants.Sofiafontfamily,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const VerticalDivider(
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
