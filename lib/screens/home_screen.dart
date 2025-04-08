import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/sidebar.dart';
import '../themes/color.dart';
import '../themes/layout_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMenu = "home";
  int streakCount = 5;
  int lives = 3;
  int rubies = 120;
  bool isStreakActive = true;

  void _handleMenuItemSelected(String menuItem) {
    setState(() {
      _selectedMenu = menuItem;
    });

    // You can also navigate using `Navigator.push` if you'd like to navigate to a new page.
    switch (menuItem) {
      case 'home':
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 'flashcards':
        Navigator.pushReplacementNamed(context, '/flashcards');
        break;
      case 'practice':
        Navigator.pushReplacementNamed(context, '/practice');
        break;
      case 'profile':
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 'logout':
        // Implement logout logic (e.g., clear user session or token)
        Navigator.pushReplacementNamed(
          context,
          '/login',
        ); // Navigate to login after logout
        break;
      default:
        break;
    }
  }

  final LayoutConfig _desktopConfig = LayoutConfig(
    sidebarWidthExpandedDesktop: 200,
    sidebarWidthCollapsedDesktop: 100,
    mobileSidebarWidth: 0,
    sidebarIconSize: 40,
    sidebarIconPadding: 10,
    sidebarLabelFontSize: 16,
    appBarPaddingHorizontal: 16,
    appBarPaddingVertical: 10,
    appBarIconSize: 30,
    appBarIconSpacing: 16,
    appBarTextFontSize: 18,
    screenPadding: const EdgeInsets.all(16.0),
    unitSectionSpacing: 20,
    lessonCardHeight: 100,
    lessonCardPadding: const EdgeInsets.all(12),
    lessonImageWidth: 70,
    lessonImageHeight: 70,
  );

  final List<Map<String, dynamic>> units = [
    {
      "title": "Unit 1: Basics",
      "lessons": [
        {
          "title": "Lesson 1",
          "image": "assets/icons/lesson1.png",
          "progress": 0.5,
          "unlocked": true,
        },
        {
          "title": "Lesson 2",
          "image": "assets/icons/lesson2.png",
          "progress": 0.2,
          "unlocked": true,
        },
        {
          "title": "Lesson 3",
          "image": "assets/icons/lesson3.png",
          "progress": 0.0,
          "unlocked": false,
        },
      ],
    },
    {
      "title": "Unit 2: Intermediate",
      "lessons": [
        {
          "title": "Lesson 1",
          "image": "assets/icons/lesson4.png",
          "progress": 0.0,
          "unlocked": false,
        },
        {
          "title": "Lesson 2",
          "image": "assets/icons/lesson5.png",
          "progress": 0.0,
          "unlocked": false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SizedBox(
            width: _desktopConfig.sidebarWidthCollapsedDesktop,
            child: Sidebar(
              selectedMenu: _selectedMenu,
              config: _desktopConfig,
              onMenuSelected: _handleMenuItemSelected,
            ),
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(child: Padding(padding: _desktopConfig.screenPadding)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _desktopConfig.appBarPaddingHorizontal,
        vertical: _desktopConfig.appBarPaddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildAppBarIcon(
            Icons.local_fire_department,
            streakCount,
            isStreakActive ? AppColors.orange : AppColors.grey,
          ),
          SizedBox(width: _desktopConfig.appBarIconSpacing),
          _buildAppBarIcon(Icons.favorite, lives, AppColors.red),
          SizedBox(width: _desktopConfig.appBarIconSpacing),
          _buildAppBarIcon(Icons.diamond, rubies, AppColors.blue),
        ],
      ),
    );
  }

  Widget _buildUnitSection(Map<String, dynamic> unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          unit["title"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: _desktopConfig.unitSectionSpacing),
        Column(
          children:
              unit["lessons"].map<Widget>((lesson) {
                final index = unit["lessons"].indexOf(lesson);
                final color =
                    lesson["unlocked"]
                        ? AppColors.lessonColors[index %
                            AppColors.lessonColors.length]
                        : AppColors.grey;
                return _buildLessonCard(lesson, color);
              }).toList(),
        ),
        SizedBox(height: _desktopConfig.unitSectionSpacing),
      ],
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to LessonScreen
        },
        child: Container(
          height: _desktopConfig.lessonCardHeight,
          padding: _desktopConfig.lessonCardPadding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lesson["title"],
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Completed ${(lesson["progress"] * 100).toInt()}%",
                      style: const TextStyle(
                        color: AppColors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: lesson["progress"],
                      backgroundColor: AppColors.white54,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                lesson["image"],
                width: _desktopConfig.lessonImageWidth,
                height: _desktopConfig.lessonImageHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, int count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: _desktopConfig.appBarIconSize),
        const SizedBox(width: 5),
        Text(
          '$count',
          style: TextStyle(
            fontSize: _desktopConfig.appBarTextFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
