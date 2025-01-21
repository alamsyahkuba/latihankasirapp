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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ketik untuk cari..."
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      size: 27,
                      
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //item
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
            "Daftar Produk",
            style: sixTextStyle.copyWith(
              fontSize: 18,
            )
          ),
          ElevatedButton(
            onPressed: () {
              print("Tambah Produk");
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: fourthColor,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
          ]
          ),
        ),
        //Item Widget
        ItemWidget(),
      ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: fourthColor,  
        onTap: (index) {},
        height: 70,    
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
            Icons.history,
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
  
  