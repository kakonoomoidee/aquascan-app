import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? username;
  int? validInputs;
  int? pendingInputs;
  int? totalData;
  int? errors;

  HomeViewModel() {
    fetchDashboardData(); // Langsung panggil data saat ViewModel dibuat
  }

  // Simulasi ambil data dari API
  Future<void> fetchDashboardData() async {
    _isLoading = true;
    notifyListeners();

    // Anggap aja ini proses manggil API selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    username = "Petugas PDAM"; // Data dari API
    validInputs = 120;
    pendingInputs = 15;
    totalData = 135;
    errors = 5;

    _isLoading = false;
    notifyListeners();
  }
}
