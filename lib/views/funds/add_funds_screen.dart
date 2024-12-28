import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    Future.delayed(const Duration(seconds: 0),(){
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
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Text(
          "Add Fund",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                  child: Text(
                    "Prepaid Balance",
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
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
                                  0.04, // Responsive font size
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.01), // Responsive space
                          Obx(() =>   Flexible(
                            child: Text(
                              index == 1
                                  ? "\$${CommonVariable.pendingBalance.value}"
                                  : "\$${CommonVariable.approvedBalance.value}",
                              style: TextStyle(
                                color: AppColors.appBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.width * 0.06, // Responsive font size
                                fontFamily: 'Sofia Sans',
                              ),
                              maxLines: 1, // Ensures only one line
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),)
                          ,
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
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Add Proof of Payment',
                              style: TextStyle(
                                fontFamily: 'Sofia Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          CommonTextField(
                            controller: addFundController.addProofAmountController.value,
                            focusNode: addFundController.addProofAmountFocusNode,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  addFundController.addProofAmountValid= false.obs;
                                }else {
                                  addFundController.addProofAmountValid = true.obs;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: AppColors.appBlueColor),
                              contentPadding: const EdgeInsets.only(right: 16,left: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: addFundController.addProofAmountValid.value
                                      ? AppColors.appNeutralColor5
                                      : AppColors.appRedColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  // Default color for enabled state
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
                              errorText: addFundController.addProofAmountValid.value
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
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.cloud_upload_outlined,
                                              size: 50, color: Colors.blue),
                                          SizedBox(height: 8),
                                          Text(
                                            'Choose File to upload',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontFamily: 'Sofia Sans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'JPEG, JPG, PNG, PDF (Max file size 10MB)',
                                            style: TextStyle(
                                              color: AppColors.appTextColor2,
                                              fontFamily: 'Sofia Sans',
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
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Choose Prepay',
                              style: TextStyle(
                                fontFamily: 'Sofia Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
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
                                  ? Center(child:Padding(
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
                                itemCount: addFundController.allGatewayDataList.length,
                                itemBuilder: (context, index) {
                                  return accountDetailListItem(
                                      addFundController.allGatewayDataList, index, context);
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
    DateTime dateTime = DateTime.parse(allGatewayList[index].createdOn).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    ///-------------UpdateFormatted-----------------
    DateTime dateTime1 = DateTime.parse(allGatewayList[index].lastUpdated).toLocal();
    String formattedTime1 = DateFormat.jm().format(dateTime1);
    String formattedDate1 = DateFormat('dd MMM, yyyy').format(dateTime1);
    bool isSelected = index == selectedIndex;
    addFundController.fundsSource.value = allGatewayList[selectedIndex].sId;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          addFundController.fundsSource.value = allGatewayList[selectedIndex].sId;
        });
      },
      child: Column(
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.appWhiteColor
                        : AppColors.appNeutralColor5,
                    borderRadius: BorderRadius.circular(30.0),
                    // Show blue border and label for selected item, grey border for others
                    border: isSelected
                        ? Border.all(color: AppColors.appBlueColor, width: 2)
                        : Border.all(
                            color: AppColors.appNeutralColor5,
                            width: 2), // Grey border for other items
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
                                    style: const TextStyle(
                                      color: AppColors.appBlackColor,
                                      fontSize: 14,
                                      fontFamily: 'Sofia Sans',
                                      fontWeight: FontWeight.w400,
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
                                        color: AppColors.appGreyColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name :',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Text(
                                        //     ':',
                                        //     style: TextStyle(
                                        //       color: AppColors.appGreyColor,
                                        //       // Replace with AppColors.appBlackColor
                                        //       fontSize: 12,
                                        //       fontFamily: Constants.Sofiafontfamily,
                                        //       fontWeight: FontWeight.w400,
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(height: 4.0,),
                                        Text(
                                          allGatewayList[index].name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,
                                          ),
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Details',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Text(
                                        //     ':',
                                        //     style: TextStyle(
                                        //       color: AppColors.appGreyColor,
                                        //       // Replace with AppColors.appBlackColor
                                        //       fontSize: 12,
                                        //       fontFamily: Constants.Sofiafontfamily,
                                        //       fontWeight: FontWeight.w400,
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(height: 4.0,),
                                        Text(
                                          allGatewayList[index].details, // Long text
                                          style: TextStyle(
                                            color: Colors.black,
                                            // Replace with AppColors.appGreyColor
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          softWrap: true,
                                          // Allows the text to wrap to the next line
                                          overflow: TextOverflow
                                              .visible, // Ensure text is visible and not clipped
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20,left: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                                'Created at',
                                                style: TextStyle(
                                                  color: AppColors.appGreyColor,
                                                  // Replace with AppColors.appBlackColor
                                                  fontSize: 12,
                                                  fontFamily: Constants.Sofiafontfamily,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child:  Text(
                                        //           ':',
                                        //           style: TextStyle(
                                        //             color: AppColors.appGreyColor,
                                        //             // Replace with AppColors.appBlackColor
                                        //             fontSize: 12,
                                        //             fontFamily: Constants.Sofiafontfamily,
                                        //             fontWeight: FontWeight.w400,
                                        //           ),
                                        //         ),
                                        // ),
                                        const SizedBox(height: 4.0,),
                                        Text(
                                                  '$formattedDate, $formattedTime',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Replace with AppColors.appGreyColor
                                                    fontSize: 14,
                                                    fontFamily: Constants.Sofiafontfamily,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  softWrap: true,
                                                  // Allows the text to wrap to the next line
                                                  overflow: TextOverflow
                                                      .visible, // Ensure text is visible and not clipped
                                                ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20,left: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Update on',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child:  Text(
                                        //     ':',
                                        //     style: TextStyle(
                                        //       color: AppColors.appGreyColor,
                                        //       // Replace with AppColors.appBlackColor
                                        //       fontSize: 12,
                                        //       fontFamily: Constants.Sofiafontfamily,
                                        //       fontWeight: FontWeight.w400,
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(height: 4.0,),
                                        Text(
                                          '$formattedDate1, $formattedTime1',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: Constants.Sofiafontfamily,
                                            fontWeight: FontWeight.w400,),
                                          softWrap: true,
                                          overflow: TextOverflow
                                              .visible,
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
                    top: -13,
                    left: 30,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      decoration: const BoxDecoration(
                        color: AppColors.appBlueColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Primary Account',
                        style: TextStyle(
                          color: AppColors.appWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Future<void> _pickFile() async {
    // Check storage permissions
    if (Platform.isAndroid) {
      var storageStatus = await Permission.storage.status;
      if (storageStatus.isDenied || !storageStatus.isGranted) {
        await Permission.storage.request();
      }
    }

    // Let user choose between image picker or file picker
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        addFundController.selectedFile = File(pickedFile.path);
      });
    } else {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false,
        );

        if (result != null && result.files.isNotEmpty) {
          String? path = result.files.single.path;
          if (path != null) {
            setState(() {
              addFundController.selectedFile = File(path);
            });
            debugPrint('Selected file path: $path');
            _showError('Selected file path: $path');
          } else {
            debugPrint('File path is null');
            _showError('File path is null');
          }
        } else {
          debugPrint('No file selected or user cancelled the picker');
          _showError('No file selected or user cancelled the picker');
        }
      } catch (e) {
        debugPrint('Error picking file: $e');
        _showError('Error picking file: $e');
      }
    }
  }

  Widget _buildFilePreview() {
    if (addFundController.selectedFile == null) {
      return const Text('No file selected');
    } else {
      final int fileSizeInBytes = addFundController.selectedFile!.lengthSync();
      final String fileSize =
          '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      final String formattedDate =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
      final String fileName = addFundController.selectedFile!.path.split('/').last;

      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.appNeutralColor5,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (addFundController.selectedFile!.path.endsWith('.png') ||
                addFundController.selectedFile!.path.endsWith('.jpg') ||
                addFundController.selectedFile!.path.endsWith('.jpeg'))
              ClipRRect(
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
                          child: Text('Error',
                              style:
                                  TextStyle(color: AppColors.appWhiteColor))),
                    );
                  },
                ),
              )
            else if (addFundController.selectedFile!.path.endsWith('.pdf'))
              const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
            else
              const Icon(Icons.insert_drive_file,
                  size: 50, color: AppColors.appNeutralColor2),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Sofia Sans',
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$fileSize | $formattedDate',
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Sofia Sans',
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
