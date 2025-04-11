import 'package:flutter/material.dart';

import 'admin_units_tab.dart';
import 'admin_lessons_tab.dart';
import 'admin_signs.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen>
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
      body: Row(
        children: [
          Container(
            width: 240,
            color: Colors.blueGrey.shade50,
            child: Column(
              children: [
                Container(
                  height: 64,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Admin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.view_module),
                  title: const Text('Units'),
                  selected: _tabController.index == 0,
                  onTap: () => _tabController.index = 0,
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Lessons'),
                  selected: _tabController.index == 1,
                  onTap: () => _tabController.index = 1,
                ),
                ListTile(
                  leading: const Icon(Icons.video_library),
                  title: const Text('Words & Videos'),
                  selected: _tabController.index == 2,
                  onTap: () => _tabController.index = 2,
                ),
                const Spacer(),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Add logout logic
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Units'),
                    Tab(text: 'Lessons'),
                    Tab(text: 'Words & Videos'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      AdminUnitsTab(),
                      AdminLessonsTab(),
                      AdminSignsTab(),
                    ],
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
