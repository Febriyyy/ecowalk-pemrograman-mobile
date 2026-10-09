import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/underline_text_field.dart';

/// Satu halaman untuk Lupa Kata Sandi, mode Email atau Nomor HP.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isEmail = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchMode() {
    setState(() {
      _isEmail = !_isEmail;
      _controller.clear();
    });
    _formKey.currentState?.reset();
  }

  String? _validate(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    if (_isEmail) {
      final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
      return ok ? null : 'Format email tidak valid';
    }
    final ok = RegExp(r'^\+?[0-9]{9,15}$').hasMatch(v.trim());
    return ok ? null : 'Nomor HP tidak valid';
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushNamed(context, AppRoutes.newPassword);
  }

  @override
  Widget build(BuildContext context) {
    final target = _isEmail ? 'Email' : 'Nomor Hp';

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
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.notifications_none),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Periksa dan masukan $target untuk mendapatkan kode verifikasi',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    UnderlineTextField(
                      controller: _controller,
                      label: _isEmail ? 'Alamat Email' : 'Nomor Hp',
                      keyboardType: _isEmail
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      validator: _validate,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: _switchMode,
                      child: Text(
                        _isEmail ? 'Gunakan Nomor Hp' : 'Gunakan Email',
                        style: const TextStyle(
                            color: AppColors.link, fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(label: 'KIRIM', onPressed: _onSubmit),
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
