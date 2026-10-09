import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Bottom navigation 4 tab. Tab aktif tampil menonjol dalam lingkaran putih.
/// Label tab selain AKUN masih sementara, ganti di daftar [_items].
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static final List<_NavItemData> _items = [
    _NavItemData(
      'BERANDA',
      (color, size) => Icon(Icons.home_outlined, color: color, size: size),
    ),
    _NavItemData(
      'MENU 2',
      (color, size) => Icon(Icons.verified_user, color: color, size: size),
    ),
    _NavItemData(
      'MENU 3',
      (color, size) => _HeartBubble(color: color, size: size),
    ),
    _NavItemData(
      'AKUN',
      (color, size) => Icon(Icons.person, color: color, size: size),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              return Expanded(
                child: i == currentIndex
                    ? _ActiveItem(data: item)
                    : InkWell(
                        onTap: () => onTap(i),
                        child: Center(child: item.icon(Colors.white, 28)),
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String label;
  final Widget Function(Color color, double size) icon;

  const _NavItemData(this.label, this.icon);
}

class _ActiveItem extends StatelessWidget {
  final _NavItemData data;

  const _ActiveItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: data.icon(AppColors.primary, 28)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Text(
              data.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeartBubble extends StatelessWidget {
  final Color color;
  final double size;

  const _HeartBubble({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    final inner = color == Colors.white ? AppColors.primary : Colors.white;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.chat_bubble, color: color, size: size),
          Padding(
            padding: EdgeInsets.only(bottom: size * 0.1),
            child: Icon(Icons.favorite, color: inner, size: size * 0.45),
          ),
        ],
      ),
    );
  }
}
