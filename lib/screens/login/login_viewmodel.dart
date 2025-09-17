import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart'; // Pastikan path ini benar
import '../home/home_screen.dart'; // Pastikan path ini benar

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  bool isLoading = false;
  String? emailError;
  String? passwordError;

  // State tambahan untuk fitur 'intip password'
  bool isPasswordHidden = true;

  // Function untuk mengubah state password
  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    emailError = null;
    passwordError = null;
    notifyListeners();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) emailError = "Email tidak boleh kosong";
    if (password.isEmpty) passwordError = "Password tidak boleh kosong";

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
      } else {
        // Handle case where login is successful but token is null
        passwordError = "Gagal login, coba lagi";
      }
    } catch (e) {
      passwordError = "Email atau password salah";
      debugPrint("Login error: $e"); // Untuk debugging
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
