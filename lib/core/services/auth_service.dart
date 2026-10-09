import '../constants/dummy_account.dart';

/// Logika autentikasi dipisah dari tampilan.
/// Nanti kalau sudah ada API, cukup ganti isi fungsi-fungsi ini.
class AuthService {
  static Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return username.trim() == DummyAccount.username &&
        password == DummyAccount.password;
  }

  static Future<bool> verifyOtp(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return code == DummyAccount.otp;
  }
}
