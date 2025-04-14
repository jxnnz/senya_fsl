import 'package:flutter/material.dart';
import '../../themes/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "profile";

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Overlay to close sidebar
          if (_isSidebarExpanded || _isMobileSidebarOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSidebarExpanded = false;
                  _isMobileSidebarOpen = false;
                });
              },
              child: Container(
                color: Colors.black12,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // Sidebar
          Row(
            children: [
              if (isMobile)
                _isMobileSidebarOpen
                    ? _buildSidebar(isMobile: true)
                    : const SizedBox.shrink()
              else
                GestureDetector(
                  onTap: () {
                    if (!_isSidebarExpanded) {
                      setState(() => _isSidebarExpanded = true);
                    }
                  },
                  child: _buildSidebar(isMobile: false),
                ),
              //Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppBar-like header
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Avatar, Name, Username
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(
                              'assets/images/avatar_default.png',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'SEN',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@senya',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Cards: Hearts, Rubies, Streak
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard(
                            '❤️',
                            '3',
                            'Hearts',
                            actionLabel: 'BUY',
                          ),
                          _buildStatCard('💎', '240', 'Rubies'),
                          _buildStatCard('🔥', '5', 'Streak'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Overall Progress
                      const Text(
                        'Overall Progress',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.6, // 60% overall progress
                        minHeight: 12,
                        color: AppColors.primaryColor,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(height: 30),

                      // Lesson Progress
                      const Text(
                        'Lesson Progress',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildLessonProgress('Lesson 1', 0.9),
                      _buildLessonProgress('Lesson 2', 0.7),
                      _buildLessonProgress('Lesson 3', 0.4),
                      _buildLessonProgress('Lesson 4', 0.0),
                      const SizedBox(height: 30),

                      // Certificate Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.lock, size: 40, color: Colors.grey),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Complete the course to unlock your certificate!',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Mobile menu toggle
          if (isMobile && !_isMobileSidebarOpen)
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primaryColor),
                onPressed: () => setState(() => _isMobileSidebarOpen = true),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSidebar({bool isMobile = false}) {
    final bool expanded = isMobile ? true : _isSidebarExpanded;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isMobile ? 200 : (expanded ? 200 : 85),
      color: AppColors.primaryColor,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => setState(() => _isMobileSidebarOpen = false),
            ),
          Center(
            child: Image.asset(
              'assets/images/LOGO.png',
              width: expanded ? 120 : 50,
            ),
          ),
          const SizedBox(height: 20),
          _buildSidebarItem("home", Icons.home, "Home", isMobile: isMobile),
          _buildSidebarItem(
            "flashcard",
            Icons.menu_book,
            "Flashcard",
            isMobile: isMobile,
          ),
          _buildSidebarItem(
            "practice",
            Icons.sports_esports,
            "Practice",
            isMobile: isMobile,
          ),
          _buildSidebarItem(
            "profile",
            Icons.person,
            "Profile",
            isMobile: isMobile,
          ),
          const Spacer(),
          Center(
            child: GestureDetector(
              onTap: _logout,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout,
                      color: AppColors.selectedColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColors.selectedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    String menu,
    IconData icon,
    String label, {
    bool isMobile = false,
  }) {
    bool isSelected = _selectedMenu == menu;
    bool expanded = isMobile || _isSidebarExpanded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedMenu = menu);
          // Navigate
          if (menu == 'home') {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (menu == 'flashcard') {
            Navigator.pushReplacementNamed(context, '/flashcard');
          } else if (menu == 'practice') {
            Navigator.pushReplacementNamed(context, '/practice');
          } else if (menu == 'profile') {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        child: Container(
          decoration:
              isSelected
                  ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: const Border(
                      right: BorderSide(color: Colors.white, width: 5),
                    ),
                  )
                  : null,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isSelected
                        ? AppColors.selectedColor
                        : AppColors.unselectedColor,
                size: 40,
              ),
              if (expanded)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    label,
                    style: TextStyle(
                      color:
                          isSelected
                              ? AppColors.selectedColor
                              : AppColors.unselectedColor,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget _buildStatCard(
    String emoji,
    String value,
    String label, {
    String? actionLabel,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
            if (actionLabel != null)
              TextButton(onPressed: () {}, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonProgress(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          color: AppColors.primaryColor,
          backgroundColor: Colors.grey[300],
          minHeight: 10,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
