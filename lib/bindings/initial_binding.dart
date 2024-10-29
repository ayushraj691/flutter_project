import 'package:get/get.dart';
import 'package:paycron/controller/all_company_controller/all_bussiness_controller.dart';
import 'package:paycron/controller/auth/authController.dart';
import 'package:paycron/controller/common_controller.dart';
import 'package:paycron/controller/dashboard/create_payment_controller.dart';
import 'package:paycron/controller/dashboard/overallStatistic_controller.dart';
import 'package:paycron/controller/dashboard/report_overview_controller.dart';
import 'package:paycron/controller/dashboard/user_main_dashboard_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/Verified_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/all_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/cancel_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/delete_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/download_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/new_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/all_transaction_controller/reimbursement_transaction_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/CustomerDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/Inactive_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/active_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/add_customer_controller.dart';
import 'package:paycron/controller/drawer_Controller/customer_controller/all_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/Inactive_Product_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/ProductDetailViewController.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/active_product_controller.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/all_product_controller.dart';
import 'package:paycron/controller/variable_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register controllers here
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
    Get.put(NewTransactionController());
    Get.put(VerifiedTransactionController());
    Get.put(DownloadTransactionController());
    Get.put(CancelTransationController());
    Get.put(DeleteTransactionController());
    Get.put(ReimbursementTransactionController());
  }
}
