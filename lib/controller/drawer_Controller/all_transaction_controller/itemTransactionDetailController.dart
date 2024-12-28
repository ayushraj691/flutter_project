import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/transaction_model/ResSinglePayment.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class ItemTransactionDetailsController extends GetxController{
  var variableController = Get.find<VariableController>();

  final List<ResSinglePayment> allSinglePaymentDataList =
      <ResSinglePayment>[].obs;

  final List<ProDetail> allProductList =
      <ProDetail>[].obs;


  ///---------------------Transaction Detail--------------------
  var checkNo = 0.obs;
  var memo = "".obs;
  var status = "".obs;
  var date = "".obs;
  var transactionId = "".obs;
  var amount = 0.obs;
  var customerName = "".obs;
  var customerMobileNo = "".obs;
  var customerEmailId = "".obs;
  var businessName = "".obs;
  var businessEmail = "".obs;
  var businessNumber = "".obs;
  var accountNumber = "".obs;
  var routingNumber = "".obs;
  var bankName = "".obs;
  var payStatus = "".obs;
  var payMode = "".obs;
  var recurring = "".obs;
  var scheduledDate = "".obs;
  var subscriptionType = "".obs;
  var mode = "".obs;
  var isDeleted = false.obs;
  var isSchedule = false.obs;
  var isDeletedRequest = false.obs;
  var downloadByMerchant = false.obs;
  var verificationStatus = false.obs;
  var decorationColor = AppColors.appLightBlueColor.obs;


  Future<void> getSingleData(String id) async {
    variableController.loading.value = true;

    try {
      var res = await ApiCall.getApiCall(MyUrls.singlePayment, CommonVariable.token.value, id);

      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");

      if (res != null && res is Map<String, dynamic>) {
        variableController.loading.value = false;

        allSinglePaymentDataList.clear();
        allProductList.clear();

        var singleCustomerData = ResSinglePayment.fromJson(res);
        allSinglePaymentDataList.add(singleCustomerData);
        checkNo.value=allSinglePaymentDataList[0].checkNo;
        memo.value=allSinglePaymentDataList[0].memo;
        transactionId.value=allSinglePaymentDataList[0].txnNumber;
        customerName.value=allSinglePaymentDataList[0].custId.info.custName;
        customerMobileNo.value=allSinglePaymentDataList[0].custId.info.mobile;
        customerEmailId.value=allSinglePaymentDataList[0].custId.info.email;
        businessName.value=allSinglePaymentDataList[0].businessId.businessDetail.businessName;
        businessEmail.value=allSinglePaymentDataList[0].businessId.businessDetail.businessEmail;
        businessNumber.value=allSinglePaymentDataList[0].businessId.businessDetail.businessPhone;
        accountNumber.value=allSinglePaymentDataList[0].bankId.accountNumber;
        routingNumber.value=allSinglePaymentDataList[0].bankId.routingNumber;
        bankName.value=allSinglePaymentDataList[0].bankId.bankName;
        amount.value=allSinglePaymentDataList[0].payTotal;
        payStatus.value=allSinglePaymentDataList[0].payStatus;
        payMode.value=allSinglePaymentDataList[0].payMode;
        isDeleted.value=allSinglePaymentDataList[0].isDeleted;
        isSchedule.value=allSinglePaymentDataList[0].isSchedule;
        subscriptionType.value=allSinglePaymentDataList[0].subscriptionType;
        recurring.value=allSinglePaymentDataList[0].subscriptionInfo.subsCycle;
        DateTime schedularDateTime = DateTime.parse(
          (allSinglePaymentDataList[0].subscriptionInfo.start == null ||
              allSinglePaymentDataList[0].subscriptionInfo.start.isEmpty)
              ? allSinglePaymentDataList[0].createdOn
              : allSinglePaymentDataList[0].subscriptionInfo.start,
        ).toLocal();
        String schedularFormatedDate = DateFormat('dd MMM, yyyy').format(schedularDateTime);
        scheduledDate.value=schedularFormatedDate;
        isDeletedRequest.value=allSinglePaymentDataList[0].isDeletedRequest;
        downloadByMerchant.value=allSinglePaymentDataList[0].downloadBymerchant;
        verificationStatus.value=allSinglePaymentDataList[0].verificationStatus;
        DateTime dateTime = DateTime.parse(allSinglePaymentDataList[0].createdOn).toLocal();
        String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
        date.value=formattedDate;
        updateDecorationColor();
        if (allSinglePaymentDataList.isNotEmpty) {
          for (var product in allSinglePaymentDataList[0].products) {
            allProductList.add(product.proDetail);
          }
        }
      } else {
        MyToast.toast("Failed to retrieve payment data");
        variableController.loading.value = false;
      }

    } catch (e) {
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
      variableController.loading.value = false;
    }
  }


  void updateDecorationColor() {
    if(isSchedule.value && payMode == '0'){
      decorationColor.value = AppColors.appOrangeLightColor;
    }
    else if (!isDeleted.value && isDeletedRequest.value && !['5', '6', '7'].contains(payStatus.value)) {
      decorationColor.value = AppColors.appTextGreyColor;
    } else if (isDeletedRequest.value && isDeleted.value) {
      decorationColor.value = AppColors.appMistyRoseColor;
    } else if (!isDeletedRequest.value && isDeleted.value) {
      decorationColor.value = AppColors.appMistyRoseColor;
    } else if (payStatus.value == '5' && !isDeletedRequest.value && !isDeleted.value) {
      decorationColor.value = AppColors.appRedLightColor;
    } else if (payStatus.value == '6' && !isDeletedRequest.value && !isDeleted.value && downloadByMerchant.value) {
      decorationColor.value = AppColors.appMintGreenColor;
    } else if (payStatus.value == '7' && !isDeletedRequest.value && !isDeleted.value && downloadByMerchant.value) {
      decorationColor.value = AppColors.appRedLightColor;
    } else if (!isDeleted.value && !isDeletedRequest.value && downloadByMerchant.value && !['5', '6', '7'].contains(payStatus.value)) {
      decorationColor.value = AppColors.appLightBlueColor;
    } else if (verificationStatus.value && !isDeleted.value && !isDeletedRequest.value && !downloadByMerchant.value && payStatus.value != '5') {
      decorationColor.value = AppColors.appGreenLightColor;
    } else if (payStatus.value == '0' && !verificationStatus.value && !isDeleted.value && !isDeletedRequest.value && !downloadByMerchant.value) {
      decorationColor.value = AppColors.appSoftSkyBlueColor;
    } else if (payStatus.value == '4' && !verificationStatus.value && !isDeleted.value && !isDeletedRequest.value && !downloadByMerchant.value) {
      decorationColor.value = AppColors.appLightYellowColor;
    } else if (payStatus.value == '3' && !verificationStatus.value && !isDeleted.value && !isDeletedRequest.value && !downloadByMerchant.value) {
      decorationColor.value = AppColors.appMintGreenColor;
    } else {
      decorationColor.value = AppColors.appLightBlueColor;
    }
  }
}

