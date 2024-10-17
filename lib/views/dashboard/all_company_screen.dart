import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResAllBussinessModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/company_dashboard/company_dashboard.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class AllCompanyScreen extends StatefulWidget {
  const AllCompanyScreen({super.key});

  @override
  State<AllCompanyScreen> createState() => _AllCompanyScreenState();
}

class _AllCompanyScreenState extends State<AllCompanyScreen> {
  TextEditingController searchController = TextEditingController();
  var allbusinessController = Get.find<AllBussinessController>();
  var variableController = Get.find<VariableController>();
  List<ResAllBussiness> filteredItems = <ResAllBussiness>[].obs;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0),(){
      CallMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void CallMethod() async{
    allbusinessController.allBussinessList.clear();
    await allbusinessController.getAllBUssiness();
    filteredItems = allbusinessController.allBussinessList;
  }
  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allbusinessController.allBussinessList.where((item) => item.businessDetail.businessName!.toLowerCase().contains(query)).toList();});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.01;
    double verticalPadding = screenHeight * 0.02;
    return Scaffold(
      body: SafeArea(
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
                    // Space between text and image
                    const Spacer(),
                    // Image on the right side
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: screenHeight / 40,
                        backgroundImage: AssetImage(ImageAssets.profile),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                //   child: Center(
                //     child: CommonButton(
                //       buttonWidth: screenWidth * 0.9,
                //       icon: Icons.add_circle,
                //       buttonName: "Add First Company",
                //       onPressed: () {
                //         Get.to(const CompanyDashboard());
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10.0,),
                Card(
                  elevation: 2.0,
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
                        if (allbusinessController.allBussinessList.isEmpty) {
                          return variableController.loading.value
                              ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
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
    );
  }
}


Widget listItem(List<ResAllBussiness> allbusinessList, int index, context) {
  var allbusinessController = Get.find<AllBussinessController>();
  double screenWidth = MediaQuery.of(context).size.width;
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

  if (allbusinessList[index].businessDetail.plan != null && allbusinessList[index].businessDetail.plan!.isNotEmpty) {
    percent += 25;
  }
  String statusMessage = "Profile: $percent% done";
  return InkWell(
      onTap: () async {
        CommonVariable.businessName.value=allbusinessList[index].businessDetail.businessName??"";
        CommonVariable.Percentage.value=percent.toString()??"";
        CommonVariable.businessId.value=allbusinessList[index].sId??"";
        Get.to(
            CompanyDashboard());
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,  // Align items to the start
              crossAxisAlignment: CrossAxisAlignment.center, // Align vertically centered
              children: [
                CircleAvatar(
                  radius: screenHeight / 30,
                  backgroundColor: allbusinessController.hexToColor(allbusinessList[index].colorCode),
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
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        allbusinessList[index].businessDetail.businessName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        statusMessage,  // Assuming statusMessage is available
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor:
                    allbusinessList[index].isApproved == '0' ? AppColors.appYellowColor :
                    allbusinessList[index].isApproved == '1' ? AppColors.appGreenDarkColor :
                    allbusinessList[index].isApproved == '2' ? AppColors.appRedColor :
                    allbusinessList[index].isApproved == '3' ? AppColors.appBlueColor :
                    allbusinessList[index].isApproved == '4' ? AppColors.appGreyColor :
                    allbusinessList[index].isApproved == '5' ? AppColors.appYellowColor :
                    AppColors.appRedColor,

                    backgroundColor:
                    allbusinessList[index].isApproved == '0' ? AppColors.appYellowLightColor :
                    allbusinessList[index].isApproved == '1' ? AppColors.appGreenAcceptColor :
                    allbusinessList[index].isApproved == '2' ? AppColors.appRedLightColor :
                    allbusinessList[index].isApproved == '3' ? AppColors.appBlueLightColor :
                    allbusinessList[index].isApproved == '4' ? AppColors.appGreenLightColor :
                    allbusinessList[index].isApproved == '5' ? AppColors.appYellowLightColor :
                    AppColors.appRedLightColor1,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  child: Text(
                    allbusinessList[index].isApproved == '0' ? "Pending" :
                    allbusinessList[index].isApproved == '1' ? "Approved" :
                    allbusinessList[index].isApproved == '2' ? "Decline" :
                    allbusinessList[index].isApproved == '3' ? "Review" :
                    allbusinessList[index].isApproved == '4' ? "Revision" :
                    allbusinessList[index].isApproved == '5' ? "Added" :
                    "Discontinue",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70, right: 15),
              child: Divider(color: AppColors.appGreyColor),
            ),
          ],
        ),
      ));
}