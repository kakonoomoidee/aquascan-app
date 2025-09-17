import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_bottom_navbar.dart';
import '../upload/camera_screen.dart';
import '../user/profile_screen.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          final List<Widget> pages = [
            _buildHomePage(vm), // ⬅️ ini butuh method di bawah
            const CameraScreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            appBar: CustomAppBar(
              title: "Dashboard",
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
              ],
            ),
            body: IndexedStack(index: _currentIndex, children: pages),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          );
        },
      ),
    );
  }

  /// 👉 Page isi statistik dsb
  Widget _buildHomePage(HomeViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, ${vm.username} 👋",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Selamat datang kembali!",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              _buildStatCard(
                "Input Valid",
                vm.validInputs.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                "Pending",
                vm.pendingInputs.toString(),
                Icons.hourglass_bottom,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _buildStatCard(
                "Total Data",
                vm.totalData.toString(),
                Icons.dataset_outlined,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                "Errors",
                vm.errors.toString(),
                Icons.error_outline,
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 👉 Card kecil statistik
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
