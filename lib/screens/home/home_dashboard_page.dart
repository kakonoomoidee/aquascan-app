import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0077B6)),
            );
          }

          return RefreshIndicator(
            onRefresh: vm.fetchDashboardData,
            color: const Color(0xFF0077B6),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _WelcomeHeader(username: vm.username),
                  const SizedBox(height: 24),
                  _StatsGrid(vm: vm),
                  const SizedBox(height: 32),
                  const _CallToAction(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  final String? username;
  const _WelcomeHeader({this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, ${username ?? 'Petugas'} 👋",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Selamat datang, ini ringkasan pekerjaanmu hari ini.",
          style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
        ),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final HomeViewModel vm;
  const _StatsGrid({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _StatCard(
              title: "Input Valid",
              value: vm.validInputs,
              icon: Icons.check_circle_outline_rounded,
              color: Colors.green,
            ),
            const SizedBox(width: 16),
            _StatCard(
              title: "Menunggu Validasi",
              value: vm.pendingInputs,
              icon: Icons.hourglass_bottom_rounded,
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _StatCard(
              title: "Total Data Masuk",
              value: vm.totalData,
              icon: Icons.dataset_outlined,
              color: const Color(0xFF0077B6),
            ),
            const SizedBox(width: 16),
            _StatCard(
              title: "Laporan Ditolak",
              value: vm.errors,
              icon: Icons.error_outline_rounded,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int? value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value?.toString() ?? "-",
              style: TextStyle(
                fontSize: 22,
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

class _CallToAction extends StatelessWidget {
  const _CallToAction();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text("Mulai Scan Meteran"),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF0077B6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
