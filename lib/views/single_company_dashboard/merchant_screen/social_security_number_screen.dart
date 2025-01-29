import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/dashboard/merchant_controller/merchant_controller.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/Dash_border_view.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/string_constants.dart';

class SocialSecurityNumberScreen extends StatefulWidget {
  const SocialSecurityNumberScreen({super.key});

  @override
  State<SocialSecurityNumberScreen> createState() =>
      _SocialSecurityNumberScreenState();
}

class _SocialSecurityNumberScreenState
    extends State<SocialSecurityNumberScreen> {
  var merchantController = Get.find<MerchantController>();
  var variableController = Get.find<VariableController>();
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Social Security Number",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: Constants.Sofiafontfamily,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: screenWidth,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.24,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'SSN Number ',
                                      style: TextStyle(
                                        fontFamily: Constants.Sofiafontfamily,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 4.0,
                                ),
                                CommonTextField(
                                  hintText: "SS Number",
                                  controller:
                                      merchantController.ssnNumber.value,
                                  labelText: "SS Number",
                                  enable: false,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 12.0,
                                ),
                                const SizedBox(height: 10),
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
                                                  const Icon(
                                                      Icons
                                                          .cloud_upload_outlined,
                                                      size: 50,
                                                      color: Colors.blue),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Choose File to upload',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontFamily: Constants.Sofiafontfamily,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'JPEG, JPG, PNG, PDF (Max file size 10MB)',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .appTextColor2,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            // Space from the bottom
            child: CommonButton(
              buttonWidth: screenWidth * 0.9, // Adjust button width
              buttonName: "Save Detail",
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
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

  Widget _buildFilePreview() {
    if (_selectedFile == null) {
      return const Text('No file selected');
    } else {
      final int fileSizeInBytes = _selectedFile!.lengthSync();
      final String fileSize =
          '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      final String formattedDate =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
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
                      child: const Center(
                          child: Text('Error',
                              style:
                                  TextStyle(color: AppColors.appWhiteColor))),
                    );
                  },
                ),
              )
            else if (_selectedFile!.path.endsWith('.pdf'))
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
                  _selectedFile = null; // Remove the selected file
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
}
