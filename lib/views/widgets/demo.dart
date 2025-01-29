import 'package:flutter/material.dart';

class CustomTabBarDemo extends StatefulWidget {
  @override
  _CustomTabBarDemoState createState() => _CustomTabBarDemoState();
}

class _CustomTabBarDemoState extends State<CustomTabBarDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tabWidth = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom TabBar with Smooth Slide'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // Background line for all tabs
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
              // Animated sliding blue line
              AnimatedBuilder(
                animation: _tabController.animation!,
                builder: (context, child) {
                  // Calculate the sliding position based on animation value
                  double animationValue =
                      _tabController.animation!.value; // Current animation value
                  double leftOffset = animationValue * tabWidth;

                  return Positioned(
                    left: leftOffset,
                    child: Container(
                      width: tabWidth,
                      height: 2,
                      color: Colors.blue,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
                  (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    _tabController.animateTo(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ['All', 'Active', 'Inactive'][index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _tabController.index == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
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

class AllTab extends StatelessWidget {
  const AllTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('All Tab Content'));
  }
}

class ActiveTab extends StatelessWidget {
  const ActiveTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Active Tab Content'));
  }
}

class InActiveTab extends StatelessWidget {
  const InActiveTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Inactive Tab Content'));
  }
}
