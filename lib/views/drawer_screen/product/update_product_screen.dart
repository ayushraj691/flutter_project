import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/Dash_border_view.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateProcductScreen extends StatefulWidget {
  const UpdateProcductScreen({super.key});

  @override
  State<UpdateProcductScreen> createState() => _UpdateProcductScreenState();
}

class _UpdateProcductScreenState extends State<UpdateProcductScreen> {
  File? _selectedFile;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          "Product Detail",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
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
                              "Update Product Detail",
                              style: TextStyle(
                                fontSize: 16, // Dynamic font size
                                fontWeight: FontWeight.w600,
                                color: AppColors.appTextColor,
                                fontFamily: 'Sofia Sans',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Product Name ',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      // Set a different color for the asterisk
                                      fontSize: 12.0,
                                      // Same or different size
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          CommonTextField(
                              hintText: 'Product Name',
                              controller: TextEditingController(),
                              labelText: 'Product Name'),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Product ID (optional) ',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                children: [
                                  // TextSpan(
                                  //   text: '*',
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //     // Set a different color for the asterisk
                                  //     fontSize: 12.0,
                                  //     // Same or different size
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            height: 4.0,
                          ),
                          CommonTextField(
                            hintText: "Product ID",
                            controller: TextEditingController(),
                            labelText: "Product ID",
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.24,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Product Description (optional)* ',
                                style: TextStyle(
                                  fontFamily: 'Sofia Sans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      // Set a different color for the asterisk
                                      fontSize: 12.0,
                                      // Same or different size
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
                          TextFormField(
                            controller: TextEditingController(),
                            maxLines: 10,
                            minLines: 5,
                            decoration: InputDecoration(
                              hintText: "Enter Your Description Here",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.appNeutralColor2,
                                fontSize: 14,
                                fontFamily: 'Sofia Sans',
                              ),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.all(16.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.appNeutralColor5,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: AppColors.appNeutralColor5,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.appNeutralColor2,
                              fontSize: 14,
                              fontFamily: 'Sofia Sans',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Upload Image",
                                    style: TextStyle(
                                      fontSize: 14, // Dynamic font size
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.appTextColor,
                                      fontFamily: 'Sofia Sans',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Drop file here or click to upload an image. The format should be JPG, PNG . Maximum image size: 10Mb.",
                                    style: TextStyle(
                                      fontSize: 12, // Dynamic font size
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.appTextColor,
                                      fontFamily: 'Sofia Sans',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.blue),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Choose File to upload',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'JPEG, JPG, PNG, PDF (Max file size 10MB)',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _buildFilePreview(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03),
                            child: Column(
                              children: [
                                CommonButton(
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 0.9,
                                  buttonName: "Save",
                                  onPressed: () {
                                    // Sign Up functionality
                                  },
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
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
