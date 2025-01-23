import 'package:flutter/material.dart';
import 'package:paycron/utils/color_constants.dart';
import 'package:paycron/views/single_company_dashboard/submember_screen/active_submember_screen.dart';
import 'package:paycron/views/single_company_dashboard/submember_screen/all_submenber_screen.dart';
import 'package:paycron/views/single_company_dashboard/submember_screen/delete_request_submember_screen.dart';
import 'package:paycron/views/single_company_dashboard/submember_screen/delete_submember_screen.dart';

class SubMember extends StatefulWidget {
  const SubMember({super.key});

  @override
  State<SubMember> createState() => _SubMemberState();
}

class _SubMemberState extends State<SubMember> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;

  final double tabWidth = 100.0;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _scrollToSelectedTab(_tabController.index);
      }
    });
  }

  void _scrollToSelectedTab(int index) {
    if (_scrollController.hasClients) {
      final targetScrollOffset =
          (index * tabWidth) - (screenWidth / 2) + (tabWidth / 2);
      final clampedOffset = targetScrollOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width; // Get screen width
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: const TabBar(
                              isScrollable: true,
                              labelColor: AppColors.appBlueColor,
                              unselectedLabelColor: Colors.grey,
                              indicator: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.appBlueColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              tabs: [
                                Tab(text: 'All'),
                                Tab(text: 'Deleted'),
                                Tab(text: 'Delete request'),
                                Tab(text: 'Active'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.0,
                      child: Row(
                        children: List.generate(4, (index) {
                          return Expanded(
                            child: Container(
                              color: index == _tabController.index
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          AllSubmemberScreen(),
                          DeleteSubmemberScreen(),
                          DeleteRequestSubmemberScreen(),
                          ActiveSubmemberScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
