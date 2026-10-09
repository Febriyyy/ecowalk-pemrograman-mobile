import 'package:flutter/material.dart';

import '../../../widgets/app_bottom_nav.dart';
import '../../../widgets/placeholder_page.dart';
import '../../profile/pages/profile_page.dart';

/// Kerangka utama setelah login: isi halaman + bottom navigation.
class MainPage extends StatefulWidget {
  final int initialIndex;

  const MainPage({super.key, this.initialIndex = 3});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          PlaceholderPage(title: 'Beranda'),
          PlaceholderPage(title: 'Menu 2'),
          PlaceholderPage(title: 'Menu 3'),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
