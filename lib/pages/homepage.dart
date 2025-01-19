import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:latihankasirapp/pages/welcomepages.dart';
import 'package:latihankasirapp/pages/homeappbar.dart';
import 'package:latihankasirapp/pages/itemwidget.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
  }

class _HomePageState extends State<HomePage> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: ListView(children: [
        HomeAppBar(),
        Container(
          //ukuran tinggi sementara
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
        ),
        //item
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(
            "Best Selling",
            style: sixTextStyle,
          ),
        ),
        //Item Widget
        ItemWidget(),
      ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: fourthColor,      
        color: secondaryColor,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: whiteColor,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: whiteColor,
          ),
          Icon(
            Icons.change_circle_outlined,
            size: 30,
            color: whiteColor,
          ),
          Icon(
            Icons.people_outline,
            size: 30,
            color: whiteColor,
          ),
          Icon(
            Icons.person_2_outlined,
            size: 30,
            color: whiteColor,
          )
        ],
      ),
    );
  }
  }
  
  