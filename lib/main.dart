import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/auth/authController.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/controller/dashboard/overallStatistic_controller.dart';
import 'package:paycron/controller/dashboard/report_overview_controller.dart';
import 'package:paycron/controller/dashboard/user_main_dashboard_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/all_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/Inactive_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/active_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/all_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/Inactive_Product_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/ProductDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/active_product_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/all_product_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/splash/splash_screen.dart';
import 'controller/common_controller.dart';
import 'controller/variable_controller.dart';

void main() {
  Get.put(VariableController());
  Get.put(CommonController());
  Get.put(OverallStatisticController());
  Get.put(ReportOverviewController());
  Get.put(AuthController());
  Get.put(AllBussinessController());
  Get.put(MainDashboardController());
  Get.put(CreatePaymentController());
  Get.put(AllTabController());
  Get.put(ActiveController());
  Get.put(InActiveController());
  Get.put(CustomerDetailViewController());
  Get.put(AddCustomerController());
  Get.put(AllTabProductController());
  Get.put(ActiveProductController());
  Get.put(InActiveProductController());
  Get.put(ProductDetailViewController());
  Get.put(AllTransactionController());


  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.appWhiteColor));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pay cron',
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(seedColor: AppColors.appBlueColor),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.appWhiteColor,
        ),
        scaffoldBackgroundColor: AppColors.appWhiteColor,
      ),
      home: const SplashScreen(),
    );
  }
}


