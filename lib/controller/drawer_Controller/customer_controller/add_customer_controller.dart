import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqAddCustomer.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqRougtingNoModel.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqSingleAccount.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResAllCustomerModel.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResRougtingNoModel.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

class AddCustomerController extends GetxController{
  var variableController = Get.find<VariableController>();

  ///----------------------Bank Detail Variables-----------------------

  RxString bankName = "".obs;
  RxString bankAddress = "".obs;
  RxString postalCode = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;

  ///----------------------Personal Detail Controller-----------------------

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  ///---------------Account Details Controller----------------------
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController suitAptController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  bool isSwitched=false;
  List<Items> accountDetailsList = List<Items>.empty(growable: true).obs;
  var isRoutingNumberValid = false.obs;


  void addAccountDetail() {
    if (isSwitched) {
      for (var item in accountDetailsList) {
        if (item.primary) {
          item.primary = false;
        }
      }
    }

    accountDetailsList.add(Items(
        primary: isSwitched,
        accountName: accountHolderNameController.value.text.trim(),
        accountNumber: accountNumberController.value.text.trim(),
        confirmAccountNumber: confirmAccountNumberController.value.text.trim(),
        routingNumber: routingNumberController.value.text.trim(),
        address: streetController.value.text.trim(),
        apartment: suitAptController.value.text.trim(),
        city: cityController.value.text.trim(),
        country: countryController.value.text.trim(),
        state: stateController.value.text.trim(),
        postalCode: zipController.value.text.trim())
    );
  }

  void removeAccountDetail(int index) {
    if (index >= 0 && index < accountDetailsList.length) {
      accountDetailsList.removeAt(index);
    } else {
      print("Index out of range");
    }
  }
  void clearAllAccount() {
    accountHolderNameController.clear();
    routingNumberController.clear();
    accountNumberController.clear();
    confirmAccountNumberController.clear();
    suitAptController.clear();
    streetController.clear();
    countryController.clear();
    stateController.clear();
    cityController.clear();
    zipController.clear();
    isSwitched=false;
    bankName = "".obs;
    bankAddress = "".obs;
    postalCode = "".obs;
    state = "".obs;
    city = "".obs;
    isRoutingNumberValid = false.obs;
  }


  void clearAllCustomer() {
    nameController.clear();
    mobileController.clear();
    emailController.clear();
    descriptionController.clear();
  }

  insertCustomerData() async {
    variableController.loading.value = true;
    ReqAddcustomerDetails reqAddcustomerDetails = ReqAddcustomerDetails(
        description: descriptionController.value.text.trim(),
        mobile: mobileController.value.text.trim(),
        email: emailController.value.text.trim(),
        custName: nameController.value.text.trim(),
        items: accountDetailsList);
    debugPrint(json.encode(reqAddcustomerDetails.toJson()));
    var res =
        await ApiCall.postApiCalltoken(MyUrls.addCustomer, reqAddcustomerDetails,CommonVariable.token.value,CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResAddCustomer resAddCustomer = ResAddCustomer.fromJson(res);
      if(resAddCustomer.code==200){
        MyToast.toast("customer add successful");
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  validateRoutingNumber(String routingNumber) async{
    variableController.loading.value = true;
    ReqCheckRoutingNo reqCheckRoutingNo = ReqCheckRoutingNo(routingNumber: routingNumber);
    debugPrint(json.encode(reqCheckRoutingNo.toJson()));
    var res =
    await ApiCall.postApiCall(MyUrls.checkRoutingNumber, reqCheckRoutingNo,CommonVariable.token.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResCheckRoutingNo resCheckRoutingNo = ResCheckRoutingNo.fromJson(res);
      if(resCheckRoutingNo.code==200){
        MyToast.toast(resCheckRoutingNo.message.toString());
        isRoutingNumberValid = true.obs;
        bankName.value = resCheckRoutingNo.customerName??"";
        postalCode.value = resCheckRoutingNo.zip??"";
        bankAddress.value = resCheckRoutingNo.address??"";
        state.value = resCheckRoutingNo.state??"";
        city.value = resCheckRoutingNo.city??"";
      }else{
        MyToast.toast(resCheckRoutingNo.message.toString());
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  addSingleAccount(String id) async{
    variableController.loading.value = true;
    ReqSingleAccount reqSingleAccount = ReqSingleAccount(
        primary: isSwitched,
        accountName: accountHolderNameController.text.trim(),
        accountNumber: accountNumberController.text.trim(),
        routingNumber: routingNumberController.text.trim(),
        apartment: suitAptController.value.text.trim(),
        address: streetController.value.text.trim(),
        country: countryController.value.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        postalCode: zipController.text.trim());
    debugPrint(json.encode(reqSingleAccount.toJson()));
    var res =
    await ApiCall.postApiCalltoken(MyUrls.addSingleAccount, reqSingleAccount,CommonVariable.token.value,id);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResAddCustomer resAddCustomer = ResAddCustomer.fromJson(res);
      if(resAddCustomer.code==200){
        MyToast.toast("Account add successful");
        clearAllAccount();
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }

  }

}