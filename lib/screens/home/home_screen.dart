import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_bottom_navbar.dart';
import '../scan/camera_screen.dart';
import '../profile/profile_screen.dart';
import 'home_dashboard_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeDashboardPage(),
    const CameraScreen(),
    const ProfileScreen(),
  ];

  final List<String> _pageTitles = ["Dashboard", "Scan Meteran", "Profil Saya"];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _pageTitles[_currentIndex],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
