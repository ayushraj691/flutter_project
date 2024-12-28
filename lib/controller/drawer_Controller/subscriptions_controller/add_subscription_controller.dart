import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/create_payment_model/ReqSubscriptionPayment.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResCustomerListModel.dart';
import 'package:paycron/model/drawer_model/product_model/AddProductModel.dart';
import 'package:paycron/model/drawer_model/product_model/ResProductList.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/views/drawer_screen/subscriptions/dialog/scheduler_dialog.dart';
import 'package:paycron/views/drawer_screen/subscriptions/subscriptions_main_screen.dart';

class AddSubscriptionController extends GetxController{

  var variableController = Get.find<VariableController>();
  var schedulerController = Get.put(ScheduleController());

  Rx<TextEditingController> customerListTextController = TextEditingController().obs;
  Rx<TextEditingController> productQuantityTextController = TextEditingController(text: "1").obs;
  Rx<TextEditingController> productPricingTextController = TextEditingController().obs;
  Rx<TextEditingController> checkNumberTextController = TextEditingController().obs;
  Rx<TextEditingController> memoTextController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberTextController = TextEditingController().obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController productSearchController = TextEditingController();
  List<ResCustomerList> filteredCustomers =  <ResCustomerList>[].obs;
  List<ResProductList> filteredProduct =  <ResProductList>[].obs;
  bool isDropdownOpen = false;
  RxBool isProductDropdownOpen = false.obs;
  RxBool isVisibilityAccount = false.obs;
  var selectedSubscriptionMode = 1.obs;
  String selectedCustomer = "Select Customer";
  String selectedProduct = "Select Product";
  int selectedCount = 0;
  RxInt productSelectedCount = 0.obs;
  var productTotalAmount =0.0.obs;
  var totalAmount =0.0.obs;
  String customerId = '';
  String productId = '';
  String bankId = '';
  bool isSelected = false;



  Rx<bool> checkNoValid = true.obs;
  Rx<bool> memoValid = true.obs;

  var checkNoErrorMessage = null;
  var memoErrorMessage = null;

  final FocusNode checkNoFocusNode = FocusNode();
  final FocusNode memoFocusNode = FocusNode();


  bool customerValidation(BuildContext context) {
    if (checkNumberTextController.value.text.isEmpty) {
      checkNoValid = false.obs;
      checkNoErrorMessage = 'CheckNo is required';
      FocusScope.of(context).requestFocus(checkNoFocusNode);
      return false;
    }else if (memoTextController.value.text.isEmpty) {
      memoValid = false.obs;
      memoErrorMessage = 'Memo is required';
      FocusScope.of(context).requestFocus(memoFocusNode);
      return false;
    } else {
      checkNoValid = true.obs;
      memoValid = true.obs;
      return true;
    }
  }


  List<Items> finalProductList =
      List<Items>.empty(growable: true).obs;

  List<ResCustomerList> customerList =
      List<ResCustomerList>.empty(growable: true).obs;

  List<ResProductList> productList =
      List<ResProductList>.empty(growable: true).obs;

  final List<BankId> allBankList =
      <BankId>[].obs;

  List<AddProductModel> addProductList =
      List<AddProductModel>.empty(growable: true).obs;

  void calculateTotalAmount() {
    double total = 0.0;
    for (var product in addProductList) {
      total += double.tryParse(product.totalPrice) ?? 0.0; // Convert to double safely
    }
    totalAmount.value = total;
  }

  void addProductDetail(){
    addProductList.add(AddProductModel(
        productName: selectedProduct,
        qantity: productQuantityTextController.value.text,
        price: productPricingTextController.value.text,
        totalPrice: productTotalAmount.value.toString(),
        productId: productId));
  }



  void productDetailList() {
    for (int i = 0; i < addProductList.length; i++) {
      finalProductList.add(
        Items(
          id: "",
          sId: addProductList[i].productId,
          proId: addProductList[i].productId,
          proName: addProductList[i].productName,
          proQty: addProductList[i].qantity,
          proPrice: addProductList[i].price,
        ),
      );
    }
  }

  void removeAccountDetail(int index) {
    if (index >= 0 && index < addProductList.length) {
      addProductList.removeAt(index);
    }
  }

  void clearAllCustomer(){
    selectedCustomer = "Select Customer";
    memoTextController.value.clear();
    customerListTextController.value.clear();
    productPricingTextController.value.clear();
    checkNumberTextController.value.clear();
    accountNumberTextController.value.clear();
    addProductList.clear();
    finalProductList.clear();
    totalAmount = 0.0.obs;
    clearAllProduct();
  }

  void clearAllProduct() {
    productPricingTextController.value.clear();
    selectedProduct = "Select Product";
    productTotalAmount =0.0.obs;
    isVisibilityAccount = false.obs;
    isDropdownOpen = false;
  }

  Future<void> getCustomerList(String id) async {
    variableController.loading.value = true;
    debugPrint("************$id*************");
    try {
      var res = await ApiCall.getApiCall(MyUrls.customerList, CommonVariable.token.value, id);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");
      if (res != null) {
        variableController.loading.value = false;
        customerList.clear();
        allBankList.clear();
        if (res is List) {
          for (var item in res) {
            var customerListData = ResCustomerList.fromJson(item);
            customerList.add(customerListData);
          }
        } else if (res is Map<String, dynamic>) {
          var customerListData = ResCustomerList.fromJson(res);
          customerList.add(customerListData);
        } else {
          MyToast.toast("Unexpected data format");
        }
      } else {
        MyToast.toast("Failed to retrieve customer data");
        variableController.loading.value = false;
      }

    } catch (e) {
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
      variableController.loading.value = false;
    }
  }

  Future<void> getProductList(String id) async {
    variableController.loading.value = true;
    debugPrint("************$id*************");
    try {
      var res = await ApiCall.getApiCall(MyUrls.productList, CommonVariable.token.value, id);

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null) {
        variableController.loading.value = false;

        productList.clear();
        if (res is List) {
          for (var item in res) {
            var productListData = ResProductList.fromJson(item);
            productList.add(productListData);

          }
        } else if (res is Map<String, dynamic>) {
          var productListData = ResProductList.fromJson(res);
          productList.add(productListData);
        } else {
          MyToast.toast("Unexpected data format");
        }
      } else {
        MyToast.toast("Failed to retrieve product data");
        variableController.loading.value = false;
      }

    } catch (e) {
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
      variableController.loading.value = false;
    }
  }


  insertSubscriptionPaymentData() async {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    variableController.loading.value = true;
    ReqSubscriptionPayment reqSubscriptionPayment = ReqSubscriptionPayment(
        custId: customerId,
        bankId: bankId,
        payTotal: totalAmount.value,
        checkNo: checkNumberTextController.value.text,
        memo: memoTextController.value.text,
        subscriptionIsInvoice: isSelected==true?selectedSubscriptionMode==1?false:true:false,
        subscriptionInvoicePreapproved: isSelected==true?selectedSubscriptionMode==2?false:true:false,
        isSusbcription: true,
        subscriptionType: schedulerController.selectedFrequency.value.toLowerCase(),
        start: dateFormatter.format(schedulerController.customStartDate.value),
        subsCycle: schedulerController.cycleCount.value.toString(),
        end:dateFormatter.format(schedulerController.customEndDate.value),
        items: finalProductList);
    debugPrint(json.encode(reqSubscriptionPayment.toJson()));
    var res =
    await ApiCall.postApiCalltoken(MyUrls.addSubscription, reqSubscriptionPayment,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      clearAllCustomer();
      Get.off(const SubscriptionsScreen());
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
      Get.back();
    }
  }


}