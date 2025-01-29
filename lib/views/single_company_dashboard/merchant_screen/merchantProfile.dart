import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/auth/login_screen.dart';
import 'package:paycron/views/single_company_dashboard/merchant_screen/address_screen.dart';
import 'package:paycron/views/single_company_dashboard/merchant_screen/changePassword.dart';
import 'package:paycron/views/single_company_dashboard/merchant_screen/personal_detail_screen.dart';
import 'package:paycron/views/single_company_dashboard/merchant_screen/social_security_number_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantProfile extends StatefulWidget {
  const MerchantProfile({super.key});

  @override
  State<MerchantProfile> createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile> {
  var merchantController = Get.find<MerchantController>();

  void clearAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 8.0,top: 12.0,bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight / 10, // Diameter of the circle
                          height: screenHeight / 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(ImageAssets.profile),
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  fontFamily: Constants.Stolzlfontfamily,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Obx(() => Text(
                                    merchantController.emailId.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      fontFamily: Constants.Sofiafontfamily,
                                      color: AppColors.appHeadingText,
                                    ),
                                  )),
                              Obx(() => Text(
                                    merchantController.phoneNo.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      fontFamily: Constants.Sofiafontfamily,
                                      color: AppColors.appHeadingText,
                                    ),
                                  )),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(ImageAssets.EditIcon),
                                    color: AppColors.appBlueColor,
                                    height: 14,
                                    width: 14,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                      fontFamily: Constants.Sofiafontfamily,
                                      color: AppColors.appBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(const PersonDetailsScreen());
                        },
                        child: _buildInfoRow("Personal Details",
                            "Manage your name, email, & password")),
                    const Divider(
                        thickness: 2.0,
                        color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: () {
                          Get.to(const AddressDetailsScreen());
                        },
                        child: _buildInfoRow(
                            "Your Address", "Manage Your Address")),
                    const Divider(
                        thickness: 2.0,
                        color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: () {
                          Get.to(const SocialSecurityNumberScreen());
                        },
                        child: _buildInfoRow("Social Security Number",
                            "Manage your social security")),
                    const Divider(
                        thickness: 2.0,
                        color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: () {
                          Get.to(const ChangePasswordScreen());
                        },
                        child: _buildInfoRow(
                            "Password", "Change or update password")),
                    const Divider(
                        thickness: 2.0,
                        color: AppColors.appBackgroundGreyColor),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 8.0),
                            child: InkWell(
                              onTap: () async {
                                clearAllSharedPreferences();
                                Get.offAll(const LoginScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.logout_outlined,
                                    color: Colors.red,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                      fontFamily: Constants.Sofiafontfamily,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "© 2024–2025",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        color: AppColors.appHeadingText,
                        fontFamily: Constants.Sofiafontfamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomLink("Privacy Policy"),
                      _buildBottomLink("Terms & Conditions"),
                      _buildBottomLink("Contact"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      "Users are advised to read the terms and conditions carefully.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                        color: AppColors.appHeadingText,
                        fontFamily: Constants.Sofiafontfamily,
                      ),
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

  Widget _buildInfoRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: Constants.Sofiafontfamily,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  fontFamily: Constants.Sofiafontfamily,
                  color: AppColors.appHeadingText,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_right, color: AppColors.appBlackColor),
        ],
      ),
    );
  }
  Widget _buildBottomLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10.0,
        color: AppColors.appBlackColor,
        fontFamily: Constants.Sofiafontfamily,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
