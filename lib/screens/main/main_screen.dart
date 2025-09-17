import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../scan/camera_screen.dart';
import '../profile/profile_screen.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
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
        title: _pageTitles[_currentIndex], // Judul AppBar ganti sesuai halaman
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
