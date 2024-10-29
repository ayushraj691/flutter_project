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

  bool nameValid = true;
  bool AccountNameValid = true;
  bool mobileValid = true;
  bool routingValid = true;
  bool AccountNumberValid = true;
  bool emailValid = true;
  bool ConfirmAccountNumberValid = true;
  bool suitAptValid = true;
  bool streetValid = true;
  bool countrytValid = true;
  bool stateValid = true;
  bool cityValid = true;
  bool zipcodeValid = true;

  var nameErrorMessage = null;
  var accountNameErrorMessage = null;
  var mobileErrorMessage = null;
  var routingErrorMessage = null;
  var accountNumberErrorMessage = null;
  var emailErrorMessage = null;
  var confirmAccountErrorMessage = null;
  var suitAptErrorMessage = null;
  var streetErrorMessage = null;
  var countryterrorMessage = null;
  var cityErrorMessage = null;
  var stateErrorMessage = null;
  var zipcodeErrorMessage = null;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode accountNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode routingFocusNode = FocusNode();
  final FocusNode accountNumberFocusNode = FocusNode();
  final FocusNode confirmAccountNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode suitAptFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode stateFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode zipcodeFocusNode = FocusNode();


  bool personValidation(){
    if(nameController.text.isEmpty){
      nameValid=false;
      nameErrorMessage =' Name is required';
      FocusScope.of(Get.context!).requestFocus(nameFocusNode);
      return false;
    }else if(mobileController.text.isEmpty){
      mobileValid = false;
      mobileErrorMessage = 'Mobile number is required';
      FocusScope.of(Get.context!).requestFocus(mobileFocusNode);
      return false;
    }else if (mobileController.text.length != 10) {
      mobileValid = false;
      mobileErrorMessage = 'Mobile Number must be 10 digits';
      FocusScope.of(Get.context!).requestFocus(mobileFocusNode);
      return false;
    }else if (emailController.text.isEmpty) {
      emailValid = false;
      emailErrorMessage = 'Email is required';
      FocusScope.of(Get.context!).requestFocus(emailFocusNode);
      return false;
    }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)){
      emailValid = false;
      emailErrorMessage = 'Invalid Email';
      FocusScope.of(Get.context!).requestFocus(emailFocusNode);
      return false;
    }
    else{
      return true;
    }
  }

  bool validation() {
    if (accountHolderNameController.text.isEmpty) {
      AccountNameValid = false;
      accountNameErrorMessage = 'Account Holder Name is required';
      FocusScope.of(Get.context!).requestFocus(accountNameFocusNode);
      return false;
    }else if (routingNumberController.text.isEmpty) {
      routingValid = false;
      routingErrorMessage = 'Routing Number cannot be empty';
      FocusScope.of(Get.context!).requestFocus(routingFocusNode);
      return false;
    }else if (routingNumberController.text.length != 9) {
      routingValid = false;
      routingErrorMessage = 'Routing Number must be 9 digits';
      FocusScope.of(Get.context!).requestFocus(routingFocusNode);
      return false;
    }else if (!routingValid) {
      routingValid = false;
      routingErrorMessage = 'Invalid Routing number';
      FocusScope.of(Get.context!).requestFocus(routingFocusNode);
      return false;
    }else if (accountNumberController.text.isEmpty) {
      AccountNumberValid = false;
      accountNumberErrorMessage = 'Account number is required';
      FocusScope.of(Get.context!).requestFocus(accountNumberFocusNode);
      return false;
    }else if (accountNumberController.text.length > 15) {
      AccountNumberValid = false;
      accountNumberErrorMessage = 'Account number must be 15 digits or less';
      FocusScope.of(Get.context!).requestFocus(accountNumberFocusNode);
      return false;
    }else if (confirmAccountNumberController.text.isEmpty) {
      ConfirmAccountNumberValid = false;
      confirmAccountErrorMessage = 'Confirm Account number is required';
      FocusScope.of(Get.context!).requestFocus(confirmAccountNumberFocusNode);
      return false;
    }else if (confirmAccountNumberController.text != accountNumberController.text.trim()) {
      ConfirmAccountNumberValid = false;
      confirmAccountErrorMessage = 'Account Number & Confirm Account Number should be the same';
      FocusScope.of(Get.context!).requestFocus(confirmAccountNumberFocusNode);
      return false;
    } else if (confirmAccountNumberController.text.length > 15) {
      ConfirmAccountNumberValid = false;
      confirmAccountErrorMessage = 'Confirm Account number must be 15 digits or less';
      FocusScope.of(Get.context!).requestFocus(confirmAccountNumberFocusNode);
      return false;
    }else if (suitAptController.text.isEmpty) {
      suitAptValid = false;
      suitAptErrorMessage = 'Suit/Apt is required';
      FocusScope.of(Get.context!).requestFocus(suitAptFocusNode);
      return false;
    }else if (streetController.text.isEmpty) {
      streetValid = false;
      streetErrorMessage = 'Street is required';
      FocusScope.of(Get.context!).requestFocus(streetFocusNode);
      return false;
    }else if (countryController.text.isEmpty) {
      countrytValid = false;
      countryterrorMessage = 'Country is required';
      FocusScope.of(Get.context!).requestFocus(countryFocusNode);
      return false;
    }else if (stateController.text.isEmpty) {
      stateValid = false;
      stateErrorMessage = 'State is required';
      FocusScope.of(Get.context!).requestFocus(stateFocusNode);
      return false;
    }else if (cityController.text.isEmpty) {
      cityValid = false;
      cityErrorMessage = 'City is required';
      FocusScope.of(Get.context!).requestFocus(cityFocusNode);
      return false;
    }else if (zipController.text.isEmpty) {
      zipcodeValid = false;
      zipcodeErrorMessage = 'Zip Code is required';
      FocusScope.of(Get.context!).requestFocus(zipcodeFocusNode);
      return false;
    }else{
      return true;
    }
  }

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
      bool isPrimaryDeleted = accountDetailsList[index].primary;
      accountDetailsList.removeAt(index);
      if (isPrimaryDeleted && accountDetailsList.isNotEmpty) {
        accountDetailsList[0].primary = true;
      }
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
        variableController.loading.value = false;
        MyToast.toast("customer add successful");
        accountDetailsList.clear();
        clearAllCustomer();
        clearAllAccount();
        Get.back();
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  validateRoutingNumber(String routingNumber) async {
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
        isRoutingNumberValid = true.obs;
        bankName.value = resCheckRoutingNo.customerName??"";
        postalCode.value = resCheckRoutingNo.zip??"";
        bankAddress.value = resCheckRoutingNo.address??"";
        state.value = resCheckRoutingNo.state??"";
        city.value = resCheckRoutingNo.city??"";
        routingValid=true;
      }else{
        routingErrorMessage=resCheckRoutingNo.message.toString();
        routingValid=false;
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