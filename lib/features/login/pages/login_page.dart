import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../widgets/google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _passwordC = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Wajib diisi' : null;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final success = await AuthService.login(_usernameC.text, _passwordC.text);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.profile);
    } else {
      _showMessage('Nama pengguna atau kata sandi salah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Jarak atas: perbesar angka ini untuk menggeser
                    // seluruh konten lebih ke bawah.
                    const SizedBox(height: 80),

                    // Header: teks "MASUK" di tengah logo
                    const Text(
                      'MASUK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Image.asset(AppAssets.logoGreen, width: 232),
                    ),

                    const SizedBox(height: 46),

                    AppTextField(
                      controller: _usernameC,
                      label: 'Nama Pengguna',
                      prefixIcon: Icons.person,
                      validator: _required,
                    ),
                    const SizedBox(height: 18),
                    AppTextField(
                      controller: _passwordC,
                      label: 'Kata Sandi',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: _required,
                    ),

                    const SizedBox(height: 30),

                    PrimaryButton(
                      label: 'MASUK',
                      isLoading: _isLoading,
                      onPressed: _onLogin,
                    ),

                    const SizedBox(height: 14),

                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.forgotPassword),
                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            color: AppColors.link,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Pemisah: Atau
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                              color: Colors.grey.shade300, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Atau',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                              color: Colors.grey.shade300, thickness: 1),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    GoogleButton(
                      onTap: () => _showMessage('Login Google belum tersedia'),
                    ),

                    const SizedBox(height: 36),

                    // Footer: Tidak punya akun? Daftar disini
                    Center(
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.register),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade800,
                            ),
                            children: const [
                              TextSpan(text: 'Tidak punya akun? '),
                              TextSpan(
                                text: 'Daftar disini',
                                style: TextStyle(
                                  color: AppColors.link,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}