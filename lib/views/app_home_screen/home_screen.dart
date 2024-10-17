import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/views/dashboard/bottom_nav_bar_screen.dart';
import 'package:paycron/views/widgets/common_button.dart';
import '../../utils/image_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0,left: 8.0,right: 8.0,bottom: 8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,  // Align the Row to the top left
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,  // Ensure Row items are aligned to the top
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 40,
                        backgroundImage: AssetImage(ImageAssets.profile),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,  // Align text vertically
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 1,
                color: AppColors.appBlueLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageAssets.frame),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Hello ${CommonVariable.userName.value}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.appBlueColor,
                                    fontSize: 24,
                                    fontFamily: 'Sofia Sans',
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Welcome to Merchant Dashboard!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.appBlackColor,
                                    fontSize: 18,
                                    fontFamily: 'Sofia Sans',
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0), // Updated to horizontal padding
                              child: Center(
                                child: Text(
                                  "Our dashboard exemplifies these principles, providing a centralized, intuitive platform for managing all your payment processing needs. Experience seamless integration with your existing business tools, enhanced security measures, and a user-friendly design that makes managing your payments simple and efficient.",
                                  style: TextStyle(
                                    color: AppColors.appBlackColor,
                                    fontSize: 14,
                                    fontFamily: 'Sofia Sans',
                                    fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.center,  // Ensures the text is centered
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,)
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Center(
                            //     child: CommonButton(
                            //       buttonWidth: screenWidth,
                            //       icon: Icons.add_circle,
                            //       buttonName: "Add First Company",
                            //       onPressed: () {},
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Elevate Your Operations with Your New Business Headquarter",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.appBlackColor,
                    fontSize: 20,
                    fontFamily: 'Stolzl',
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft, // Align the button to the start (left)
              //     child: Container(
              //       width: MediaQuery.of(context).size.width / 2, // 50% of the screen width
              //       child: CommonButtonImage(
              //         borderColor: AppColors.appBlackColor,
              //         textColor: AppColors.appBlackColor,
              //         buttonColor: Colors.transparent,
              //         buttonName: "See Documentation",
              //         imagePath: ImageAssets.circleForwardIcon,
              //         onPressed: () {},  buttonWidth: MediaQuery.of(context).size.width * 0.45,
              //         // Remove or adjust buttonWidth to avoid fixed size overflow
              //         // buttonWidth: 320.0, // You can comment this line or adjust the size
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16.0,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth * 0.5, // Set button width to 50% of screen width
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor, // Button background color
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    border: Border.all(
                      color: AppColors.appBlackColor, // Button border color
                      width: 1.0, // Border thickness
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {}, // Button press callback
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Transparent to show container color
                      shadowColor: Colors.transparent, // Remove button shadow
                      padding: const EdgeInsets.symmetric(vertical: 12), // Button height padding
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content
                      children: [
                        // Button text
                        const Text(
                          'See documentation',
                          style: TextStyle(
                            fontFamily: 'Sofia Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.appBlackColor, // Text color
                          ),
                        ),
                        // Spacer between text and icon
                        const SizedBox(width: 8),
                        // Icon or image next to text
                        Image.asset(
                          ImageAssets.circleForwardIcon, // Icon asset path
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Id ipsum sapien nulla non molestie tempus. Lectus neque ultrices mauris in rutrum. Sapien est dui nam nunc consectetur massa amet eget volutpat. At volutpat massa cursus aliquam. Dui arcu leo aliquam a. Dui quis habitasse congue et sem nulla et. Augue nunc ultricies tortor eget \n"
                      "Volutpat sem adipiscing quam facilisi id fermentum elementum nunc rutrum. Enim pellentesque lectus dictumst tellus luctus. ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2, // The number of items
                  itemBuilder: (context, index) {
                    return ListItemWidget(index: index); // Using separate class
                  },
                ),
              ),
              Card(
                elevation: 1,
                color: AppColors.appBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0), // Padding inside the card
                  width: screenWidth ,
                  child: Column(
                    children: [
                      const Text(
                        "Not sure which solution is best for you?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlackColor,
                          fontSize: 20,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Center(
                        child: SizedBox(
                          width: screenWidth * 2/3,
                          child: CommonButtonImage(
                            borderColor: Colors.white,
                            buttonWidth: screenWidth,
                            textColor: AppColors.appBlackColor,
                            buttonColor: Colors.white,
                            buttonName: "Talk To Support Team",
                            imagePath: ImageAssets.circleForwardIcon,
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final int index;

  const ListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 1,
          color: AppColors.appBlueLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            // Use MediaQuery to make the card width responsive
            padding: const EdgeInsets.all(16.0), // Padding inside the card
            width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width for better adaptability
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
              children: [
                const Text(
                  "- Watch the tutorial to\nlearn more.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // Replace with AppColors.appBlackColor
                    fontSize: 18.0,
                    fontFamily: 'Sofia Sans',
                  ),
                  textAlign: TextAlign.left, // Align text to the left
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet consectetur. Nibh quis semper arcu pellentesque commodo venenatis. Turpis convallis tempus quis libero eget vestibulum.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.appBlackColor,
                      fontSize: 14,
                      fontFamily: 'Sofia Sans',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align the button to the start (left)
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width for button
                      child: CommonButtonImage(
                        borderColor: AppColors.appBlackColor,
                        buttonWidth: 50.0, // Adjust the button width if needed
                        buttonColor: AppColors.appBlackColor,
                        buttonName: "Watch Tutorial",
                        imagePath: ImageAssets.playIcon,
                        onPressed: () {},
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      ImageAssets.tracedIcon,
                      width: MediaQuery.of(context).size.width * 0.2, // Set icon size based on screen width
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
