import 'package:flutter/material.dart';
import '../../themes/color.dart';

class GameModeScreen extends StatefulWidget {
  const GameModeScreen({super.key});

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "practice";
  final int streakCount = 10;
  final bool isStreakActive = true;
  final int lives = 5;
  final int rubies = 1000;

  final double buttonHeight = 180;
  final double buttonWidth = 800;

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
                child: Column(
                  children: [
                    _buildTopAppBar(context),
                    const SizedBox(height: 40),
                    _buildGameButton(
                      "EASY",
                      Colors.green.shade600,
                      Colors.white,
                    ),
                    const SizedBox(height: 20),
                    _buildGameButton(
                      "MEDIUM",
                      Colors.yellow.shade400,
                      Colors.black,
                    ),
                    const SizedBox(height: 20),
                    _buildGameButton("HARD", Colors.red.shade600, Colors.white),
                  ],
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

  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back + Title
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 10),
              const Text(
                "Game Mode",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // Streak, Heart, Rubies
          Row(
            children: [
              _buildAppBarIcon(
                Icons.local_fire_department,
                streakCount,
                isStreakActive ? Colors.orange : Colors.grey,
              ),
              const SizedBox(width: 16),
              _buildAppBarIcon(Icons.favorite, lives, Colors.red),
              const SizedBox(width: 16),
              _buildAppBarIcon(Icons.diamond, rubies, Colors.pink),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, int value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 4),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGameButton(String label, Color bgColor, Color textColor) {
    return Center(
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 2,
          ),
          onPressed: () {
            // Add navigation or logic per difficulty level
          },
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
