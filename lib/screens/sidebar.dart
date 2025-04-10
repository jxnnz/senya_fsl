import 'package:flutter/material.dart';
import '../themes/color.dart';

class Sidebar extends StatelessWidget {
  final bool isExpanded;
  final String selectedMenu;
  final Function(String) onMenuSelected;
  final VoidCallback onLogout;

  const Sidebar({
    super.key,
    required this.isExpanded,
    required this.selectedMenu,
    required this.onMenuSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onMenuSelected(selectedMenu),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isExpanded ? 205 : 85,
        color: AppColors.primaryColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/LOGO.png',
                width: isExpanded ? 150 : 50,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSidebarItem("home", Icons.home, "Home"),
                  _buildSidebarItem("flashcard", Icons.menu_book, "Flashcard"),
                  _buildSidebarItem(
                    "practice",
                    Icons.sports_esports,
                    "Practice",
                  ),
                  _buildSidebarItem("profile", Icons.person, "Profile"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: onLogout,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: AppColors.unselectedColor,
                        size: 30,
                      ),
                      if (isExpanded)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: AppColors.unselectedColor,
                              fontSize: 16,
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
      ),
    );
  }

  Widget _buildSidebarItem(String menu, IconData icon, String label) {
    bool isSelected = selectedMenu == menu;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: GestureDetector(
        onTap: () => onMenuSelected(menu),
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
              if (isExpanded)
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
}

// Optional: A separate widget for the mobile sidebar with overlay can also be created similarly.
