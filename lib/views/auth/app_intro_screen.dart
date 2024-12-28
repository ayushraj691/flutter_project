import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/utils/color_constants.dart';
import 'dart:async';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/auth/login_screen.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});

  @override
  _AppIntroScreenState createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    ImageAssets.introBannerFirst,
    ImageAssets.introBannerSecond,
    ImageAssets.introBannerThird,
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _images[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                // Page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _images.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: 10.0,
                      width: _currentPage == index ? 20.0 : 10.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ?AppColors.appBlueColor
                            : AppColors.appIntroIndicatorColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Users are advised to read the terms and conditions or \nprivacy policy carefully.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Sofia Sans',
                      color: AppColors.appGreyColor,
                    ),
                  ),
                  const SizedBox(height: 60.0), // Space between text and button
                  ElevatedButton(
                    onPressed: () {
                      Get.off(const LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                      backgroundColor: AppColors.appBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Sofia Sans',
                        color: AppColors.appWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
