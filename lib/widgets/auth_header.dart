import 'package:flutter/material.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_colors.dart';

/// Header dengan latar miring + logo, dipakai di halaman verifikasi
/// dan lupa kata sandi. [title] opsional, tampil di bawah logo.
class AuthHeader extends StatelessWidget {
  final String? title;

  const AuthHeader({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: _SlantClipper(),
              child: Container(color: AppColors.headerBg),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.logoGreen, width: 232),
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.44)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
