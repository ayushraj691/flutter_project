import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/fund_controller/funds_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/model/funds_model/ResAllGateway.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/common_variable.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/utils/string_constants.dart';
import 'package:paycron/views/widgets/Dash_border_view.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/general_methods.dart';
import '../../utils/style.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  int selectedIndex = 0;
  final int currentStep = 0;

  var addFundController = Get.find<FundController>();
  var variableController = Get.find<VariableController>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      callMethod();
    });
    super.initState();
  }

  @override
  void dispose() {
    addFundController.clearAllField();
    super.dispose();
  }

  void callMethod() async {
    await addFundController.getAllGateway();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          "Add Fund",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: Constants.Sofiafontfamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                  child: Text(
                    "Prepaid Balance",
                    style: TextStyle(
                      fontFamily: Constants.Sofiafontfamily,
                      color: AppColors.appBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              GridView.builder(
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  String displayText;
                  String textIcons = "";
                  switch (index) {
                    case 0:
                      displayText = "Approval Pending";
                      textIcons = ImageAssets.approvedFund;
                      break;
                    case 1:
                      displayText = "Prepaid Balance";
                      textIcons = ImageAssets.pendingFund;
                      break;
                    default:
                      displayText = ""; // Default text
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.appBlueColor,
                        style: BorderStyle.none,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 0),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height *
                            0.01, // Responsive vertical padding
                        horizontal: MediaQuery.of(context).size.width *
                            0.02, // Responsive horizontal padding
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // Make the Column take only as much space as it needs
                        children: [
                          Image.asset(
                            textIcons,
                            height: MediaQuery.of(context).size.height *
                                0.05, // Responsive image height
                            width: MediaQuery.of(context).size.width *
                                0.1, // Responsive image width
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.01), // Responsive space
                          Text(
                            displayText,
                            style: TextStyle(
                              color: AppColors.appTextLightColor,
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.046,
                              fontFamily: Constants.Sofiafontfamily,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.01),
                          Obx(
                            () => Flexible(
                              child: Text(
                                index == 1
                                    ? GeneralMethods.formatAmount(CommonVariable.approvedBalance.value)
                                    : "\$${CommonVariable.pendingBalance.value}",
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width * 0.06,
                                  fontFamily: Constants.Sofiafontfamily,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: screenWidth,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Add Proof of Payment',
                              style: TextStyle(
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CommonTextField(
                            controller: addFundController
                                .addProofAmountController.value,
                            focusNode:
                                addFundController.addProofAmountFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  addFundController.addProofAmountValid =
                                      false.obs;
                                } else {
                                  addFundController.addProofAmountValid =
                                      true.obs;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: AppColors.appBlueColor),
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.only(right: 16, left: 16,top: 12,bottom: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: addFundController
                                          .addProofAmountValid.value
                                      ? AppColors.appNeutralColor5
                                      : AppColors.appRedColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.appRedColor,
                                  // Error border for invalid input
                                  width: 1,
                                ),
                              ),
                              errorText:
                                  addFundController.addProofAmountValid.value
                                      ? null
                                      : 'Amount is required',
                              hintText: "Enter Amount",
                              filled: true,
                              fillColor: AppColors.appNeutralColor5,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Amount is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 16.0, right: 16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickFile,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: CustomPaint(
                                    painter: DashedBorderPainter(
                                      color: Colors.grey,
                                      // Border color
                                      strokeWidth: 2.0,
                                      // Border thickness
                                      dashLength: 8.0,
                                      // Length of each dash
                                      dashGap: 4.0,
                                      // Gap between each dash
                                      borderRadius: 16.0,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.cloud_upload_outlined,
                                              size: 50, color: Colors.blue),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Choose File to upload',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontFamily: Constants.Sofiafontfamily,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'JPEG, JPG, PNG, PDF (Max file size 10MB)',
                                            style: TextStyle(
                                              color: AppColors.appTextColor2,
                                              fontFamily: Constants.Sofiafontfamily,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildFilePreview(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: SizedBox(
                  width: screenWidth,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Choose Prepay',
                              style: TextStyle(
                                fontFamily: Constants.Sofiafontfamily,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            if (addFundController.allGatewayDataList.isEmpty) {
                              return variableController.loading.value
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        child: Lottie.asset(
                                            "assets/lottie/half-circles.json"),
                                      ),
                                    ))
                                  : NoDataFoundCard(); // Custom no-data widget
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    addFundController.allGatewayDataList.length,
                                itemBuilder: (context, index) {
                                  return accountDetailListItem(
                                      addFundController.allGatewayDataList,
                                      index,
                                      context);
                                },
                                physics: const ScrollPhysics(),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Center(
                  child: CommonButton(
                    buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonName: "Submit Payment Receipt",
                    onPressed: () {
                      // GeneralMethods.loadingDialog(context);
                      if (addFundController.validation(context)) {
                        addFundController.insertFundsData();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountDetailListItem(
      List<ResAllGateway> allGatewayList, int index, context) {
    ///---------------createdFormatted--------------
    DateTime dateTime =
        DateTime.parse(allGatewayList[index].createdOn).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

    ///-------------UpdateFormatted-----------------
    DateTime dateTime1 =
        DateTime.parse(allGatewayList[index].lastUpdated).toLocal();
    String formattedTime1 = DateFormat.jm().format(dateTime1);
    String formattedDate1 = DateFormat('dd MMM, yyyy').format(dateTime1);
    bool isSelected = index == selectedIndex;
    addFundController.fundsSource.value = allGatewayList[selectedIndex].sId;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          addFundController.fundsSource.value =
              allGatewayList[selectedIndex].sId;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appWhiteColor
                          : AppColors.appNeutralColor5,
                      borderRadius: BorderRadius.circular(30.0),
                      border: isSelected
                          ? Border.all(color: AppColors.appBlueColor, width: 2)
                          : Border.all(color: AppColors.appBackgroundGreyColor, width: 2),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      allGatewayList[index].name,
                                      style: TextStyle(
                                        color: AppColors.appBlackColor,
                                        fontSize: 14,
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'The bank account details are as follows :    ',
                                        style: TextStyle(
                                          fontFamily: Constants.Sofiafontfamily,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appNeutralColor2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name :',
                                            style: TextStyle(
                                              color: AppColors.appNeutralColor2,
                                              fontSize: 12,
                                              fontFamily:
                                                  Constants.Sofiafontfamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            allGatewayList[index].name,
                                            style: AppTextStyles.normalRegularText,
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Details',
                                            style: TextStyle(
                                              color: AppColors.appNeutralColor2,
                                              fontSize: 12,
                                              fontFamily:
                                                  Constants.Sofiafontfamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            allGatewayList[index].details,
                                            // Long text
                                            style:  AppTextStyles.normalRegularText,
                                            softWrap: true,
                                            overflow: TextOverflow
                                                .visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Created at',
                                            style: TextStyle(
                                              color: AppColors.appNeutralColor2,
                                              fontSize: 12,
                                              fontFamily:
                                                  Constants.Sofiafontfamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            '$formattedDate, $formattedTime',
                                            style:  AppTextStyles.normalRegularText,
                                            softWrap: true,
                                            overflow: TextOverflow
                                                .visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Update on',
                                            style: TextStyle(
                                              color: AppColors.appNeutralColor2,
                                              fontSize: 12,
                                              fontFamily:
                                                  Constants.Sofiafontfamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            '$formattedDate1, $formattedTime1',
                                            style: AppTextStyles.normalRegularText,
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: -10,
                      left: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.appBlueColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Primary Account',
                          style: TextStyle(
                            color: AppColors.appWhiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _checkAndRequestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) {
        debugPrint('Storage permission already granted.');
        return;
      }
      // Android 11+ requires special handling due to Scoped Storage
      if (Platform.operatingSystemVersion.contains('11') ||
          Platform.operatingSystemVersion.compareTo('11') > 0) {
        if (await Permission.manageExternalStorage.isGranted) {
          debugPrint('Manage external storage permission already granted.');
          return;
        }
        await Permission.manageExternalStorage.request();
      } else {
        // For Android below version 11
        await Permission.storage.request();
      }

      if (!await Permission.storage.isGranted) {
        debugPrint('Storage permission not granted.');
        _showError('Storage permission is required to pick files.');
      }
    }
  }

  Future<void> _pickFile() async {

    await _checkAndRequestStoragePermission();

    try {
      // File Picker for selecting files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        String? path = result.files.single.path;
        File selectedFile = File(path!);

        // File size validation (10 MB limit)
        final int fileSizeInBytes = selectedFile.lengthSync();
        if (fileSizeInBytes > 10 * 1024 * 1024) {
          _showError('The selected file exceeds the size limit of 10 MB.');
        } else {
          setState(() {
            addFundController.selectedFile = selectedFile;
          });
          debugPrint('Selected file path: $path');
        }
      } else {
        _showError('No file selected or user cancelled the picker.');
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      _showError('An error occurred while selecting the file.');
    }
  }


  Widget _buildFilePreview() {
    if (addFundController.selectedFile == null) {
      return const Text('');
    }

    final int fileSizeInBytes = addFundController.selectedFile!.lengthSync();
    final String fileSize =
        '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    final String formattedDate =
    DateFormat('dd/MM/yyyy').format(DateTime.now());
    final String fileName =
        addFundController.selectedFile!.path.split('/').last;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.appNeutralColor5,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFileThumbnail(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: Constants.Sofiafontfamily,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$fileSize | $formattedDate',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: Constants.Sofiafontfamily,
                      color: AppColors.appNeutralColor2),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                addFundController.selectedFile = null; // Remove the selected file
              });
            },
            child: const Icon(Icons.highlight_remove,
                color: AppColors.appNeutralColor2),
          ),
        ],
      ),
    );
  }

  Widget _buildFileThumbnail() {
    if (addFundController.selectedFile == null) return Container();

    String filePath = addFundController.selectedFile!.path;
    if (filePath.endsWith('.png') ||
        filePath.endsWith('.jpg') ||
        filePath.endsWith('.jpeg')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          addFundController.selectedFile!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.red,
              child: const Center(
                child: Text('Error', style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      );
    } else if (filePath.endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red);
    } else {
      return const Icon(Icons.insert_drive_file,
          size: 50, color: AppColors.appNeutralColor2);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
