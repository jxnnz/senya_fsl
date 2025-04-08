import 'package:flutter/material.dart';
import '../themes/color.dart';
import '../themes/layout_config.dart';

class Sidebar extends StatelessWidget {
  final String selectedMenu;
  final Function(String) onMenuSelected;
  final LayoutConfig config;

  const Sidebar({
    super.key,
    required this.selectedMenu,
    required this.onMenuSelected,
    required this.config,
  });

  Widget buildMenuItem({
    required IconData icon,
    required String label,
    required String menuKey,
  }) {
    final bool isSelected = selectedMenu == menuKey;

    return GestureDetector(
      onTap: () => onMenuSelected(menuKey),
      child: Container(
        width: 98, // Ensure same width
        height: 88, // Ensure same height
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? AppColors.selectedColor
                      : AppColors.unselectedColor,
              size: 40,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.transparent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: config.sidebarWidthExpandedDesktop,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Logo at top
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/LOGO.png', // replace with your logo path
                width: 60,
              ),
            ),
          ),
          // Menu items
          buildMenuItem(icon: Icons.home, label: 'Home', menuKey: 'home'),
          buildMenuItem(
            icon: Icons.menu_book,
            label: 'Flashcards',
            menuKey: 'flashcards',
          ),
          buildMenuItem(
            icon: Icons.sports_esports,
            label: 'Practice',
            menuKey: 'practice',
          ),
          buildMenuItem(
            icon: Icons.person,
            label: 'Profile',
            menuKey: 'profile',
          ),
          const Spacer(),
          // Logout
          GestureDetector(
            onTap: () {
              onMenuSelected('logout');
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.logout,
                color: AppColors.selectedColor,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
