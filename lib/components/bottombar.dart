import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:latihankasirapp/pages/register.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBar extends StatefulWidget {
  final int initialIndex;
  const BottomBar({super.key, this.initialIndex = 0});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _currentIndex = widget.initialIndex;
  late PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  Future<String?> _getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) {
      print("User ID tidak ditemukan di SharedPreferences");
      return null;
    }

    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('users')
        .select('role')
        .eq('id', userId)
        .maybeSingle();

    return response?['role'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getRole(),
      builder: (context, snapshot) {
        String? role = snapshot.data;

        // Buat daftar halaman sesuai role
        final List<Widget> pages = [
          HomePage(),
          Center(child: Text("Cart")),
          Center(child: Text("History")),
          role != 'Pegawai'
              ? RegisterPage()
              : Center(
                  child: Text("Anda tidak dapat mengakses halaman ini"),
                ),
        ];

        // Buat daftar ikon sesuai role
        final List<Icon> icons = [
          Icon(Icons.home, size: 30, color: whiteColor),
          Icon(Icons.shopping_cart, size: 30, color: whiteColor),
          Icon(Icons.history, size: 30, color: whiteColor),
          Icon(Icons.people_alt_outlined, size: 30, color: whiteColor),
        ];

        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: pages,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: fourthColor,
            color: secondaryColor,
            height: 70,
            items: icons,
            onTap: (index) {
              _pageController.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        );
      },
    );
  }
}
