import 'package:flutter/material.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/dashboard/all_company_screen.dart';
import 'package:paycron/views/dashboard/dashboard_screen.dart';

class PaycronFloatingBottomBar extends StatefulWidget {
  const PaycronFloatingBottomBar({super.key});

  @override
  _PaycronFloatingBottomBarState createState() =>
      _PaycronFloatingBottomBarState();
}

class _PaycronFloatingBottomBarState extends State<PaycronFloatingBottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const AllCompanyScreen(),
  ];

  void onItemTapped(int index) {
    if (index >= _widgetOptions.length) {
      return; // Prevent navigation if index is out of range
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18, // Slightly above the bottom edge
            child: SizedBox(
              height: 55, // Reduced height for the floating bar
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.appWhiteColor,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0), bottom: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Dashboard Button
                    GestureDetector(
                      onTap: () => onItemTapped(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                        decoration: BoxDecoration(
                          color: _selectedIndex == 0
                              ? AppColors.appBottomNavColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: _selectedIndex == 0 ? 30.0 : 20.0, // Enlarged circle size when selected
                              width: _selectedIndex == 0 ? 30.0 : 20.0,
                              decoration: BoxDecoration(
                                color: _selectedIndex == 0 ? AppColors.appBlueColor : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.dashboard,
                                size: 20, // Reduced icon size
                                color: _selectedIndex == 0
                                    ? AppColors.appWhiteColor
                                    : AppColors.appGreyColor,
                              ),
                            ),
                            const SizedBox(width: 6), // Reduced spacing
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: _selectedIndex == 0
                                      ? AppColors.appBlueColor
                                      : AppColors.appGreyColor,
                                  fontWeight: _selectedIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: MediaQuery.of(context).size.width * 0.03,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // All Company Button
                    GestureDetector(
                      onTap: () => onItemTapped(1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                        decoration: BoxDecoration(
                          color: _selectedIndex == 1
                              ? AppColors.appBlueLightColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: _selectedIndex == 1 ? 30.0 : 20.0, // Enlarged circle size when selected
                              width: _selectedIndex == 1 ? 30.0 : 20.0,
                              decoration: BoxDecoration(
                                color: _selectedIndex == 1 ? AppColors.appBlueColor : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.file_present_outlined,
                                size: 20,
                                color: _selectedIndex == 1
                                    ? AppColors.appWhiteColor
                                    : AppColors.appGreyColor,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                'All Company',
                                style: TextStyle(
                                  color: _selectedIndex == 1
                                      ? AppColors.appBlueColor
                                      : AppColors.appGreyColor,
                                  fontWeight: _selectedIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: MediaQuery.of(context).size.width * 0.03,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}










// import 'package:flutter/material.dart';
// import 'package:paycron/utils/color_constants.dart';
// import 'package:paycron/views/dashboard/all_company_screen.dart';
// import 'package:paycron/views/dashboard/dashboard_screen.dart';
//
// class PaycronBottomNavBar extends StatefulWidget {
//   const PaycronBottomNavBar({super.key});
//
//   @override
//   _PaycronBottomNavBarState createState() => _PaycronBottomNavBarState();
// }
//
// class _PaycronBottomNavBarState extends State<PaycronBottomNavBar> {
//
//   int _selectedIndex = 0;
//
//   static final List<Widget> _widgetOptions = <Widget>[
//     const DashboardScreen(),
//     const AllCompanyScreen(),
//   ];
//
//   void onItemTapped(int index) {
//     if ( index == 3 || index == 4) {
//       // Prevent navigation or perform any action here
//       return;
//     }
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.appNeutralColor5, // Background color for the circular area
//             borderRadius: BorderRadius.circular(30.0), // Circular border
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 // Dashboard Button
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       onItemTapped(0);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       decoration: BoxDecoration(
//                         color: _selectedIndex == 0 ? AppColors.appBottomNavColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.dashboard,
//                             color: _selectedIndex == 0 ? AppColors.appBlueColor : AppColors.appGreyColor,
//                           ),
//                           SizedBox(width: 8),
//                           Flexible( // Ensure text can resize if screen space is limited
//                             child: Text(
//                               'Dashboard',
//                               style: TextStyle(
//                                 color: _selectedIndex == 0 ? AppColors.appBlueColor : AppColors.appGreyColor,
//                                 fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
//                                 fontSize: MediaQuery.of(context).size.width * 0.035, // Dynamic font size
//                               ),
//                               overflow: TextOverflow.ellipsis, // Prevent text overflow
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // All Company Button
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       onItemTapped(1);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       decoration: BoxDecoration(
//                         color: _selectedIndex == 1 ? AppColors.appBlueLightColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.file_present_outlined,
//                             color: _selectedIndex == 1 ? AppColors.appBlueColor : AppColors.appGreyColor,
//                           ),
//                           SizedBox(width: 8),
//                           Flexible( // Ensure text can resize if screen space is limited
//                             child: Text(
//                               'All Company',
//                               style: TextStyle(
//                                 color: _selectedIndex == 1 ? AppColors.appBlueColor : AppColors.appGreyColor,
//                                 fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
//                                 fontSize: MediaQuery.of(context).size.width * 0.035, // Dynamic font size
//                               ),
//                               overflow: TextOverflow.ellipsis, // Prevent text overflow
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }