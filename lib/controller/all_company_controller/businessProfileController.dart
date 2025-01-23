import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/all_bussiness_model/ResBusinessData.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class BusinessProfileController extends GetxController {
  var variableController = Get.find<VariableController>();

  ///---------------------Business Detail---------------
  RxString legalBusinessName = "".obs;
  RxString completeBusinessAddress = "".obs;
  RxString businessLicense = "".obs;
  RxString employerIdentificationNumber = "".obs;
  RxString industry = "".obs;
  RxString businessWebsite = "".obs;
  RxString productDescription = "".obs;

  ///---------------------Principal Owner---------------

  RxString planName = "".obs;
  RxString planDescription = "".obs;
  RxString monthlyFees = "".obs;
  RxString perSwipeFees = "".obs;
  RxString setupFees = "".obs;
  RxString verificationFees = "".obs;
  RxString processingFee = "".obs;

  ///---------------------Bank Details---------------

  RxString accountHolderName = "".obs;
  RxString routingNumber = "".obs;
  RxString accountNumber = "".obs;

  ///---------------------Support Information---------------

  RxString officialBusinessEmail = "".obs;
  RxString officialBusinessPhone = "".obs;
  RxString customerSupportEmail = "".obs;
  RxString customerSupportPhone = "".obs;

  Future<void> getBusinessData() async {
    variableController.loading.value = true;
    try {
      var res = await ApiCall.getApiCall(MyUrls.singleBusiness,
          CommonVariable.token.value, CommonVariable.businessId.value);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");
      if (res != null) {
        var businessData = ResBusinessData.fromJson(res);
        variableController.loading.value = false;

        ///---------------------Business Detail---------------

        legalBusinessName.value =
            (businessData.record?.businessDetail?.businessName ?? "");
        completeBusinessAddress.value =
            "${(businessData.record?.businessDetail?.location?.address ?? '')}, ${(businessData.record?.businessDetail?.location?.country ?? '')}, ${(businessData.record?.businessDetail?.location?.state ?? '')}, ${(businessData.record?.businessDetail?.location?.city ?? "")}, ${(businessData.record?.businessDetail?.location?.postalcode ?? '')}";
        businessLicense.value =
            (businessData.record?.businessDetail?.license?.number ?? "");
        employerIdentificationNumber.value =
            (businessData.record?.businessDetail?.ein?.number ?? '');
        industry.value = (businessData.record?.businessDetail?.industry ?? '');
        businessWebsite.value =
            (businessData.record?.businessDetail?.website ?? '');
        productDescription.value =
            (businessData.record?.businessDetail?.description ?? '');

        ///---------------------Principal Owner---------------
        planName.value = (businessData.planDetials?.name ?? '');
        planDescription.value = (businessData.planDetials?.details ?? '');
        monthlyFees.value =
            (businessData.planDetials?.monthlyPrice.toString() ?? '');
        perSwipeFees.value =
            (businessData.planDetials?.planPrices?.perSwipeFee?.join(' ') ??
                '');
        setupFees.value =
            (businessData.planDetials?.setupPrice.toString() ?? '');
        verificationFees.value =
            (businessData.planDetials?.planPrices?.verificationFee?.join(' ') ??
                '');
        processingFee.value =
            (businessData.planDetials?.planPrices?.processingFees?.join(' ') ??
                '');

        ///---------------------Bank Details---------------
        accountHolderName.value =
            (businessData.record?.bankDetails?.accountName ?? '');
        accountNumber.value =
            (businessData.record?.bankDetails?.accountNumber ?? '');
        routingNumber.value =
            (businessData.record?.bankDetails?.routingNumber ?? '');

        ///---------------------Support Information---------------
        officialBusinessEmail.value =
            (businessData.record?.businessDetail?.businessEmail ?? '');
        officialBusinessPhone.value =
            (businessData.record?.businessDetail?.businessPhone ?? '');
        customerSupportEmail.value =
            (businessData.record?.support?.supportEmail ?? '');
        customerSupportPhone.value =
            (businessData.record?.support?.phone ?? '');
      } else {
        variableController.loading.value = false;
        MyToast.toast("Failed to retrieve Business data");
      }
    } catch (e) {
      variableController.loading.value = false;
      debugPrint("Error occurred: $e");
      MyToast.toast("Something Went Wrong: ${e.toString()}");
    }
  }
}
