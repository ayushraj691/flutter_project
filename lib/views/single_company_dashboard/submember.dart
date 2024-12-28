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

class _SubMemberState extends State<SubMember> {

  final ScrollController _scrollController = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _showLeftArrow = _scrollController.position.pixels > 0;
      _showRightArrow = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Left Arrow
                        Visibility(
                          visible: _showLeftArrow,
                          child: IconButton(
                            icon: const SizedBox(
                              width: 24,
                              height: 24,
                              child: Icon(Icons.arrow_back_ios,
                                  color: AppColors.appBlueColor, size: 18),
                            ),
                            onPressed: _showLeftArrow ? _scrollLeft : null,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: const TabBar(
                              isScrollable: true,
                              labelColor: AppColors.appBlueColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: AppColors.appBlueColor,
                              tabs: [
                                Tab(text: 'All'),
                                Tab(text: 'Delete'),
                                Tab(text: 'Delete request'),
                                Tab(text: 'Active'),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _showRightArrow,
                          child: IconButton(
                            icon: const SizedBox(
                              width: 24,
                              height: 24,
                              child: Icon(Icons.arrow_forward_ios,
                                  color: AppColors.appBlueColor, size: 18),
                            ),
                            onPressed: _showRightArrow ? _scrollRight : null,
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
