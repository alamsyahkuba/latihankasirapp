import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:latihankasirapp/pages/register.dart';
import 'package:latihankasirapp/pages/theme.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Cart")),
    Center(child: Text("History")),
    RegisterPage(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: fourthColor,
        color: secondaryColor,
        height: 70,
        items: [
          Icon(Icons.home, size: 30, color: whiteColor),
          Icon(Icons.shopping_cart, size: 30, color: whiteColor),
          Icon(Icons.history, size: 30, color: whiteColor),
          Icon(Icons.people_outline, size: 30, color: whiteColor),
          Icon(Icons.person_2_outlined, size: 30, color: whiteColor),
        ],
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
  }
}
