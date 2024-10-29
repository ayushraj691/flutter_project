import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/ProductDetailViewController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/drawer_screen/product/update_product_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var productDetailViewController = Get.find<ProductDetailViewController>();
  var variableController = Get.find<VariableController>();
  int? _selectedFileSize;
  String? imageUrl;
  bool isProductDetailsExpanded = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      callMethod();
      _fetchImageUrl();
    });
    super.initState();
  }

  void callMethod() async {
    await productDetailViewController.getSingleProductData(widget.id);
  }

  Future<void> _fetchImageUrl() async {

    await Future.delayed(Duration(seconds: 1));

    String url;

    if (productDetailViewController.productImage.value.isNotEmpty && productDetailViewController.productImage.value != null){
      url = '${ImageAssets.imageUrl}/${productDetailViewController.productImage.value}';
    }else{
      url='';
    }

    setState(() {
      imageUrl = url;
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Product Detail",
            style: TextStyle(
              fontSize: 16, // Dynamic font size
              fontWeight: FontWeight.w600,
              color: AppColors.appTextColor,
              fontFamily: 'Sofia Sans',
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width *
              0.05, // Dynamic horizontal padding
          vertical: MediaQuery.of(context).size.height *
              0.02, // Dynamic vertical padding
        ),
        child: ListView(
          children: [
            _buildProductDetailCollapsibleSection(
              title: "Product Detail",
              isExpanded: isProductDetailsExpanded,
              onToggle: () {
                setState(() {
                  isProductDetailsExpanded = !isProductDetailsExpanded;
                });
              },
              child: _buildProductDetailsCard(),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // _buildAccountDetailCollapsibleSection(
            //   title: "Account Details",
            //   isExpanded: isAccountDetailsExpanded,
            //   onToggle: () {
            //     setState(() {
            //       isAccountDetailsExpanded = !isAccountDetailsExpanded;
            //     });
            //   },
            //   child: _buildAccountDetailsSection(),
            // ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // _buildRecentTransactionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetailCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Make the popup circular
                  ),
                  color: Colors.transparent,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Circular dialog shape
                    ),
                    onSelected: (value) {
                      // Handle menu selection
                      if (value == 'edit') {
                        Get.to(const UpdateProcductScreen());
                      } else if (value == 'delete') {
                        // Handle delete action
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined,
                                  color: AppColors.appBlackColor),
                              // Icon for edit
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'remove',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_outlined,
                                  color: AppColors.appBlackColor),
                              // Icon for remove
                              SizedBox(width: 8),
                              Text('Remove'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
            onTap: onToggle,
          ),
          if (isExpanded) child,
        ],
      ),
    );
  }

  Widget _buildProductDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => _buildDetailRow(
          //     "Name", customerDetailViewController.personName.value)),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Name:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  productDetailViewController.productName.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              )),
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product Id:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  productDetailViewController.productId.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              )),
          // Obx(
          //   () => _buildDetailRow(
          //       "Email", customerDetailViewController.personEmail.value),
          // ),
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product Price:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                '\$${productDetailViewController.productPrice.value}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
            ),
          ),
          // Obx(
          //   () => _buildDetailRow("Description",
          //       customerDetailViewController.personDescription.value),
          // )
          const SizedBox(
            height: 8.0,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Text(
                  productDetailViewController.productDescription.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlackColor,
                    fontSize: 14,
                    fontFamily: 'Sofia Sans',
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Divider(height: 1, color: AppColors.appBackgroundGreyColor),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.24,
            child: RichText(
              text: const TextSpan(
                text: 'Product Image ',
                style: TextStyle(
                  fontFamily: 'Sofia Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlackColor,
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
          const SizedBox(height: 10),

          _buildFilePreview(),
        ],
      ),
    );
  }

  Widget _buildFilePreview() {
    if (imageUrl == null) {
      return const Text('No file selected');
    } else {
      final int fileSizeInBytes = _selectedFileSize ?? 0;
      String createdOnValue = productDetailViewController.createdOn.value;

      DateTime fileDate;

      if (createdOnValue == null || createdOnValue.isEmpty) {
        debugPrint('CreatedOn value is null or empty');
        fileDate = DateTime.now(); // Fallback to current date
      } else {
        try {
          fileDate = DateTime.parse(createdOnValue).toLocal();
        } catch (e) {
          debugPrint('Error parsing date: $createdOnValue');
          fileDate = DateTime.now(); // Fallback to current date
        }
      }

      final String fileSize =
          '${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      String formattedDate = DateFormat('dd/MM/yyyy').format(fileDate);

      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: AppColors.appNeutralColor5,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Preview from URL
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:( imageUrl!.isNotEmpty && imageUrl != null)
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        width: 50,
                        height: 50,
                        imageUrl!,
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
                      ),
                    )
                  : Image.asset(
                      ImageAssets.productImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      productDetailViewController.productImage.value ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Sofia Sans',
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$fileSize | $formattedDate',
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Sofia Sans',
                      color: AppColors.appNeutralColor2,
                    ),
                  ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       imageUrl = null;
            //       _selectedFileSize = null;
            //     });
            //   },
            //   child: const Icon(
            //     Icons.highlight_remove,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      );
    }
  }
}
