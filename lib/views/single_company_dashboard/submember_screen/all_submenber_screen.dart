import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/dashboard/submember_controller/all_submember_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResAllTransaction.dart';
import 'package:paycron/model/profileModel/ResAllSubmemberModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/funds/transaction_detail.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class AllSubmemberScreen extends StatefulWidget {
  const AllSubmemberScreen({super.key});

  @override
  State<AllSubmemberScreen> createState() => _AllSubmemberScreenState();
}

class _AllSubmemberScreenState extends State<AllSubmemberScreen> {
  TextEditingController searchController = TextEditingController();
  var allsubmemberTabController = Get.find<AllSubmemberController>();
  var variableController = Get.find<VariableController>();
  List<ResAllSubmemberModel> filteredItems = <ResAllSubmemberModel>[].obs;
  Map<String, dynamic> sortMap = {
    "": "",
  };
  Map<String, dynamic> argumentMap = {
    "": "",
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      CallMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void CallMethod() async {
    await allsubmemberTabController.getAllSubmember(
      CommonVariable.userId.value,
      '',
      "$argumentMap",
      "$sortMap",
    );

    filteredItems = allsubmemberTabController.allSubmemberList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allsubmemberTabController.allSubmemberList
          .where(
              (item) => item.userdetails.fullName.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 0,
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
                              hintText: 'Search by name or email',
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
                          if (allsubmemberTabController
                              .allSubmemberList.isEmpty) {
                            return variableController.loading.value
                                ?Padding(
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
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                return listMemberCard(
                                    filteredItems, index, context);
                              },
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listMemberCard(
      List<ResAllSubmemberModel> allSubmemberList, int index, context) {
    final submember = allSubmemberList[index];
    final createdDate = submember.userdetails.createdOn;
    DateTime dateTime = DateTime.parse(createdDate).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        "$formattedDate,$formattedTime",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlackColor,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: submember.userdetails.isDeletedRequest == true &&
                                submember.userdetails.isDeletedSuper ==
                                    true
                                ? AppColors.appLightYellowColor
                                : (submember.userdetails.isDeletedRequest ==
                                true &&
                                submember
                                    .userdetails.isDeletedSuper ==
                                    false
                                ? AppColors.appNeutralColor5
                                : (submember.userdetails
                                .isDeletedRequest ==
                                false &&
                                submember.userdetails
                                    .isDeletedSuper ==
                                    false && submember.userdetails
                                .isVerfied ==
                                true
                                ? AppColors.appMintGreenColor
                                : AppColors.appRedLightColor)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FittedBox(
                            child: Text(
                              submember.userdetails.isDeletedRequest == true &&
                                  submember.userdetails.isDeletedSuper ==
                                      true
                                  ? "Delete"
                                  : (submember.userdetails.isDeletedRequest ==
                                  true &&
                                  submember
                                      .userdetails.isDeletedSuper ==
                                      false
                                  ? "Delete Request"
                                  : (submember.userdetails
                                  .isDeletedRequest ==
                                  false &&
                                  submember.userdetails
                                      .isDeletedSuper ==
                                      false && submember.userdetails
                                  .isVerfied ==
                                  true
                                  ? "Active"
                                  : "Inactive")),
                              style: TextStyle(
                                  color: submember.userdetails.isDeletedRequest == true &&
                                      submember.userdetails.isDeletedSuper ==
                                          true
                                      ? AppColors.appOrangeTextColor
                                      : (submember.userdetails.isDeletedRequest ==
                                      true &&
                                      submember
                                          .userdetails.isDeletedSuper ==
                                          false
                                      ? AppColors.appTextColor2
                                      : (submember.userdetails
                                      .isDeletedRequest ==
                                      false &&
                                      submember.userdetails
                                          .isDeletedSuper ==
                                          false && submember.userdetails
                                      .isVerfied ==
                                      true
                                      ? AppColors.appGreenDarkColor
                                      : AppColors.appRedColor)),
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        "Business: ${submember.business.accountId.businessDetail.businessName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.appHeadingText,
                          fontSize: 14,
                          fontFamily: 'Sofia Sans',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Submember: ${submember.userdetails.fullName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appHeadingText,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Email: ${submember.userdetails.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appHeadingText,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Positioned PopupMenuButton in the top-right corner
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                // Handle menu selection
                if (value == 'edit') {
                  // Handle edit action
                } else if (value == 'delete') {
                  // Handle delete action
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined,
                            color: AppColors.appBlackColor),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline_outlined,
                            color: AppColors.appBlackColor),
                        SizedBox(width: 8),
                        Text('Remove'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }

}
