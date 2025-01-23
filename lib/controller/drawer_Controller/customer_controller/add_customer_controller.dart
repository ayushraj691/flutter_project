import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqAddCustomer.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqRougtingNoModel.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ReqSingleAccount.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResAllCustomerModel.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/ResRougtingNoModel.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/updateModel/ReqUpdateBankDetail.dart';
import 'package:paycron/model/drawer_model/insertCustomerData/updateModel/ReqUpdateCustomer.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/my_toast.dart';

import 'all_controller.dart';

class AddCustomerController extends GetxController {
  var variableController = Get.find<VariableController>();
  var allTabController = Get.find<AllTabController>();

  ///----------------------Bank Detail Variables-----------------------

  RxString bankName = "".obs;
  RxString bankAddress = "".obs;
  RxString postalCode = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;
  String selectedCountryCode = '+1';

  ///----------------------Personal Detail Controller-----------------------

  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> mobileController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> descriptionController =
      TextEditingController().obs;

  ///---------------Account Details Controller----------------------
  Rx<TextEditingController> accountHolderNameController =
      TextEditingController().obs;
  TextEditingController routingNumberController = TextEditingController();
  Rx<TextEditingController> accountNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmAccountNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> suitAptController = TextEditingController().obs;
  Rx<TextEditingController> streetController = TextEditingController().obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> zipController = TextEditingController().obs;

  Rx<bool> nameValid = true.obs;
  Rx<bool> AccountNameValid = true.obs;
  Rx<bool> mobileValid = true.obs;
  Rx<bool> routingValid = true.obs;
  Rx<bool> AccountNumberValid = true.obs;
  Rx<bool> emailValid = true.obs;
  Rx<bool> ConfirmAccountNumberValid = true.obs;
  Rx<bool> suitAptValid = true.obs;
  Rx<bool> streetValid = true.obs;
  Rx<bool> countrytValid = true.obs;
  Rx<bool> stateValid = true.obs;
  Rx<bool> cityValid = true.obs;
  Rx<bool> zipcodeValid = true.obs;

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

