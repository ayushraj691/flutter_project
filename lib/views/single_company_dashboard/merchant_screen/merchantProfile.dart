import 'package:flutter/material.dart';
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
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: screenHeight / 18,
                            backgroundImage: AssetImage(ImageAssets.profile),
                          ),
                        ),
                        const SizedBox(width: 10.0),
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
                                  const Icon(Icons.edit_note_outlined, color: AppColors.appBlueColor),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
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

            // Middle scrollable content
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
                        onTap: (){
                          Get.to(const PersonDetailsScreen());
                        },
                        child: _buildInfoRow("Personal Details", "Manage your name, email, & password")),
                    const Divider(thickness: 2.0, color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: (){
                          Get.to(const AddressDetailsScreen());
                        },
                        child: _buildInfoRow("Your Address", "Manage Your Address")),
                    const Divider(thickness: 2.0, color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: (){
                          Get.to(const SocialSecurityNumberScreen());
                        },
                        child: _buildInfoRow("Social Security Number", "Manage your social security")),
                    const Divider(thickness: 2.0, color: AppColors.appBackgroundGreyColor),
                    InkWell(
                        onTap: (){
                          Get.to(const ChangePasswordScreen());
                        },
                        child: _buildInfoRow("Password", "Change or update password")),
                    const Divider(thickness: 2.0, color: AppColors.appBackgroundGreyColor),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
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

            // Bottom fixed content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
        fontWeight: FontWeight.w500,
        fontSize: 10.0,
        color: AppColors.appBlackColor,
        fontFamily: Constants.Sofiafontfamily,
        decoration: TextDecoration.underline,
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:paycron/utils/color_constants.dart';
// import 'package:paycron/utils/image_assets.dart';
// import 'package:paycron/utils/string_constants.dart';
//
// class MerchantProfile extends StatefulWidget {
//   const MerchantProfile({super.key});
//
//   @override
//   State<MerchantProfile> createState() => _MerchantProfileState();
// }
//
// class _MerchantProfileState extends State<MerchantProfile> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Column(
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 2,
//                     margin: const EdgeInsets.all(8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ClipOval(
//                             child: CircleAvatar(
//                               radius: screenHeight / 18,
//                               backgroundImage: AssetImage(ImageAssets.profile),
//                             ),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Welcome back!",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18.0,
//                                     fontFamily: Constants.Stolzlfontfamily,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6.0),
//                                 Text(
//                                   "kristinasteve@paycron.com",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16.0,
//                                     fontFamily: Constants.Sofiafontfamily,
//                                     color: AppColors.appHeadingText,
//                                   ),
//                                 ),
//                                 Text(
//                                   "+2677859099",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16.0,
//                                     fontFamily: Constants.Sofiafontfamily,
//                                     color: AppColors.appHeadingText,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.edit_note_outlined, color: AppColors.appBlueColor),
//                                     const SizedBox(width: 4.0),
//                                     Text(
//                                       "Edit",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16.0,
//                                         fontFamily: Constants.Sofiafontfamily,
//                                         color: AppColors.appBlueColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 2,
//                     margin: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0), // Set padding to match the first card
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Personal Details",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6.0),
//                                   Text(
//                                     "Manage your name, email, & password",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                       color: AppColors.appHeadingText,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               const Icon(Icons.arrow_right, color: AppColors.appBlackColor),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10, right: 15),
//                           child: Divider(thickness: 2.0,color: AppColors.appBackgroundGreyColor),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0), // Set padding to match the first card
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Your Address",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6.0),
//                                   Text(
//                                     "Lorem ipsum dolor sit amet",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                       color: AppColors.appHeadingText,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               const Icon(Icons.arrow_right, color: AppColors.appBlackColor),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10, right: 15),
//                           child: Divider(thickness: 2.0,color: AppColors.appBackgroundGreyColor),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0), // Set padding to match the first card
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Social Security Number",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6.0),
//                                   Text(
//                                     "Lorem ipsum dolor sit amet",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                       color: AppColors.appHeadingText,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               const Icon(Icons.arrow_right, color: AppColors.appBlackColor),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10, right: 15),
//                           child: Divider(thickness: 2.0,color: AppColors.appBackgroundGreyColor),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0), // Set padding to match the first card
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Password",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6.0),
//                                   Text(
//                                     "Change or update password",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12.0,
//                                       fontFamily: Constants.Sofiafontfamily,
//                                       color: AppColors.appHeadingText,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               const Icon(Icons.arrow_right, color: AppColors.appBlackColor),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 10, right: 15),
//                           child: Divider(thickness: 2.0,color: AppColors.appBackgroundGreyColor),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0), // Set padding to match the first card
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10.0,bottom: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start, // Ensures it wraps tightly around the content
//                                       children: [
//                                         const Icon(
//                                           Icons.logout_outlined,
//                                           color: Colors.red,
//                                           size: 18.0,
//                                         ),
//                                         const SizedBox(width: 4.0),
//                                         Text(
//                                           "Logout",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14.0,
//                                             fontFamily: Constants.Sofiafontfamily,
//                                             color: Colors.red, // Set text color to red
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Column(
//               children: [
//                 Center(
//                   child: Text(
//                     "© 2024–2025",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12.0,
//                       color: AppColors.appHeadingText,
//                       fontFamily: Constants.Sofiafontfamily,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "Privacy Policy",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 10.0,
//                         color: AppColors.appBlackColor,
//                         fontFamily: Constants.Sofiafontfamily,
//                         decoration: TextDecoration.underline, // Underline the text
//                       ),
//                     ),
//                     Text(
//                       "Terms & Conditions",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 10.0,
//                         color: AppColors.appBlackColor,
//                         fontFamily: Constants.Sofiafontfamily,
//                         decoration: TextDecoration.underline, // Underline the text
//                       ),
//                     ),
//                     Text(
//                       "Contact",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 10.0,
//                         color: AppColors.appBlackColor,
//                         fontFamily: Constants.Sofiafontfamily,
//                         decoration: TextDecoration.underline, // Underline the text
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10.0),
//                 Center(
//                   child: Text(
//                     "Users are advised to read the terms and conditions carefully.",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 10.0,
//                       color: AppColors.appHeadingText,
//                       fontFamily: Constants.Sofiafontfamily,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
