import 'package:flutter/material.dart';
import 'package:paycron/views/drawer_screen/customer/active_customer.dart';
import 'package:paycron/views/drawer_screen/customer/all_tab_customer.dart';
import 'package:paycron/views/drawer_screen/customer/inActive_customer.dart';

class DynamicTabExample extends StatefulWidget {
  const DynamicTabExample({super.key});

  @override
  State<DynamicTabExample> createState() =>
      _DynamicTabExampleState();
}

class _DynamicTabExampleState extends State<DynamicTabExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Customers', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.6), // Full-width bottom divider
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorWeight: 2.0, // Thickness of the selected tab indicator
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Active'),
                Tab(text: 'Inactive'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AllTab(),
                ActiveTab(),
                InActiveTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
