import 'package:flutter/material.dart';
import 'package:paycron/utils/color_constants.dart';

class TransactionsDetails extends StatefulWidget {
  const TransactionsDetails({super.key});

  @override
  State<TransactionsDetails> createState() => _TransactionsDetailsState();
}

class _TransactionsDetailsState extends State<TransactionsDetails> {
  bool isCustomerDetailsExpanded = true;
  bool isBusinessDetailsExpanded = true;
  bool isAccountDetailsExpanded = true;
  bool isPurchaseDetailsExpanded = true;
  int selectedIndex = 0;
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
        titleSpacing: 0,
        title: const Text(
          "Transaction Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TransactionCard('Thanks For The Payment', "456898", "Cancelled"),
              SizedBox(height: 16.0,),
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03, horizontal: screenWidth * 0.03), // Responsive padding
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundGreyColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.02), // Responsive spacing
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date:',
                              style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w400, color: AppColors.appNeutralColor2),
                            ),
                            Text(
                              '24 Jun 2024',
                              style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w500,color: AppColors.appNeutralColor2),
                            ),
                          ],
                        ),
                      ],
                    ),
                    VerticalDivider(thickness: 2, color: AppColors.appBlackColor),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.02), // Responsive spacing
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction ID',
                              style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w400, color: AppColors.appNeutralColor2),
                            ),
                            Text(
                              'PTN45157761',
                              style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w500,color: AppColors.appNeutralColor2),
                            ),
                          ],
                        ),
                      ],
                    ),
                    VerticalDivider(thickness: 2, color: AppColors.appBlackColor),
                    const Column(
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans', fontWeight: FontWeight.w400,color: AppColors.appNeutralColor2),
                        ),
                        Text('\$40', style: TextStyle(fontSize: 14,fontFamily: 'Sofia Sans',fontWeight: FontWeight.w500,color: AppColors.appBlackColor)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              _buildCustomerDetailCollapsibleSection(
                title: "Customer Details",
                isExpanded: isCustomerDetailsExpanded,
                onToggle: () {
                  setState(() {
                    isCustomerDetailsExpanded = !isCustomerDetailsExpanded;
                  });
                },
                child: _buildCustomerDetailsCard(),
              ),
              SizedBox(height: 16),
              _buildCustomerDetailCollapsibleSection(
                title: "Business Details",
                isExpanded: isBusinessDetailsExpanded,
                onToggle: () {
                  setState(() {
                    isBusinessDetailsExpanded = !isBusinessDetailsExpanded;
                  });
                },
                child: _buildBusinessDetailsCard(),
              ),
              SizedBox(height: 16),
              _buildCustomerDetailCollapsibleSection(
                title: "Account Details",
                isExpanded: isAccountDetailsExpanded,
                onToggle: () {
                  setState(() {
                    isAccountDetailsExpanded = !isAccountDetailsExpanded;
                  });
                },
                child: _buildAccountDetailsCard(),
              ),
              SizedBox(height: 16),
              _buildCustomerDetailCollapsibleSection(
                title: "Purchase Details",
                isExpanded: isPurchaseDetailsExpanded,
                onToggle: () {
                  setState(() {
                    isPurchaseDetailsExpanded = !isPurchaseDetailsExpanded;
                  });
                },
                child: _buildPurchaseDetailsCard(),
              )
            ],
          ),
        )
    );
  }


  Widget _buildCustomerDetailCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // PopupMenuButton<String>(
                //   icon: Icon(Icons.more_vert),
                //   onSelected: (value) {
                //     // Handle menu selection
                //     if (value == 'edit') {
                //       // Handle edit action
                //     } else if (value == 'delete') {
                //       // Handle delete action
                //     }
                //   },
                //   itemBuilder: (BuildContext context) {
                //     return [
                //       const PopupMenuItem<String>(
                //         value: 'edit',
                //         child: Text('Edit'),
                //       ),
                //       const PopupMenuItem<String>(
                //         value: 'delete',`
                //         child: Text('Delete'),
                //       ),
                //     ];
                //   },
                // ),
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


  Widget _buildCustomerDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Customer Name", "David D Davis"),
          _buildDetailRow("Mobile ID", "10987657890"),
          _buildDetailRow("Email ID", "DavidDDavis123@gmail.com"),
          // Add Menu Button Inline
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Business Name", "Applify Llc4"),
          _buildDetailRow("Business Email", "app3@business.com"),
          _buildDetailRow("Phone Number", "+19876897678"),
          // Add Menu Button Inline
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Account Number", "765434567546"),
          _buildDetailRow("Routing Number", "074000010"),
          _buildDetailRow("Bank Name", "JPMORGAN CHASE"),
        ],
      ),
    );
  }
  Widget _buildPurchaseDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Product Name", "Product1"),
          _buildDetailRow("Price", "\$40"),
          _buildDetailRow("Quantity", "1"),
          // Add Menu Button Inline
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.appNeutralColor2,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(':   ${value}', style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.appBlackColor,
              fontSize: 14,
              fontFamily: 'Sofia Sans',
            )),
          ),
        ],
      ),
    );
  }

  Widget TransactionCard(String amount, String checkNo, String status) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "-Check Number ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
              Text(':   ${checkNo}', style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.appBlackColor,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
              Align(
                alignment: Alignment.topLeft,
                child:
                // ElevatedButton(
                //   onPressed: () {
                //     print("Accepted!");
                //   },
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor:
                //     allbusinessList[index].isApproved == '0' ? AppColors.appYellowColor :
                //     allbusinessList[index].isApproved == '1' ? AppColors.appGreenDarkColor :
                //     allbusinessList[index].isApproved == '2' ? AppColors.appRedColor :
                //     allbusinessList[index].isApproved == '3' ? AppColors.appBlueColor :
                //     allbusinessList[index].isApproved == '4' ? AppColors.appGreyColor :
                //     allbusinessList[index].isApproved == '5' ? AppColors.appYellowColor :
                //     AppColors.appRedColor,
                //
                //     backgroundColor:
                //     allbusinessList[index].isApproved == '0' ? AppColors.appYellowLightColor :
                //     allbusinessList[index].isApproved == '1' ? AppColors.appGreenAcceptColor :
                //     allbusinessList[index].isApproved == '2' ? AppColors.appRedLightColor :
                //     allbusinessList[index].isApproved == '3' ? AppColors.appBlueLightColor :
                //     allbusinessList[index].isApproved == '4' ? AppColors.appGreenLightColor :
                //     allbusinessList[index].isApproved == '5' ? AppColors.appYellowLightColor :
                //     AppColors.appRedLightColor1,
                //
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30), // Rounded corners
                //     ),
                //   ),
                //   child: Text(
                //     allbusinessList[index].isApproved == '0' ? "Pending" :
                //     allbusinessList[index].isApproved == '1' ? "Approved" :
                //     allbusinessList[index].isApproved == '2' ? "Decline" :
                //     allbusinessList[index].isApproved == '3' ? "Review" :
                //     allbusinessList[index].isApproved == '4' ? "Revision" :
                //     allbusinessList[index].isApproved == '5' ? "Added" :
                //     "Discontinue",
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == "Added" ? AppColors.appSkyBlueBackground : AppColors.appRedLightColor1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(color: AppColors.appRedColor, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0,),
          Row(
            children: [
              const Text(
                "-Meme                   ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.appNeutralColor2,
                  fontSize: 14,
                  fontFamily: 'Sofia Sans',
                ),
              ),
              Text(':   ${amount}', style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.appBlackColor,
                fontSize: 14,
                fontFamily: 'Sofia Sans',
              )),
            ],
          )
        ],
      ),
    );
  }
}
