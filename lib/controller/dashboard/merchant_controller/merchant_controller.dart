import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/profileModel/ResSingleUser.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class MerchantController extends GetxController {
  var variableController = Get.find<VariableController>();

  RxString Id = ''.obs;
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  RxString emailId = ''.obs;
  RxBool isVerfied = false.obs;
  RxString password = "".obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  RxString phoneNo = ''.obs;
  RxString image = "".obs;
  RxString role = "".obs;
  RxString position = "".obs;
  RxBool isDeleted = false.obs;
  RxBool isDeletedRequest = false.obs;
  RxBool isDeletedSuper = false.obs;
  RxBool isAgreed = false.obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  RxString lastUpdated = "".obs;
  RxString createdOn = "".obs;
  RxString ssnUpload = ''.obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> pinCode = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> streetAddress = TextEditingController().obs;
  Rx<TextEditingController> ssnNumber = TextEditingController().obs;

  getSingleUser(String id) async {
    variableController.loading.value = true;
    debugPrint("************$id*************");
    try {
      var res = await ApiCall.getApiCall(
          MyUrls.singleUser, CommonVariable.token.value, id);
      debugPrint("*************************");
      debugPrint("API Response: $res");
      debugPrint("*************************");
      if (res != null) {
        variableController.loading.value = false;
        ResSingleUser resSingleUser = ResSingleUser.fromJson(res);
        Id.value = (resSingleUser.sId ?? '');
        fullName.value.text = (resSingleUser.fullName ?? '');
        email.value.text = (resSingleUser.email ?? '');
        emailId.value = (resSingleUser.email ?? '');
        isVerfied.value = resSingleUser.isVerfied!;
        password.value = (resSingleUser.password ?? '');
        phone.value.text = (resSingleUser.phone ?? '');
        phoneNo.value = (resSingleUser.phone ?? '');
        image.value = (resSingleUser.image ?? '');
        role.value = (resSingleUser.role ?? "");
        position.value = (resSingleUser.position ?? "");
        isDeleted.value = resSingleUser.isDeleted!;
        isDeletedRequest.value = resSingleUser.isDeletedRequest!;
        isDeletedSuper.value = resSingleUser.isDeletedSuper!;
        isAgreed.value = resSingleUser.isAgreed!;
        DateTime dateTime = DateTime.parse(resSingleUser.dob!).toLocal();
        String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
        dob.value.text = formattedDate;
        lastUpdated.value = (resSingleUser.lastUpdated ?? '');
        createdOn.value = (resSingleUser.createdOn ?? '');
        ssnNumber.value.text = (resSingleUser.ssn.ssnNumber ?? '');
        ssnUpload.value = (resSingleUser.ssn.ssnUpload ?? '');
        country.value.text = (resSingleUser.location.country ?? '');
        state.value.text = (resSingleUser.location.state ?? '');
        pinCode.value.text = (resSingleUser.location.postalcode ?? '');
        city.value.text = (resSingleUser.location.city ?? '');
        streetAddress.value.text = (resSingleUser.location.address ?? '');
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
}
