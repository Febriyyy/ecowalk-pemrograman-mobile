import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/underline_text_field.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordC = TextEditingController();
  final _confirmC = TextEditingController();

  @override
  void dispose() {
    _passwordC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';
    return v.length < 8 ? 'Minimal 8 karakter' : null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';
    return v != _passwordC.text ? 'Kata sandi tidak sama' : null;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kata sandi berhasil diubah')),
    );
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(title: 'LUPA KATA SANDI'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      'Masukan Kata Sandi Baru',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    UnderlineTextField(
                      controller: _passwordC,
                      hint: 'Kata Sandi Baru',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    UnderlineTextField(
                      controller: _confirmC,
                      hint: 'Konfirmasi Kata Sandi',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: _validateConfirm,
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                        label: 'UBAH KATA SANDI', onPressed: _onSubmit),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
