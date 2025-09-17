// lib/screens/login/login_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../home/home_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  bool isLoading = false;
  String? emailError;
  String? passwordError;

  Future<void> login(BuildContext context) async {
    // 🔹 Reset error
    emailError = null;
    passwordError = null;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      emailError = "Email cannot be empty";
    }
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
    }

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final token = await _authService.login(email, password);

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      passwordError = "Invalid email or password"; // 🔹 tampil error langsung
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
