import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:latihankasirapp/pages/pelanggan.dart';
import 'package:latihankasirapp/pages/theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Widget child;

  const BottomNavigationBarWidget({Key? key, required this.child}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0; // Track selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: secondaryColor,
        color: secondaryColor, // Update your color as needed
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex, // Keep the current index
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.history, size: 30, color: Colors.white),
          Icon(Icons.people_alt_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate based on selected index
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Handle other pages
              break;
            case 2:
              // Handle other pages
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PelangganPage()),
              );
              break;
            case 4:
              // Handle other pages
              break;
          }
        },
      ),
    );
  }
}
