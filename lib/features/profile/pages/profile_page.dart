import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dummy_account.dart';
import '../../../core/routes/app_routes.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showUnavailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Halaman belum dibuat')),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Container(height: 160, color: AppColors.primary),
                  const Positioned(
                    top: 92,
                    left: 0,
                    right: 0,
                    child: Center(child: _Avatar()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              DummyAccount.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  DummyAccount.email,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    onTap: () => _showUnavailable(context),
                  ),
                  ProfileMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profil',
                    onTap: () => _showUnavailable(context),
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Kebijakan Privasi',
                    onTap: () => _showUnavailable(context),
                  ),
                  ProfileMenuItem(
                    icon: Icons.info_outline,
                    title: 'Tentang Kami',
                    onTap: () => _showUnavailable(context),
                  ),
                  ProfileMenuItem(
                    icon: Icons.description_outlined,
                    title: 'Ketentuan Layanan',
                    onTap: () => _showUnavailable(context),
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Keluar',
                    showDivider: false,
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

/// Foto profil dari assets/images/profile.jpg (ikon orang kalau file belum ada).
class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      height: 126,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.profilePhoto,
          fit: BoxFit.cover,
          // Kalau file foto belum ada, tampilkan ikon orang.
          errorBuilder: (context, error, stackTrace) => const ColoredBox(
            color: AppColors.fieldFill,
            child: Center(
              child: Icon(Icons.person, size: 72, color: AppColors.icon),
            ),
          ),
        ),
      ),
    );
  }
}