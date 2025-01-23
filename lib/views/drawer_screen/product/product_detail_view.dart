import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paycron/controller/drawer_Controller/product_controller/ProductDetailViewController.dart';
import 'package:paycron/controller/variable_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/drawer_screen/product/update_product_screen.dart';
import 'package:paycron/views/widgets/NoDataScreen.dart';

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
    });
    super.initState();
  }

  void callMethod() async {
    await productDetailViewController.getSingleProductData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
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
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Product Detail",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.appTextColor,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *
                      0.05,
                  vertical: MediaQuery.of(context).size.height *
                      0.02,
                ),
                child: ListView(
                  children: [
                    if (productDetailViewController
                            .allSingleProductDataList.isEmpty &&
                        !variableController.loading.value)
                      NoDataFoundCard()
                    else ...[
                      _buildProductDetailCollapsibleSection(
                        title: "Product Detail",
                        isExpanded: isProductDetailsExpanded,
                        onToggle: () {
                          setState(() {
                            isProductDetailsExpanded =
                                !isProductDetailsExpanded;
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
                    ]
                  ],
                ),
              ),
              if (variableController.loading.value)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      child: Lottie.asset("assets/lottie/half-circles.json"),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _refreshData() async {
    callMethod();
    setState(() {});
  }

  Widget _buildProductDetailCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
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
                        BorderRadius.circular(20),
                  ),
                  color: Colors.transparent,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.to(UpdateProcductScreen(id: widget.id,));
                      } else if (value == 'delete') {
                      }
                    },

                    // itemBuilder: (BuildContext context) {
                    //   return [
                    //     PopupMenuItem<String>(
                    //       value: 'edit',
                    //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    //       child: Row(
                    //         children: [
                    //           Image(
                    //             image: AssetImage( ImageAssets.EditIcon),
                    //             width: 16,
                    //             height: 16,
                    //             color: AppColors.appBlackColor,
                    //           ),
                    //           const SizedBox(width: 4),
                    //           const Text('Edit'),
                    //         ],
                    //       ),
                    //     ),
                    //   ];
                    // },

                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'edit',
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(ImageAssets.EditIcon),
                                width: 16,
                                height: 16,
                                color: AppColors.appBlackColor,
                              ),
                              const SizedBox(width: 4),
                              const Text('Edit'),
                            ],
                          ),
                        ),
                        // PopupMenuItem<String>(
                        //   value: 'remove',
                        //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        //   child: Row(
                        //     children: [
                        //       Image(
                        //         image: AssetImage(ImageAssets.removeImage),
                        //         width: 16,
                        //         height: 16,
                        //         color: AppColors.appBlackColor,
                        //       ),
                        //       const SizedBox(width: 4),
                        //       const Text('Remove'),
                        //     ],
                        //   ),
                        // ),
                      ];
                    },
                  ),
                ),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: AppColors.appBlackColor),
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
          const SizedBox(height: 4.0,),
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
          const SizedBox(height: 4.0,),
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
          const SizedBox(height: 4.0,),
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
          const SizedBox(height: 4.0,),
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
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: productDetailViewController.productImage.isNotEmpty
                    ? Image.network(
                        '${ImageAssets.imageUrl}/${productDetailViewController.productImage}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageAssets.productImage);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator();
                        },
                      )
                    : Image.asset(ImageAssets.productImage),
              )),
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
        ],
      ),
    );
  }
}
