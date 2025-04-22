import 'package:flutter/material.dart';
import 'package:senya_fsl/widgets/flashcard_set_screen.dart'; // ✅ Use your actual flashcard viewer
import '../../themes/color.dart';
import '../loading_screen.dart';

class FlashcardSet {
  final String id;
  final String title;
  final Color color;

  FlashcardSet({required this.id, required this.title, required this.color});
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "flashcard";

  final List<FlashcardSet> flashcardSets = [
    FlashcardSet(id: "1", title: "Alphabet", color: Colors.blue),
    FlashcardSet(id: "2", title: "Basics", color: Colors.orange),
    FlashcardSet(id: "3", title: "Colors", color: Colors.green),
    FlashcardSet(id: "4", title: "Numbers", color: Colors.purple),
  ];

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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      color: Colors.white,
                      child: Text(
                        'Flashcard Sets',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.selectedColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.extent(
                        maxCrossAxisExtent: 300,
                        padding: const EdgeInsets.all(16),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children:
                            flashcardSets.map((set) {
                              return GestureDetector(
                                onTap: () async {
                                  // Show the loading screen first
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              const LoadingScreen(), // the screen we built earlier
                                    ),
                                  );

                                  // Then navigate to the flashcard set screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => FlashcardSetScreen(
                                            setId: set.id,
                                            setTitle: set.title,
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: set.color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      set.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
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
          if (menu == 'home') Navigator.pushReplacementNamed(context, '/home');
          if (menu == 'flashcard')
            Navigator.pushReplacementNamed(context, '/flashcard');
          if (menu == 'practice')
            Navigator.pushReplacementNamed(context, '/practice');
          if (menu == 'profile')
            Navigator.pushReplacementNamed(context, '/profile');
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
}
