import 'package:flutter/material.dart';

import '../../features/forgot_password/pages/forgot_password_page.dart';
import '../../features/forgot_password/pages/new_password_page.dart';
import '../../features/login/pages/login_page.dart';
import '../../features/login/pages/splash_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/register/pages/register_page.dart';
import '../../features/verification/models/verification_args.dart';
import '../../features/verification/pages/verification_page.dart';
import '../../widgets/placeholder_page.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const verification = '/verification';
  static const forgotPassword = '/forgot-password';
  static const newPassword = '/new-password';
  static const profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _page(const SplashPage());
      case login:
        return _page(const LoginPage());
      case register:
        return _page(const RegisterPage());
      case verification:
        final args = settings.arguments is VerificationArgs
            ? settings.arguments as VerificationArgs
            : const VerificationArgs();
        return _page(VerificationPage(args: args));
      case forgotPassword:
        return _page(const ForgotPasswordPage());
      case newPassword:
        return _page(const NewPasswordPage());
      case profile:
        return _page(const MainPage(initialIndex: 3));
      default:
        // Halaman yang belum dibuat ditampilkan sebagai placeholder.
        return _page(PlaceholderPage(title: settings.name ?? ''));
    }
  }

  static MaterialPageRoute _page(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}
