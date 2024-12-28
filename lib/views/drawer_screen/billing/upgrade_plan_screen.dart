import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/billing_controller/upgrade_plan_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/string_constants.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen> {
  var upgradePlanController = Get.find<UpgradePlanController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
    });  }

  void callMethod() async {
    await upgradePlanController.getAllPlan();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appTabBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appTabBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Upgrade Plan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
        child: Column(
          children: [
            Expanded(
              child: upgradePlanController.getAllPlanList.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: Lottie.asset(
                        "assets/lottie/half-circles.json"),
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 16.0),
                itemCount: upgradePlanController.getAllPlanList.length,
                itemBuilder: (context, index) {
                  bool isSelected = CommonVariable.planId.value == upgradePlanController.getAllPlanList[index].sId;
                  bool isTemporarySelected = CommonVariable.temporaryPlanId.value == upgradePlanController.getAllPlanList[index].sId;
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              CommonVariable.temporaryPlanId.value = upgradePlanController.getAllPlanList[index].sId;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: isTemporarySelected
                                  ? Colors.lightBlue.shade50
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: isTemporarySelected
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isTemporarySelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: isTemporarySelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      upgradePlanController
                                          .getAllPlanList[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: isTemporarySelected
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: Text(
                                    upgradePlanController
                                        .getAllPlanList[index].details,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'USD ${upgradePlanController.getAllPlanList[index].monthlyPrice} / month',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showPlanBenefitPopup(context,index);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.grey.shade600,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              "More info.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isTemporarySelected)
                          Positioned(
                            top: -10,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                "Active Plan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  GeneralMethods.loadingDialog(context);
                  upgradePlanController.updatePlane();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Save Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPlanBenefitPopup(BuildContext context,int index) {
    final selectedPlan = upgradePlanController.getAllPlanList[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.9, // Set the width to 80% of screen width
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
            Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Text(
                selectedPlan.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Price
            Text(
              "\$${selectedPlan.monthlyPrice} USD/month",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Description
            Text(
              selectedPlan.details,
              style: TextStyle(
                fontSize: 12,
                fontFamily: Constants.Sofiafontfamily,
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              color: AppColors.appBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plan Price",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: Constants.Sofiafontfamily,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appNeutralColor2,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const Divider(color: AppColors.appGreyColor),
                    _buildPlanDetail("SetUp Fee", selectedPlan.setupPrice.toString()),
                    _buildPlanDetail("Monthly Fee", selectedPlan.monthlyPrice.toString()),
                    _buildPlanDetail("Processing Fee", selectedPlan.planPrices.processingFees.first),
                    _buildPlanDetail("Per Swipe Fee", "${selectedPlan.planPrices.perSwipeFee.first}%"),
                    _buildPlanDetail("Verification Fee", "${selectedPlan.planPrices.verificationFee.first}%"),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
        Positioned(
        top: -10,
        right: -10,
        child: GestureDetector(
        onTap: () {
        Navigator.of(context).pop();
        },
        child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.close, color: Colors.black, size: 18),
        ),
        ),
        ),
        Positioned(
        top: -35,
        child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
        color: AppColors.appLightBlueColor,
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Icon(Icons.star, color: Colors.blue, size: 30),
        ),
        ),
        ),
        ),
        ],
        ),
        ),
        );
      },
    );
  }
  Widget _buildPlanDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(':',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
          Expanded(
            flex: 2,
            child:  Text(value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                )),
          ),
        ],
      ),
    );
  }
}


