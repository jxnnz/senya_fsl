import 'package:flutter/material.dart';
import '../screens/sidebar.dart';
import '../themes/color.dart';
import '../themes/layout_config.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  String _selectedMenu = "flashcards";

  final List<Map<String, dynamic>> _flashcardCategories = [
    {'title': 'Introduction'},
    {'title': 'Alphabet (A-M)'},
    {'title': 'Alphabet (N-Z)'},
    {'title': 'Numbers (1-10)'},
    {'title': 'Shapes'},
    {'title': 'Colors'},
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SizedBox(
            width: _desktopConfig.sidebarWidthExpandedDesktop,
            child: Sidebar(
              selectedMenu: _selectedMenu,
              onMenuSelected: _handleMenuItemSelected,
              config: _desktopConfig,
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: _desktopConfig.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Flashcards',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                      itemCount: _flashcardCategories.length,
                      itemBuilder: (context, index) {
                        final category = _flashcardCategories[index];
                        final colorIndex =
                            index % AppColors.lessonColors.length;
                        final categoryColor =
                            AppColors.lessonColors[colorIndex];

                        return GestureDetector(
                          onTap: () {
                            // TODO: Navigate to actual flashcard set screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${category['title']} tapped'),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: categoryColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Text(
                                category['title'],
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
