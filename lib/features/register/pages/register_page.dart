import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../verification/models/verification_args.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmC = TextEditingController();
  bool _agree = false;

  @override
  void dispose() {
    _usernameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _passwordC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Format email tidak valid';
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    final ok = RegExp(r'^\+?[0-9]{9,15}$').hasMatch(v.trim());
    return ok ? null : 'Nomor HP tidak valid';
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';
    return v.length < 8 ? 'Minimal 8 karakter' : null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';
    return v != _passwordC.text ? 'Kata sandi tidak sama' : null;
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushNamed(
      context,
      AppRoutes.verification,
      arguments: VerificationArgs(
        method: VerificationMethod.sms,
        phone: _phoneC.text.trim(),
        email: _emailC.text.trim(),
      ),
    );
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
                    // Jarak atas: disetel supaya posisi logo sama dengan
                    // halaman Masuk. Ubah angka ini kalau perlu digeser.
                    const SizedBox(height: 38),

                    Center(
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BUAT AKUN',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Image.asset(AppAssets.logoGreen, width: 232),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppTextField(
                      controller: _usernameC,
                      hint: 'Nama Pengguna',
                      prefixIcon: Icons.person,
                      validator: _required,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _emailC,
                      hint: 'Email',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _phoneC,
                      hint: 'Nomor Hp',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _passwordC,
                      hint: 'Kata Sandi',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _confirmC,
                      hint: 'Konfirmasi Kata Sandi',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: _validateConfirm,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agree,
                            activeColor: AppColors.primary,
                            onChanged: (v) =>
                                setState(() => _agree = v ?? false),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(fontSize: 12),
                              children: [
                                TextSpan(
                                    text:
                                    'Saya telah membaca dan menyetujui '),
                                TextSpan(
                                  text: 'persyaratan dan privasi pengguna',
                                  style: TextStyle(color: AppColors.link),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'BUAT AKUN',
                      onPressed: _agree ? _onRegister : null,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah punya akun? ',
                            style: TextStyle(fontSize: 12)),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Masuk',
                            style:
                            TextStyle(color: AppColors.link, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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