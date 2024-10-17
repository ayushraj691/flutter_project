import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/user_main_dashboard_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/utils/image_assets.dart';
import 'package:paycron/views/app_drawer/app_drawer.dart';
import 'package:paycron/views/company_dashboard/create_payment_page.dart';
import 'package:paycron/views/widgets/common_button.dart';

class CompanyDashboard extends StatefulWidget {
  // final String businessName;
  // final int percentage;
  const CompanyDashboard({super.key});
  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
  final Color lightBlue = AppColors.appBlueLightColor;
  final Color blue = AppColors.appBlueColor;
}
class _CompanyDashboardState extends State<CompanyDashboard> {
  int _touchedIndex = -1;
  final reportController = Get.find<MainDashboardController>();
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
          "Company Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.appTextColor,
            fontFamily: 'Sofia Sans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: screenHeight / 45,
              backgroundImage: AssetImage(ImageAssets.profile),
            ),
          ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Image.asset(ImageAssets.closeDrawer), // Your drawer icon
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer:  AppDrawer(),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0,top: 20,bottom: 10),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
                      color: AppColors.appBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Reports Overview",
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
                          color: AppColors.appBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Filter:",
                      style: TextStyle(
                        fontFamily: 'Sofia Sans',
                        color: AppColors.appBlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.appBackgroundGreyColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: AppColors.appBlueColor,
                          style: BorderStyle.none,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.appBackgroundGreyColor,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      height: 25,
                      width: MediaQuery.of(context).size.width * .24,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'form',
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: reportController.filterItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 10),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                          value: reportController.filterValue.value,
                          onChanged: (value) {
                            setState(() {
                              reportController.filterValue.value =
                              value as String;
                            });

                            // Get the index of the selected item
                            final selectedIndex = reportController
                                .filterItems
                                .indexOf(reportController
                                .filterValue.value);
                            if (selectedIndex != -1) {
                              print('Selected index: ${selectedIndex + 1}');
                            }
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            height: 40,
                            width: 110,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 100,
                          ),
                          // dropdownSearchData: DropdownSearchData(
                          //   searchController:
                          //       reportController.metricsSearchController.value,
                          //   searchInnerWidgetHeight: 50,
                          //   searchInnerWidget: Padding(
                          //     padding: const EdgeInsets.only(
                          //       top: 8,
                          //       bottom: 4,
                          //       right: 8,
                          //       left: 8,
                          //     ),
                          //     child: TextFormField(
                          //       controller:
                          //           reportController.metricsSearchController.value,
                          //       decoration: InputDecoration(
                          //         isDense: true,
                          //         contentPadding: const EdgeInsets.symmetric(
                          //           horizontal: 10,
                          //           vertical: 8,
                          //         ),
                          //         prefixIcon: const Icon(
                          //           Icons.search,
                          //           color: Colors.grey,
                          //         ),
                          //         hintText: 'search name here.........',
                          //         hintStyle: const TextStyle(fontSize: 12),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          //   searchMatchFn: (item, searchValue) {
                          //     final itemValue = item.value.toString().toLowerCase();
                          //     return itemValue.contains(searchValue.toLowerCase());
                          //   },
                          // ),
                          // // This to clear the search value when you close the menu
                          // onMenuStateChange: (isOpen) {
                          //   if (!isOpen) {
                          //     reportController.metricsSearchController.value.clear();
                          //   }
                          // },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0,right: 16.0,left: 16.0,bottom: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Customers',
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              height: screenHeight * 0.2,
                              child: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(show: false),
                                  centerSpaceRadius: screenWidth * 0.12,
                                  sectionsSpace: 0.0,
                                  startDegreeOffset: -50,
                                  sections: _buildPieChartCurves(),
                                  pieTouchData: PieTouchData(
                                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event.isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection == null) {
                                          _touchedIndex = -1;
                                          return;
                                        }
                                        _touchedIndex = pieTouchResponse
                                            .touchedSection!.touchedSectionIndex;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Verify Transaction',
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                              child: SizedBox(
                                width: screenWidth, // Full width of its parent
                                height: 250, // Set a specific height
                                child: LineChart(sampleData1()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Download Transactions',
                        style: TextStyle(
                          fontFamily: 'Sofia Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              height: screenHeight * 0.25,
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final barsSpace = 4.0 * constraints.maxWidth / 400;
                                      final barsWidth = 8.0 * constraints.maxWidth / 400;
                                      return BarChart(
                                        BarChartData(
                                          alignment: BarChartAlignment.center,
                                          barTouchData: BarTouchData(
                                            enabled: false,
                                          ),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 28,
                                                getTitlesWidget: bottomTitles,
                                              ),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 40,
                                                getTitlesWidget: (double value, TitleMeta meta) {
                                                  // Custom Y-axis labels with dollar sign
                                                  final text = '${value.toInt()}\$'; // Add $ sign here
                                                  return SideTitleWidget(
                                                    axisSide: meta.axisSide,
                                                    child: Text(
                                                      text,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                            rightTitles: const AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                          ),
                                          gridData: FlGridData(
                                            show: true,
                                            checkToShowHorizontalLine: (value) => value % 10 == 0,
                                            getDrawingHorizontalLine: (value) => FlLine(
                                              color: AppColors.appGreyColor.withOpacity(0.1),
                                              strokeWidth: 1,
                                            ),
                                            drawVerticalLine: false,
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          groupsSpace: barsSpace,
                                          barGroups: getData(barsWidth, barsSpace),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                              ,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.1), // Reduce spacing between chart and indicators
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                child: Center(
                  child: CommonButton(
                    buttonWidth: screenWidth * 0.9,
                    icon: Icons.add,
                    buttonName: "Create Payment",
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


  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: const LineTouchTooltipData(
          tooltipPadding: EdgeInsets.all(8),
          tooltipMargin: 10,
          tooltipRoundedRadius: 8,
          tooltipBorder: BorderSide(color: Colors.transparent),
        ),
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                final style = TextStyle(
                  fontFamily: 'Sofia Sans',
                  color: Color(0xff72719b),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                );
                Widget text;
                switch (value.toInt()) {
                  case 2:
                    text = Text('jan', style: style);
                    break;
                  case 4:
                    text = Text('feb', style: style);
                    break;
                  case 6:
                    text = Text('mar', style: style);
                    break;
                  case 8:
                    text = Text('apr', style: style);
                    break;
                  case 10:
                    text = Text('may', style: style);
                    break;
                  case 12:
                    text = Text('jun', style: style);
                    break;
                  default:
                    text = Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10,
                  child: text,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                return Text(value.toString());
              },
            ),
          ),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)
          ),
          topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)
          )
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 15,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      // all the spots of the line chart.
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      // curved or straight line.
      isCurved: true,
      // Color of the rod.
      color: AppColors.appBlueColor,
      barWidth: 4,
      // Data of dot.
      dotData: FlDotData(
        show: false,
      ),
      // To highlight the data below the line curve.
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      color: AppColors.appBlackColor,
      barWidth: 4,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }

  ///****************************** Pie Chart ******************************

  List<PieChartSectionData> _buildPieChartCurves() {
    return List.generate(10, (i) {
      final isTouched = i == _touchedIndex;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.appBlackColor,
            value: 10,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.appBlueColor,
            value: 8,
            title: '',
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.appChartBlueColor,
            value: 12,
            title: '',
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.appBlackColor,
            value: 4,
            title: '',
            radius: radius,
          );
        case 4:
          return PieChartSectionData(
            color: AppColors.appBlueColor,
            value: 18,
            title: '',
            radius: radius,
          );
        case 5:
          return PieChartSectionData(
            color: AppColors.appGreyColor,
            value: 9,
            title: '',
            radius: radius,
          );
        case 6:
          return PieChartSectionData(
            color: AppColors.appBackgroundGreyColor,
            value: 20,
            title: '',
            radius: radius,
          );
        case 7:
          return PieChartSectionData(
            color: AppColors.appBlackColor,
            value: 16,
            title: '',
            radius: radius,
          );
        case 8:
          return PieChartSectionData(
            color: AppColors.appBlueColor,
            value: 16,
            title: '',
            radius: radius,
          );
        case 9:
          return PieChartSectionData(
            color: AppColors.appBlueLightColor,
            value: 23,
            title: '',
            radius: radius,
          );
        default:
          return PieChartSectionData(
            color: AppColors.appWhiteColor,
            value: 15,
            title: '',
            radius: radius,
          );
      }
    });
  }

  ///******************* Bar Chart **********************************
  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 100,
            rodStackItems: [
              BarChartRodStackItem(20, 60, widget.lightBlue),
              BarChartRodStackItem(60, 100, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 150,
            rodStackItems: [
              BarChartRodStackItem(70, 90, widget.lightBlue),
              BarChartRodStackItem(90, 150, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 180,
            rodStackItems: [
              BarChartRodStackItem(60, 130, widget.lightBlue),
              BarChartRodStackItem(130, 180, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 200,
            rodStackItems: [
              BarChartRodStackItem(90, 150, widget.lightBlue),
              BarChartRodStackItem(150, 200, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 250,
            rodStackItems: [
              BarChartRodStackItem(50, 170, widget.lightBlue),
              BarChartRodStackItem(170, 250, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 200,
            rodStackItems: [
              BarChartRodStackItem(80, 120, widget.lightBlue),
              BarChartRodStackItem(120, 200, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 250,
            rodStackItems: [
              BarChartRodStackItem(100, 170, widget.lightBlue),
              BarChartRodStackItem(170, 250, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 160, widget.lightBlue),
              BarChartRodStackItem(160, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 180,
            rodStackItems: [
              BarChartRodStackItem(60, 120, widget.lightBlue),
              BarChartRodStackItem(120, 180, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 150, widget.lightBlue),
              BarChartRodStackItem(150, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 200,
            rodStackItems: [
              BarChartRodStackItem(80, 120, widget.lightBlue),
              BarChartRodStackItem(120, 200, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 250,
            rodStackItems: [
              BarChartRodStackItem(100, 170, widget.lightBlue),
              BarChartRodStackItem(170, 250, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 160, widget.lightBlue),
              BarChartRodStackItem(160, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 180,
            rodStackItems: [
              BarChartRodStackItem(60, 120, widget.lightBlue),
              BarChartRodStackItem(120, 180, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 150, widget.lightBlue),
              BarChartRodStackItem(150, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 200,
            rodStackItems: [
              BarChartRodStackItem(80, 120, widget.lightBlue),
              BarChartRodStackItem(120, 200, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 250,
            rodStackItems: [
              BarChartRodStackItem(100, 170, widget.lightBlue),
              BarChartRodStackItem(170, 250, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 160, widget.lightBlue),
              BarChartRodStackItem(160, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 180,
            rodStackItems: [
              BarChartRodStackItem(60, 120, widget.lightBlue),
              BarChartRodStackItem(120, 180, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 150, widget.lightBlue),
              BarChartRodStackItem(150, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 200,
            rodStackItems: [
              BarChartRodStackItem(80, 120, widget.lightBlue),
              BarChartRodStackItem(120, 200, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 250,
            rodStackItems: [
              BarChartRodStackItem(100, 170, widget.lightBlue),
              BarChartRodStackItem(170, 250, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 160, widget.lightBlue),
              BarChartRodStackItem(160, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 180,
            rodStackItems: [
              BarChartRodStackItem(60, 120, widget.lightBlue),
              BarChartRodStackItem(120, 180, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 220,
            rodStackItems: [
              BarChartRodStackItem(90, 150, widget.lightBlue),
              BarChartRodStackItem(150, 220, widget.blue),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontFamily: 'Sofia Sans',
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Apr';
        break;
      case 1:
        text = 'May';
        break;
      case 2:
        text = 'Jun';
        break;
      case 3:
        text = 'Jul';
        break;
      case 4:
        text = 'Aug';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }



}