  bool personValidation(BuildContext context) {
    if (nameController.value.text.isEmpty) {
      nameValid = false.obs;
      nameErrorMessage = 'Name is required';
      FocusScope.of(context).requestFocus(nameFocusNode);
      return false;
    } else if (mobileController.value.text.isEmpty) {
      mobileValid = false.obs;
      mobileErrorMessage = 'Mobile number is required';
      FocusScope.of(context).requestFocus(mobileFocusNode);
      return false;
    } else if (mobileController.value.text.length != 10) {
      mobileValid = false.obs;
      mobileErrorMessage = 'Mobile Number must be 10 digits';
      FocusScope.of(context).requestFocus(mobileFocusNode);
      return false;
    } else if (emailController.value.text.isEmpty) {
      emailValid = false.obs;
      emailErrorMessage = 'Email is required';
      FocusScope.of(context).requestFocus(emailFocusNode);
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.value.text)) {
      emailValid = false.obs;
      emailErrorMessage = 'Invalid Email';
      FocusScope.of(context).requestFocus(emailFocusNode);
      return false;
    } else {
      nameValid = true.obs;
      mobileValid = true.obs;
      emailValid = true.obs;
      return true;
    }
  }

  bool validation(BuildContext context) {
    if (accountHolderNameController.value.text.isEmpty) {
      AccountNameValid = false.obs;
      accountNameErrorMessage = 'Account Holder Name is required';
      FocusScope.of(context).requestFocus(accountNameFocusNode);
      return false;
    } else if (routingNumberController.value.text.isEmpty) {
      routingValid = false.obs;
      routingErrorMessage = 'Routing Number cannot be empty';
      FocusScope.of(context).requestFocus(routingFocusNode);
      return false;
    } else if (routingNumberController.value.text.length != 9) {
      routingValid = false.obs;
      routingErrorMessage = 'Routing Number must be 9 digits';
      FocusScope.of(context).requestFocus(routingFocusNode);
      return false;
    } else if (!routingValid.value) {
      routingValid = false.obs;
      routingErrorMessage = 'Invalid Routing number';
      FocusScope.of(context).requestFocus(routingFocusNode);
      return false;
    } else if (accountNumberController.value.text.isEmpty) {
      AccountNumberValid = false.obs;
      accountNumberErrorMessage = 'Account number is required';
      FocusScope.of(context).requestFocus(accountNumberFocusNode);
      return false;
    } else if (accountNumberController.value.text.length > 15) {
      AccountNumberValid = false.obs;
      accountNumberErrorMessage = 'Account number must be 15 digits or less';
      FocusScope.of(context).requestFocus(accountNumberFocusNode);
      return false;
    } else if (confirmAccountNumberController.value.text.isEmpty) {
      ConfirmAccountNumberValid = false.obs;
      confirmAccountErrorMessage = 'Confirm Account number is required';
      FocusScope.of(context).requestFocus(confirmAccountNumberFocusNode);
      return false;
    } else if (confirmAccountNumberController.value.text !=
        accountNumberController.value.text.trim()) {
      ConfirmAccountNumberValid = false.obs;
      confirmAccountErrorMessage =
          'Account Number & Confirm Account Number should be the same';
      FocusScope.of(context).requestFocus(confirmAccountNumberFocusNode);
      return false;
    } else if (confirmAccountNumberController.value.text.length > 15) {
      ConfirmAccountNumberValid = false.obs;
      confirmAccountErrorMessage =
          'Confirm Account number must be 15 digits or less';
      FocusScope.of(context).requestFocus(confirmAccountNumberFocusNode);
      return false;
    } else if (suitAptController.value.text.isEmpty) {
      suitAptValid = false.obs;
      suitAptErrorMessage = 'Suit/Apt is required';
      FocusScope.of(context).requestFocus(suitAptFocusNode);
      return false;
    } else if (streetController.value.text.isEmpty) {
      streetValid = false.obs;
      streetErrorMessage = 'Street is required';
      FocusScope.of(context).requestFocus(streetFocusNode);
      return false;
    } else if (countryController.value.text.isEmpty) {
      countrytValid = false.obs;
      countryterrorMessage = 'Country is required';
      FocusScope.of(context).requestFocus(countryFocusNode);
      return false;
    } else if (stateController.value.text.isEmpty) {
      stateValid = false.obs;
      stateErrorMessage = 'State is required';
      FocusScope.of(context).requestFocus(stateFocusNode);
      return false;
    } else if (cityController.value.text.isEmpty) {
      cityValid = false.obs;
      cityErrorMessage = 'City is required';
      FocusScope.of(context).requestFocus(cityFocusNode);
      return false;
    } else if (zipController.value.text.isEmpty) {
      zipcodeValid = false.obs;
      zipcodeErrorMessage = 'Zip Code is required';
      FocusScope.of(context).requestFocus(zipcodeFocusNode);
      return false;
    } else {
      AccountNameValid = routingValid = AccountNumberValid =
          ConfirmAccountNumberValid = suitAptValid = streetValid =
              countrytValid = stateValid = cityValid = zipcodeValid = true.obs;
      return true;
    }
  }

  bool isSwitched = false;
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
        postalCode: zipController.value.text.trim()));
  }

  void removeAccountDetail(int index) {
    if (index >= 0 && index < accountDetailsList.length) {
      bool isPrimaryDeleted = accountDetailsList[index].primary;
      accountDetailsList.removeAt(index);
      if (isPrimaryDeleted && accountDetailsList.isNotEmpty) {
        accountDetailsList[0].primary = true;
      }
    } else {
      debugPrint("Index out of range");
    }
  }

  void clearAllAccount() {
    accountHolderNameController.value.clear();
    routingNumberController.clear();
    accountNumberController.value.clear();
    confirmAccountNumberController.value.clear();
    suitAptController.value.clear();
    streetController.value.clear();
    countryController.value.clear();
    stateController.value.clear();
    cityController.value.clear();
    zipController.value.clear();
    isSwitched = false;
    bankName = "".obs;
    bankAddress = "".obs;
    postalCode = "".obs;
    state = "".obs;
    city = "".obs;
    isRoutingNumberValid = false.obs;
  }

  void clearAllCustomer() {
    nameController.value.clear();
    mobileController.value.clear();
    emailController.value.clear();
    descriptionController.value.clear();
  }

  insertCustomerData() async {
    variableController.loading.value = true;
    ReqAddcustomerDetails reqAddcustomerDetails = ReqAddcustomerDetails(
        description: descriptionController.value.text.trim(),
        mobile:
            '${selectedCountryCode.replaceAll('+', '')}${mobileController.value.text.trim()}',
        email: emailController.value.text.trim(),
        custName: nameController.value.text.trim(),
        items: accountDetailsList);
    debugPrint(json.encode(reqAddcustomerDetails.toJson()));
    var res = await ApiCall.postApiCalltoken(
        MyUrls.addCustomer,
        reqAddcustomerDetails,
        CommonVariable.token.value,
        CommonVariable.businessId.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResAddCustomer resAddCustomer = ResAddCustomer.fromJson(res);
      if (resAddCustomer.code == 200) {
        variableController.loading.value = false;
        MyToast.toast("customer add successful");
        Get.back();
        accountDetailsList.clear();
        clearAllCustomer();
        clearAllAccount();
        allTabController.callMethod();
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  validateRoutingNumber(String routingNumber) async {
    variableController.loading.value = true;
    ReqCheckRoutingNo reqCheckRoutingNo =
        ReqCheckRoutingNo(routingNumber: routingNumber);
    debugPrint(json.encode(reqCheckRoutingNo.toJson()));
    var res = await ApiCall.postApiCall(MyUrls.checkRoutingNumber,
        reqCheckRoutingNo, CommonVariable.token.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResCheckRoutingNo resCheckRoutingNo = ResCheckRoutingNo.fromJson(res);
      if (resCheckRoutingNo.code == 200) {
        isRoutingNumberValid = true.obs;
        bankName.value = resCheckRoutingNo.customerName ?? "";
        postalCode.value = resCheckRoutingNo.zip ?? "";
        bankAddress.value = resCheckRoutingNo.address ?? "";
        state.value = resCheckRoutingNo.state ?? "";
        city.value = resCheckRoutingNo.city ?? "";
        routingValid = true.obs;
      } else {
        routingErrorMessage = resCheckRoutingNo.message.toString();
        routingValid = false.obs;
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  addSingleAccount(String id) async {
    variableController.loading.value = true;
    ReqSingleAccount reqSingleAccount = ReqSingleAccount(
        primary: isSwitched,
        accountName: accountHolderNameController.value.text.trim(),
        accountNumber: accountNumberController.value.text.trim(),
        routingNumber: routingNumberController.value.text.trim(),
        apartment: suitAptController.value.text.trim(),
        address: streetController.value.text.trim(),
        country: countryController.value.text.trim(),
        city: cityController.value.text.trim(),
        state: stateController.value.text.trim(),
        postalCode: zipController.value.text.trim());
    debugPrint(json.encode(reqSingleAccount.toJson()));
    var res = await ApiCall.postApiCalltoken(MyUrls.addSingleAccount,
        reqSingleAccount, CommonVariable.token.value, id);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      ResAddCustomer resAddCustomer = ResAddCustomer.fromJson(res);
      if (resAddCustomer.code == 200) {
        MyToast.toast("Account add successful");
        clearAllAccount();
      }
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  updateCustomerDetail(String id) async {
    variableController.loading.value = true;
    ReqUpdateCustomer reqUpdateCustomer = ReqUpdateCustomer(
        info: Info(
            custName: nameController.value.text,
            description: descriptionController.value.text,
            mobile: mobileController.value.text,
            email: emailController.value.text));
    debugPrint(json.encode(reqUpdateCustomer.toJson()));
    var res = await ApiCall.putApiCall(MyUrls.updateCustomer, reqUpdateCustomer,
        CommonVariable.token.value, id);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      MyToast.toast("Updated Successful");
      Get.back();
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }

  updateBankDetail(String id, String bankId) async {
    variableController.loading.value = true;
    ReqUpdateBankDetail reqUpdateBankDetail = ReqUpdateBankDetail(
        accountName: accountHolderNameController.value.text.trim(),
        accountNumber: accountNumberController.value.text.trim(),
        address: streetController.value.text.trim(),
        apartment: suitAptController.value.text.trim(),
        city: cityController.value.text.trim(),
        country: countryController.value.text.trim(),
        custId: id,
        postalCode: zipController.value.text.trim(),
        primary: isSwitched,
        routingNumber: routingNumberController.value.text.trim(),
        state: stateController.value.text.trim());
    debugPrint(json.encode(reqUpdateBankDetail.toJson()));
    var res = await ApiCall.putApiCall(MyUrls.updateCustomerBank,
        reqUpdateBankDetail, CommonVariable.token.value, bankId);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      variableController.loading.value = false;
      MyToast.toast("Updated Successful");
      Get.back();
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
    }
  }
}
