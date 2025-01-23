import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/mail_model/ReqMail.dart';
import 'package:paycron/model/mail_model/ResMail.dart';
import 'package:paycron/network/api_call/api_call.dart';
import 'package:paycron/network/api_call/url.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/general_methods.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/my_toast.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/drawer_screen/invoice/invoice_main_screen.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';

class DynamicEmailSender extends StatefulWidget {
  final String id;

  const DynamicEmailSender({super.key, required this.id});

  @override
  DynamicEmailSenderState createState() => DynamicEmailSenderState();
}

class DynamicEmailSenderState extends State<DynamicEmailSender> {
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> subjectController =
      TextEditingController().obs;
  final Rx<TextEditingController> bodyController = TextEditingController().obs;
  Rx<bool> emailValid = true.obs;
  Rx<bool> emailSubjectValid = true.obs;
  Rx<bool> bodyValid = true.obs;
  var emailErrorMessage = null;
  var emailSubjectErrorMessage = null;
  var bodyErrorMessage = null;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode emailSubjectFocusNode = FocusNode();
  final FocusNode bodyFocusNode = FocusNode();

  bool emailValidation(BuildContext context) {
    if (emailController.value.text.isEmpty) {
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
    } else if (subjectController.value.text.isEmpty) {
      emailSubjectValid = false.obs;
      emailSubjectErrorMessage = 'Email subject is required';
      FocusScope.of(context).requestFocus(emailSubjectFocusNode);
      return false;
    } else if (bodyController.value.text.isEmpty) {
      bodyValid = false.obs;
      bodyErrorMessage = 'Email body is required';
      FocusScope.of(context).requestFocus(bodyFocusNode);
      return false;
    } else {
      emailValid = true.obs;
      emailSubjectValid = true.obs;
      bodyValid = true.obs;
      return true;
    }
  }

  var variableController = Get.find<VariableController>();

  sendInvoice() async {
    variableController.loading.value = true;
    ReqMail reqMail = ReqMail(
        to: emailController.value.text,
        subject: subjectController.value.text,
        message: bodyController.value.text);
    var res = await ApiCall.postApiCall(
        MyUrls.sendInvoice, reqMail, CommonVariable.token.value);
    debugPrint("*************************");
    debugPrint("*****$res*******");
    debugPrint("*************************");
    if (res != null) {
      ResMail resMail = ResMail.fromJson(res);
      MyToast.toast(resMail.message);
      emailController.value.clear();
      bodyController.value.clear();
      Get.to(const InvoiceScreen());
    } else {
      MyToast.toast("Something Went Wrong");
      variableController.loading.value = false;
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    subjectController.value.text =
        "Business Name : ${CommonVariable.businessName.value}";
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Obx(
          () => Text(
            CommonVariable.businessName.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBackgroundGreyColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
                shadowColor: Colors.black45,
              ),
              onPressed: () => {
                Clipboard.setData(ClipboardData(
                    text:
                        'https://paycron.amazing7studios.com/merchant/business/${CommonVariable.businessId.value}/alltransaction/invoice/${widget.id}/invoice-bill')),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("URL copied")),
                ),
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Copy link',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.Sofiafontfamily,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        ImageAssets.linkImage,
                        width: 16, // Adjust width
                        height: 16, // Adjust height
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      "Link has been generated",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            "Send in mail",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              controller: emailController.value,
                              labelText: "To",
                              keyboardType: TextInputType.emailAddress,
                              focusNode: emailFocusNode,
                              onChanged: (value) {
                                String pattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                RegExp regExp = RegExp(pattern);
                                setState(() {
                                  if (value.isEmpty) {
                                    emailValid = false.obs; // Empty field
                                  } else if (regExp.hasMatch(value)) {
                                    emailValid = true.obs;
                                  } else {
                                    emailValid = false.obs; // Invalid input
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: AppColors.appBlueColor),
                                contentPadding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: emailValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 1, // Thickness for the underline
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appTabBackgroundColor,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    width: 1,
                                  ),
                                ),
                                errorText: emailValid.value
                                    ? null
                                    : (emailController.value.text.isEmpty
                                        ? 'To is required'
                                        : 'Invalid Email'),
                                hintText: "To",
                                filled: true,
                                fillColor: AppColors.appWhiteColor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'To is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              controller: subjectController.value,
                              labelText: "Business",
                              keyboardType: TextInputType.text,
                              focusNode: emailSubjectFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    emailSubjectValid = false.obs;
                                  } else {
                                    emailSubjectValid = true.obs;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: AppColors.appBlueColor),
                                contentPadding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: emailSubjectValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 1, // Thickness for the underline
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appTabBackgroundColor,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    // Error border for invalid input
                                    width: 1,
                                  ),
                                ),
                                errorText: emailSubjectValid.value
                                    ? null
                                    : (subjectController.value.text.isEmpty
                                        ? 'Business is required'
                                        : ''),
                                hintText: 'Business',
                                filled: true,
                                fillColor: AppColors.appWhiteColor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: bodyController.value,
                              maxLines: 10,
                              minLines: 5,
                              keyboardType: TextInputType.text,
                              focusNode: bodyFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    bodyValid = false.obs;
                                  } else {
                                    bodyValid = true.obs;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Write your message here",
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appNeutralColor2,
                                  fontSize: 14,
                                  fontFamily: 'Sofia Sans',
                                ),
                                alignLabelWithHint: true,
                                contentPadding: const EdgeInsets.all(8.0),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appTabBackgroundColor,
                                    // Default color for enabled state
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: bodyValid.value
                                        ? AppColors.appNeutralColor5
                                        : AppColors.appRedColor,
                                    width: 1, // Thickness for the underline
                                  ),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appRedColor,
                                    // Error border for invalid input
                                    width: 1,
                                  ),
                                ),
                                errorText: bodyValid.value
                                    ? null
                                    : (bodyController.value.text.isEmpty
                                        ? 'message is required'
                                        : ''),
                                filled: true,
                                fillColor: AppColors.appWhiteColor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'message is required';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.appNeutralColor2,
                                fontSize: 14,
                                fontFamily: 'Sofia Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          text: "Click on ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "proceed to pay",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                            TextSpan(
                              text: " to complete the payment",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 120),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (emailValidation(context)) {
                              GeneralMethods.loadingDialog(context);
                              sendInvoice();
                            }
                          },
                          child: const Text(
                            "Send",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
