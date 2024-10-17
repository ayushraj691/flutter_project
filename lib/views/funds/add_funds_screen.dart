import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/company_dashboard/create_payment_page.dart';
import 'package:paycron/views/widgets/Dash_border_view.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import 'package:permission_handler/permission_handler.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  File? _selectedFile;
  String? _fileName;
  int selectedIndex =
      0;
  final int currentStep = 0;

  List<String> allBusinessList = [
    "Business 1",
    "Business 2",
    "Business 3",
    "Business 4"
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Action for back arrow
          },
        ),
        titleSpacing: 0, // Removes extra space between arrow and title
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
          padding: EdgeInsets.all(16),
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
                // Prevent scrolling
                shrinkWrap: true,
                // Makes the GridView occupy only the required space
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  String displayText;
                  var formCount = "\$5000"; // Default value
                  String textIcons = "";

                  switch (index) {
                    case 0:
                      displayText = "Approval Pending";
                      textIcons = ImageAssets.approvedFund;
                      formCount = '\$350.00';
                      break;
                    case 1:
                      displayText = "Prepaid Balance";
                      textIcons = ImageAssets.pendingFund;
                      formCount = '\$50.00';
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
                          offset: const Offset(2, 2),
                          blurRadius: 2.0,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01, // Responsive vertical padding
                        horizontal: MediaQuery.of(context).size.width * 0.02, // Responsive horizontal padding
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Make the Column take only as much space as it needs
                        children: [
                          Image.asset(
                            textIcons,
                            height: MediaQuery.of(context).size.height * 0.05, // Responsive image height
                            width: MediaQuery.of(context).size.width * 0.1, // Responsive image width
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Responsive space
                          Text(
                            displayText,
                            style: TextStyle(
                              color: AppColors.appTextLightColor,
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Responsive space
                          Text(
                            formCount,
                            style: TextStyle(
                              color: AppColors.appBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width * 0.06, // Responsive font size
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: screenWidth,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
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
                          child: CommonTextField(
                              prefixImage: Icons.currency_rupee,
                              hintText: 'Enter Amount',
                              controller: TextEditingController(),
                              labelText: 'Enter Amount'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickFile,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: CustomPaint(
                                    painter: DashedBorderPainter(
                                      color: Colors.grey, // Border color
                                      strokeWidth: 2.0, // Border thickness
                                      dashLength: 8.0, // Length of each dash
                                      dashGap: 4.0, // Gap between each dash
                                      borderRadius: 16.0,
                                    ),
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.blue),
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
                child: Container(
                  width: screenWidth,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
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
                            SizedBox(
                              height: 20,
                            ),
                            // Obx(() => allBusinessList.isEmpty
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: const Center(
                            //             child: CircularProgressIndicator()),
                            //       )
                            //     : )
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return accountDetailListItem(
                                    allBusinessList, index, context);
                              },
                              physics: const ScrollPhysics(),
                            ),
                          ],
                        ),
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
                      Get.to(CreatePaymentPage());
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
      List<String> allBusinessList, int index, context) {
    bool isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none, // Allows overflow
                children: [
                  // Main container for account information
                  Container(
                    padding: EdgeInsets.only(bottom: 14.0),
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
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: const ExpansionTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'JPMORGAN CHASE (Business Checking Account)',
                                      // Long text
                                      style: TextStyle(
                                        color: AppColors.appBlackColor,
                                        // Replace with AppColors.appGreyColor
                                        fontSize: 14,
                                        fontFamily: 'Sofia Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      softWrap: true,
                                      // Allows the text to wrap to the next line
                                      overflow: TextOverflow
                                          .visible, // Ensure text is visible and not clipped
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'The bank account details are as follows :    ',
                                        // Example data
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appGreyColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'JPMORGAN CHASE',
                                            // Long text
                                            style: TextStyle(
                                              color: Colors.black,
                                              // Replace with AppColors.appGreyColor
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                            // Allows the text to wrap to the next line
                                            overflow: TextOverflow
                                                .visible, // Ensure text is visible and not clipped
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Details',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'xxxxxxxxxxxx6789', // Long text
                                            style: TextStyle(
                                              color: Colors.black,
                                              // Replace with AppColors.appGreyColor
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                            // Allows the text to wrap to the next line
                                            overflow: TextOverflow
                                                .visible, // Ensure text is visible and not clipped
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Created at',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '06 May 2024, 08:05 pm',
                                            // Long text
                                            style: TextStyle(
                                              color: Colors.black,
                                              // Replace with AppColors.appGreyColor
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                            // Allows the text to wrap to the next line
                                            overflow: TextOverflow
                                                .visible, // Ensure text is visible and not clipped
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Update on',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                            // Replace with AppColors.appBlackColor
                                            fontSize: 12,
                                            fontFamily: 'Sofia Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '06 May 2024, 08:05 pm',
                                            // Long text
                                            style: TextStyle(
                                              color: Colors.black,
                                              // Replace with AppColors.appGreyColor
                                              fontSize: 14,
                                              fontFamily: 'Sofia Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                            // Allows the text to wrap to the next line
                                            overflow: TextOverflow
                                                .visible, // Ensure text is visible and not clipped
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Show the "Primary Account" label only for the selected item
                  if (isSelected)
                    Positioned(
                      top: -13,
                      left: 30,
                      child: Container(
                        padding: EdgeInsets.symmetric(
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
        _selectedFile = File(pickedFile.path);
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
              _selectedFile = File(path);
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
    if (_selectedFile == null) {
      return const Text('No file selected');
    } else {
      final int fileSizeInBytes = _selectedFile!.lengthSync();
      final String fileSize = '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      final String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      final String fileName = _selectedFile!.path.split('/').last;

      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.appNeutralColor5,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedFile!.path.endsWith('.png') ||
                _selectedFile!.path.endsWith('.jpg') ||
                _selectedFile!.path.endsWith('.jpeg'))
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  _selectedFile!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                      child: const Center(child: Text('Error', style: TextStyle(color: AppColors.appWhiteColor))),
                    );
                  },
                ),
              )
            else if (_selectedFile!.path.endsWith('.pdf'))
              const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
            else
              const Icon(Icons.insert_drive_file, size: 50, color: AppColors.appNeutralColor2),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$fileSize | $formattedDate',
                    style: const TextStyle(fontSize: 12,fontFamily: 'Sofia Sans', color: AppColors.appNeutralColor2),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFile = null; // Remove the selected file
                });
              },
              child: const Icon(Icons.highlight_remove, color: AppColors.appNeutralColor2),
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
