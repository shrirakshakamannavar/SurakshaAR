import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'modules_screen.dart';
import 'achievements_screen.dart';
import 'profile_screen.dart';

class MainContainer extends StatefulWidget {
  final String employeeId;
  final String traineeName;
  final String selectedLanguage;

  const MainContainer({
    super.key,
    required this.employeeId,
    required this.traineeName,
    required this.selectedLanguage,
  });

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        employeeId: widget.employeeId,
        traineeName: widget.traineeName,
        selectedLanguage: widget.selectedLanguage,
        onNavigateToModules: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      ModulesScreen(
        employeeId: widget.employeeId,
        selectedLanguage: widget.selectedLanguage,
      ),
      AchievementsScreen(selectedLanguage: widget.selectedLanguage),
      ProfileScreen(
        employeeId: widget.employeeId,
        traineeName: widget.traineeName,
        selectedLanguage: widget.selectedLanguage,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Awards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}