import 'package:flutter/material.dart';
import '../../themes/color.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "practice";
  int streakCount = 3;
  bool isStreakActive = true;
  int lives = 5;
  int rubies = 120;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // ------------------- OVERLAY TO CLOSE SIDEBAR -------------------
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

          // ------------------- SIDEBAR -------------------
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
              // ------------------- MAIN CONTENT -------------------
              Expanded(
                child: Column(
                  children: [
                    _buildTopAppBar(),
                    Expanded(
                      child: Center(
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildPracticeCard(
                              title: "Game Mode",
                              iconPath: "assets/images/game.png",
                              onTap: () {
                                Navigator.pushNamed(context, '/gamemode');
                              },
                              color: Color(0xFF83B100), // Yellow
                              width: 600,
                              height: 600,
                            ),
                            _buildPracticeCard(
                              title: "Fingerspelling",
                              iconPath: "assets/images/fingerspelling.png",
                              onTap: () {
                                Navigator.pushNamed(context, '/fingerspelling');
                              },
                              color: Color(0xFF2C3F6D), // Blue
                              width: 600,
                              height: 600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ------------------- TOGGLE BUTTON FOR MOBILE -------------------
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
          // Navigate based on menu selection
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
                    border: Border(
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

  Widget _buildPracticeCard({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    required Color color,
    double width = 250,
    double height = 200,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 400),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Page title
          const Text(
            "Practice",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          // Right: Icons for Streak, Hearts, Rubies
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildAppBarIcon(
                Icons.local_fire_department,
                streakCount,
                isStreakActive ? AppColors.orange : Colors.grey,
              ),
              const SizedBox(width: 16),
              _buildAppBarIcon(Icons.favorite, lives, AppColors.red),
              const SizedBox(width: 16),
              _buildAppBarIcon(Icons.diamond, rubies, AppColors.red),
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
}
