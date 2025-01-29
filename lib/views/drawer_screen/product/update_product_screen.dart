import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/update_product_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/widgets/Dash_border_view.dart';
import 'package:paycron/views/widgets/common_button.dart';
import 'package:paycron/views/widgets/common_textform_field.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controller/drawer_Controller/product_controller/ProductDetailViewController.dart';
import '../../../utils/image_assets.dart';

class UpdateProcductScreen extends StatefulWidget {
  final String id;
  const UpdateProcductScreen({super.key, required this.id});

  @override
  State<UpdateProcductScreen> createState() => _UpdateProcductScreenState();
}

class _UpdateProcductScreenState extends State<UpdateProcductScreen> {
  var updateProductController = Get.find<UpdateProductController>();
  var productDetailViewController = Get.find<ProductDetailViewController>();

  @override
  void initState() {
    callMethod();
    super.initState();
  }

  void callMethod() {
    updateProductController.productNameController.value = TextEditingController(text: productDetailViewController.productName.value,
    );
    updateProductController.productIdController.value = TextEditingController(text: productDetailViewController.productId.value,
    );
    updateProductController.productPriceController.value = TextEditingController(text: productDetailViewController.productPrice.value,
    );
    updateProductController.productDescriptionController.value = TextEditingController(text: productDetailViewController.productDescription.value,
    );
  }

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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: screenWidth,
                child: Card(
                  elevation: 1.0,
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
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
                          const SizedBox(
                            height: 4.0,
                          ),
                          CommonTextField(
                              hintText: 'Product Name',
                              controller: updateProductController.productNameController.value,
                              labelText: 'Product Name'),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          SizedBox(
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
                            controller: updateProductController.productIdController.value,
                            labelText: "Product ID",
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.24,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Product price',
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
                            hintText: "Product price",
                            controller: updateProductController.productPriceController.value,
                            labelText: "Product price",
                          ),
                          const SizedBox(
                            width: 10,
                            height: 12.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.24,
                            child: RichText(
                              text: const TextSpan(
                                text: 'Product Description (optional) ',
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
                          TextFormField(
                            controller: updateProductController.productDescriptionController.value,
                            maxLines: 10,
                            minLines: 2,
                            decoration: InputDecoration(
                              hintText: "Enter Your Description Here",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.appNeutralColor2,
                                fontSize: 14,
                                fontFamily: 'Sofia Sans',
                              ),
                              alignLabelWithHint: true,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  right: 16, left: 16,top: 12,bottom: 12),
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
                              fontFamily: 'Sofia Sans',
                              fontSize: 16,
                              color: AppColors.appTextColor, // Set the text color
                            ),
                          ),
                          const SizedBox(
                              height: 40,
                              child: Divider(color: AppColors.appGreyColor)),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Upload Image",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.appTextColor,
                                      fontFamily: 'Sofia Sans',
                                    ),
                                  ),
                                ),
                                const SizedBox(
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
                                const SizedBox(
                                  height: 10,
                                ),
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
                          SizedBox(height: screenHeight * 0.02),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02
                            ),
                            child: Column(
                              children: [
                                CommonButton(
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 0.9,
                                  buttonName: "Save",
                                  onPressed: () {
                                    updateProductController.updateProductData(context,widget.id);
                                    Get.back();
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
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
            updateProductController.selectedFile = selectedFile;
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
    if (updateProductController.selectedFile == null) {
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
                    productDetailViewController.productImage.value ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Sofia Sans',
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Text(
                  //   '$fileSize | $formattedDate',
                  //   style: const TextStyle(
                  //       fontSize: 12,
                  //       fontFamily: 'Sofia Sans',
                  //       color: AppColors.appNeutralColor2),
                  // ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       updateProductController.selectedFile = null;
            //       productDetailViewController.productImage = "".obs;
            //     });
            //   },
            //   child: const Icon(Icons.highlight_remove,
            //       color: AppColors.appNeutralColor2),
            // ),
          ],
        ),
      );

    }

    final int fileSizeInBytes = updateProductController.selectedFile!.lengthSync();
    final String fileSize =
        '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    final String formattedDate =
    DateFormat('dd/MM/yyyy').format(DateTime.now());
    final String fileName =
        updateProductController.selectedFile!.path.split('/').last;

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
                updateProductController.selectedFile = null; // Remove the selected file
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
    if (updateProductController.selectedFile == null) {
      return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: productDetailViewController.productImage.isNotEmpty
          ? Image.network(
        '${ImageAssets.imageUrl}/${productDetailViewController.productImage}',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
              width: 50,
              height: 50,
              ImageAssets.productImage);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
      )
          : Image.asset(
          width: 50,
          height: 50,
          ImageAssets.productImage),
    );
    }else{
      String filePath = updateProductController.selectedFile!.path;
      if (filePath.endsWith('.png') ||
          filePath.endsWith('.jpg') ||
          filePath.endsWith('.jpeg')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child:
          Image.file(
            updateProductController.selectedFile!,
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
