import 'package:flutter/material.dart';
import 'package:story_app/presentation/screens/user/profile/profile_screen.dart';

import '../ai/implement_ai_screen.dart';
import '../home/home_screen.dart';
import '../story/maps/maps_story_screen.dart';
import '../story/upload/upload_story_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const MapsStoryScreen(),
    const UploadStoryScreen(),
    const ImplementAIScreen(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBackPressed() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_sharp),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.recommend_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));
  }
}
