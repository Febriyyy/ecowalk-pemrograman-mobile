enum VerificationMethod { sms, email }

/// Data yang dikirim ke halaman verifikasi.
class VerificationArgs {
  final VerificationMethod method;
  final String phone;
  final String email;

  const VerificationArgs({
    this.method = VerificationMethod.sms,
    this.phone = '+6281234567890',
    this.email = 'contohsample@gmail.com',
  });
}
