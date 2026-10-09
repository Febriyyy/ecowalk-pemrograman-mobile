import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/primary_button.dart';
import '../models/verification_args.dart';
import '../widgets/otp_input.dart';

/// Satu halaman untuk verifikasi lewat SMS maupun Email.
class VerificationPage extends StatefulWidget {
  final VerificationArgs args;

  const VerificationPage({super.key, required this.args});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late VerificationMethod _method = widget.args.method;
  String _code = '';
  int _resetKey = 0;
  bool _isLoading = false;

  bool get _isSms => _method == VerificationMethod.sms;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _switchMethod() {
    setState(() {
      _method = _isSms ? VerificationMethod.email : VerificationMethod.sms;
      _code = '';
      _resetKey++; // mengosongkan kotak OTP
    });
  }

  Future<void> _onSubmit() async {
    if (_code.length < 4) {
      _showMessage('Masukkan 4 digit kode verifikasi');
      return;
    }
    setState(() => _isLoading = true);
    final ok = await AuthService.verifyOtp(_code);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (ok) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.profile, (route) => false);
    } else {
      _showMessage('Kode verifikasi salah');
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = _isSms ? widget.args.phone : widget.args.email;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.check),
                      SizedBox(width: 12),
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PhoneChatIcon(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.text,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'Periksa dan ketik kode verifikasi yang telah dikirimkan ke ',
                              ),
                              TextSpan(
                                text: target,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  OtpInput(
                    key: ValueKey(_resetKey),
                    onChanged: (v) => _code = v,
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: _switchMethod,
                    child: Text(
                      _isSms
                          ? 'Verifikasi menggunakan Email'
                          : 'Verifikasi menggunakan No. Hp',
                      style: const TextStyle(
                          color: AppColors.link, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'KIRIM',
                    isLoading: _isLoading,
                    onPressed: _onSubmit,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: InkWell(
                      onTap: () => _showMessage('Kode dikirim ulang'),
                      child: const Text(
                        'Kirim Ulang Kode',
                        style: TextStyle(
                            color: AppColors.primary, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneChatIcon extends StatelessWidget {
  const _PhoneChatIcon();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 36,
      height: 40,
      child: Stack(
        children: [
          Icon(Icons.smartphone, size: 36),
          Positioned(
            right: 0,
            bottom: 0,
            child: Icon(Icons.chat_bubble, size: 16),
          ),
        ],
      ),
    );
  }
}
