import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycron/controller/dashboard/overallStatistic_controller.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/dashboard/indicator.dart';

class OverallStatistics extends StatefulWidget {
  const OverallStatistics({super.key});

  @override
  State<OverallStatistics> createState() => _OverallStatisticsState();

}

class _OverallStatisticsState extends State<OverallStatistics> {
  int _touchedIndex = -1;
  final overallStatisticController = Get.find<OverallStatisticController>();

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Filter Row
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
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
                const SizedBox(width: 10),
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
                  width: screenWidth * 0.24,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'form',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: 'Sofia Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      items: overallStatisticController.filterItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ))
                          .toList(),
                      value: overallStatisticController.filterValue.value,
                      onChanged: (value) {
                        overallStatisticController.filterValue.value = value as String;

                        final selectedIndex = overallStatisticController.filterItems.indexOf(value);
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prepaid Balance',
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
                        flex: 2, // Ensures the PieChart takes up a reasonable amount of space
                        child: AspectRatio(
                          aspectRatio: 1, // Keep a square aspect ratio for the PieChart
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: screenWidth * 0.10,
                              sectionsSpace: 0.4,
                              startDegreeOffset: -50,
                              sections: _buildPieChartCurves(),
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    _touchedIndex = -1;
                                    return;
                                  }
                                  _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03), // Further reduce the width of the SizedBox
                      const Flexible(
                        flex: 1, // Ensures the Column takes up the remaining space
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IndicatorWidget(
                              title: 'Sale',
                              icon: Icons.square,
                              iconColor: AppColors.appBlackColor,
                            ),
                            IndicatorWidget(
                              title: 'Distribute',
                              icon: Icons.square,
                              iconColor: AppColors.appBlueColor,
                            ),
                            IndicatorWidget(
                              title: 'Return',
                              icon: Icons.square,
                              iconColor: AppColors.appChartBlueColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Transactions',
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
                        child: AspectRatio(
                          aspectRatio: 1, // Use aspect ratio instead of fixed height
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final barsSpace = 4.0 * constraints.maxWidth / 80;
                                final barsWidth = 8.0 * constraints.maxWidth / 200;
                                return BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.center,
                                    barTouchData: BarTouchData(enabled: false),
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
                                            final text = '${value.toInt()}\$';
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
                                    borderData: FlBorderData(show: false),
                                    groupsSpace: barsSpace,
                                    barGroups: getData(barsWidth, barsSpace),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.1),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'Current margin: April Spendings',
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    '\$350.00 / \$640.00',
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  ///****************************** Pie Chart ******************************

  List<PieChartSectionData> _buildPieChartCurves() {
    return List.generate(4, (i) {
      final isTouched = i == _touchedIndex;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.appBlackColor,
            value: 50,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.appBlueColor,
            value: 15,
            title: '',
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.appChartBlueColor,
            value: 20,
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
            toY: 10,
            rodStackItems: [
              BarChartRodStackItem(1, 2, AppColors.appBlueLightColor,),
              BarChartRodStackItem(2, 3, AppColors.appBlueColor),
              BarChartRodStackItem(3, 4, AppColors.appGreenColor),
              BarChartRodStackItem(4, 5, AppColors.appGreyColor),
              BarChartRodStackItem(5, 10, AppColors.appBlackColor),
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
            toY: 80,
            rodStackItems: [
              BarChartRodStackItem(1, 20,AppColors.appBlueLightColor),
              BarChartRodStackItem(20, 30, AppColors.appBlueLightColor),
              BarChartRodStackItem(30, 40, AppColors.appBlueLightColor),
              BarChartRodStackItem(40, 60, AppColors.appBlueLightColor),
              BarChartRodStackItem(60, 70, AppColors.appBlueLightColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      // BarChartGroupData(
      //   x: 1,
      //   barsSpace: barsSpace,
      //   barRods: [
      //     BarChartRodData(
      //       toY: 200,
      //       rodStackItems: [
      //         BarChartRodStackItem(80, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 200, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 250,
      //       rodStackItems: [
      //         BarChartRodStackItem(100, 170, widget.lightBlue),
      //         BarChartRodStackItem(170, 250, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 160, widget.lightBlue),
      //         BarChartRodStackItem(160, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 180,
      //       rodStackItems: [
      //         BarChartRodStackItem(60, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 180, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 150, widget.lightBlue),
      //         BarChartRodStackItem(150, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //   ],
      // ),
      // BarChartGroupData(
      //   x: 1,
      //   barsSpace: barsSpace,
      //   barRods: [
      //     BarChartRodData(
      //       toY: 200,
      //       rodStackItems: [
      //         BarChartRodStackItem(80, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 200, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 250,
      //       rodStackItems: [
      //         BarChartRodStackItem(100, 170, widget.lightBlue),
      //         BarChartRodStackItem(170, 250, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 160, widget.lightBlue),
      //         BarChartRodStackItem(160, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 180,
      //       rodStackItems: [
      //         BarChartRodStackItem(60, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 180, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 150, widget.lightBlue),
      //         BarChartRodStackItem(150, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //   ],
      // ),
      // BarChartGroupData(
      //   x: 1,
      //   barsSpace: barsSpace,
      //   barRods: [
      //     BarChartRodData(
      //       toY: 200,
      //       rodStackItems: [
      //         BarChartRodStackItem(80, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 200, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 250,
      //       rodStackItems: [
      //         BarChartRodStackItem(100, 170, widget.lightBlue),
      //         BarChartRodStackItem(170, 250, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 160, widget.lightBlue),
      //         BarChartRodStackItem(160, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 180,
      //       rodStackItems: [
      //         BarChartRodStackItem(60, 120, widget.lightBlue),
      //         BarChartRodStackItem(120, 180, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //     BarChartRodData(
      //       toY: 220,
      //       rodStackItems: [
      //         BarChartRodStackItem(90, 150, widget.lightBlue),
      //         BarChartRodStackItem(150, 220, widget.blue),
      //       ],
      //       borderRadius: BorderRadius.zero,
      //       width: barsWidth,
      //     ),
      //   ],
      // ),
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
    const style = TextStyle(fontSize: 10,fontWeight: FontWeight.w400,fontFamily: 'Sofia Sans');
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
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

