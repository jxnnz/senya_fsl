import 'package:flutter/material.dart';
import '../screens/sidebar.dart';
import '../themes/color.dart';
import '../themes/layout_config.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  String _selectedMenu = "flashcards";

  final LayoutConfig _desktopConfig = LayoutConfig(
    sidebarWidthExpandedDesktop: 200,
    sidebarWidthCollapsedDesktop: 80,
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

  void _handleMenuItemSelected(String menuItem) {
    setState(() {
      _selectedMenu = menuItem;
    });

    if (menuItem == 'home') {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (menuItem == 'flashcards') {
      // Already on flashcards screen
    } else if (menuItem == 'settings') {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice')),
      body: Center(
        child: Text(
          'Get ready to practice your skills here!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
