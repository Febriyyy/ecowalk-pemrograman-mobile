import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: icon != null ? Icon(icon, size: 24) : null,
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 28),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFBDBDBD)),
      ],
    );
  }
}
