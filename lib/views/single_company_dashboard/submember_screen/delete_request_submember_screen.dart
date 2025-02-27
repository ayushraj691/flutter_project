import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/dashboard/submember_controller/deleteRequest_submember_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/profileModel/ResAllSubmemberModel.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

class DeleteRequestSubmemberScreen extends StatefulWidget {
  const DeleteRequestSubmemberScreen({super.key});

  @override
  State<DeleteRequestSubmemberScreen> createState() =>
      _DeleteRequestSubmemberScreenState();
}

class _DeleteRequestSubmemberScreenState
    extends State<DeleteRequestSubmemberScreen> {
  TextEditingController searchController = TextEditingController();
  var deleteRequestSubmemberTabController =
      Get.find<DeleteRequestSubmemberController>();
  var variableController = Get.find<VariableController>();
  List<ResAllSubmemberModel> filteredItems = <ResAllSubmemberModel>[].obs;
  Map<String, dynamic> sortMap = {
    "": "",
  };
  Map<String, dynamic> argumentMap = {
    "is_deleted_request": true,
    "is_deleted_super ": false,
  };

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
      searchController.addListener(_filterItems);
    });
    super.initState();
  }

  void callMethod() async {
    await deleteRequestSubmemberTabController.getDeleteRequestSubmember(
      CommonVariable.userId.value,
      '',
      jsonEncode(argumentMap),
      "$sortMap",
    );

    filteredItems =
        deleteRequestSubmemberTabController.deleteRequestSubmemberList;
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = deleteRequestSubmemberTabController
          .deleteRequestSubmemberList
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
                              filled: true,
                              fillColor: AppColors.appNeutralColor5,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by Fund source',
                              hintStyle: const TextStyle(fontSize: 14.0,color: AppColors.appGreyColor
                              ),
                              contentPadding: const EdgeInsets.all(8),
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
                          if (deleteRequestSubmemberTabController
                              .deleteRequestSubmemberList.isEmpty) {
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
    String formattedDate = DateFormat('dd MMM, yy').format(dateTime);

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
                        "$formattedDate  $formattedTime",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlackColor,
                          fontSize: 14,
                          fontFamily: Constants.Sofiafontfamily,
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
                            color: submember.userdetails.isDeletedRequest ==
                                        true &&
                                    submember.userdetails.isDeletedSuper == true
                                ? AppColors.appLightYellowColor
                                : (submember
                                                .userdetails.isDeletedRequest ==
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
                                                false &&
                                            submember.userdetails.isVerfied ==
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
                                                  false &&
                                              submember.userdetails.isVerfied ==
                                                  true
                                          ? "Active"
                                          : "Inactive")),
                              style: TextStyle(
                                  color: submember.userdetails
                                                  .isDeletedRequest ==
                                              true &&
                                          submember
                                                  .userdetails.isDeletedSuper ==
                                              true
                                      ? AppColors.appOrangeTextColor
                                      : (submember.userdetails
                                                      .isDeletedRequest ==
                                                  true &&
                                              submember.userdetails
                                                      .isDeletedSuper ==
                                                  false
                                          ? AppColors.appTextColor2
                                          : (submember.userdetails
                                                          .isDeletedRequest ==
                                                      false &&
                                                  submember.userdetails
                                                          .isDeletedSuper ==
                                                      false &&
                                                  submember.userdetails
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
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.appHeadingText,
                          fontSize: 14,
                          fontFamily: Constants.Sofiafontfamily,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Submember: ${submember.userdetails.fullName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appHeadingText,
                    fontSize: 14,
                    fontFamily: Constants.Sofiafontfamily,
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
