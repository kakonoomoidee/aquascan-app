import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_viewmodel.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _LoginHeader(),
                  const SizedBox(height: 48),
                  const _LoginForm(),
                  const SizedBox(height: 16),
                  Consumer<LoginViewModel>(
                    builder: (context, vm, _) {
                      return PrimaryButton(
                        text: "Login",
                        isLoading: vm.isLoading,
                        onPressed: () => vm.login(context),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const _SignUpPrompt(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for header section (logo and welcome text)
class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/aquascan.png', // Pastikan path logo ada di pubspec.yaml
          height: 80,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.water_drop_rounded,
            size: 80,
            color: Color(0xFF0077B6),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Selamat Datang",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Masuk untuk melanjutkan ke Aplikasi AquaScan",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

// Widget for the form section (email and password)
class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    const primaryColor = Color(0xFF0077B6);
    const secondaryColor = Color(0xFFEBF5FF);

    return Column(
      children: [
        TextField(
          controller: vm.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration(
            labelText: "Email atau Nomor Pegawai",
            hintText: "contoh@email.com",
            prefixIcon: Icons.alternate_email_rounded,
            errorText: vm.emailError,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: vm.passwordController,
          obscureText: vm.isPasswordHidden,
          decoration:
              _inputDecoration(
                labelText: "Password",
                hintText: "Masukkan password Anda",
                prefixIcon: Icons.lock_outline_rounded,
                errorText: vm.passwordError,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    vm.isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: vm.togglePasswordVisibility,
                ),
              ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    String? errorText,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: Icon(prefixIcon, color: primaryColor),
      filled: true,
      fillColor: secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }
}

// Widget for the "Hubungi Admin" prompt
class _SignUpPrompt extends StatelessWidget {
  const _SignUpPrompt();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Bermasalah saat login?"),
        TextButton(
          onPressed: () {
            // TODO: Maybe show an info dialog with admin contact
          },
          child: const Text(
            "Hubungi Admin",
            style: TextStyle(
              color: Color(0xFF0077B6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
