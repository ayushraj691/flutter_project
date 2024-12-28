import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResAllBussinessModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/single_company_dashboard/company_dashboard.dart';
import 'package:paycron/views/single_company_dashboard/profile_Screen.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class AllCompanyScreen extends StatefulWidget {
  const AllCompanyScreen({super.key});

  @override
  State<AllCompanyScreen> createState() => _AllCompanyScreenState();
}

class _AllCompanyScreenState extends State<AllCompanyScreen> {
  TextEditingController searchController = TextEditingController();
  var allBusinessController = Get.find<AllBussinessController>();
  var variableController = Get.find<VariableController>();
  List<ResAllBussiness> filteredItems = <ResAllBussiness>[].obs;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0),(){
      callMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void callMethod() async{
    allBusinessController.allBussinessList.clear();
    await allBusinessController.getAllBUssiness();
    filteredItems = allBusinessController.allBussinessList;
  }
  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allBusinessController.allBussinessList.where((item) => item.businessDetail.businessName!.toLowerCase().contains(query)).toList();});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18),
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
                  const SizedBox(height: 10.0,),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by company name',
                              filled: true,
                              fillColor: AppColors.appNeutralColor5,
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (allBusinessController.allBussinessList.isEmpty) {
                            return variableController.loading.value
                                ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                child: Lottie.asset(
                                    "assets/lottie/half-circles.json"),
                              ),
                            )
                                : NoDataFoundCard(); // Your custom widget
                          } else {
                            return  ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                return listItem(filteredItems, index, context);
                              },
                              physics: const ScrollPhysics(),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }
}


Widget listItem(List<ResAllBussiness> allBusinessList, int index, context) {
  var allBusinessController = Get.find<AllBussinessController>();
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  int percent = 0; // Initial percent is 0
  if (allBusinessList[index].businessDetail.businessDetailstatus == '1') {
    percent += 25;
  }
  if (allBusinessList[index].support.supportStatus == '1') {
    percent += 25;
  }
  if (allBusinessList[index].bankDetails.bankDetailstatus == '1') {
    percent += 25;
  }
  if (allBusinessList[index].businessDetail.plan != null && allBusinessList[index].businessDetail.plan!.isNotEmpty) {
    percent += 25;
  }
  String statusMessage = "Profile: $percent% done";
  return InkWell(
      onTap: () async {
        if(allBusinessList[index].isApproved == '1' ){
        CommonVariable.businessName.value=allBusinessList[index].businessDetail.businessName??"";
        CommonVariable.Percentage.value=percent.toString()??"";
        CommonVariable.businessId.value=allBusinessList[index].sId??"";
        allBusinessController.getFunds(CommonVariable.businessId.value);
        Get.to(
            const CompanyDashboard());
        }else{
          MyToast.toast('Business not approved');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenHeight / 30,
                  backgroundColor: allBusinessController.hexToColor(allBusinessList[index].colorCode),
                  child: Text(
                    allBusinessList[index].prefix.toUpperCase(),
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
                        allBusinessList[index].businessDetail.businessName ?? "",
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
                    color: allBusinessList[index].isApproved == '0' ? AppColors.appLightYellowColor :
                    allBusinessList[index].isApproved == '1' ? AppColors.appGreenAcceptColor :
                    allBusinessList[index].isApproved == '2' ? AppColors.appRedLightColor :
                    allBusinessList[index].isApproved == '3' ? AppColors.appBlueLightColor :
                    allBusinessList[index].isApproved == '4' ? AppColors.appGreenLightColor :
                    allBusinessList[index].isApproved == '5' ? AppColors.appSoftSkyBlueColor :
                    AppColors.appRedLightColor1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FittedBox(
                    child: Text(
                        allBusinessList[index].isApproved == '0' ? "Pending" :
                        allBusinessList[index].isApproved == '1' ? "Approved" :
                        allBusinessList[index].isApproved == '2' ? "Decline" :
                        allBusinessList[index].isApproved == '3' ? "Review" :
                        allBusinessList[index].isApproved == '4' ? "Revision" :
                        allBusinessList[index].isApproved == '5' ? "Added" :
                        "Discontinue",
                      style: TextStyle(
                          color: allBusinessList[index].isApproved == '0' ? AppColors.appOrangeTextColor :
                          allBusinessList[index].isApproved == '1' ? AppColors.appGreenDarkColor :
                          allBusinessList[index].isApproved == '2' ? AppColors.appRedColor :
                          allBusinessList[index].isApproved == '3' ? AppColors.appBlueColor :
                          allBusinessList[index].isApproved == '4' ? AppColors.appGreyColor :
                          allBusinessList[index].isApproved == '5' ? AppColors.appSkyBlueText :
                          AppColors.appRedColor,
                          fontSize: 12),
                    ),),
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

