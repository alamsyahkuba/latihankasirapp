import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/bottomnavigationbar.dart'; // Import BottomNavigationBarWidget
import 'package:latihankasirapp/pages/theme.dart';
import 'package:latihankasirapp/pages/homeappbar.dart';
import 'package:latihankasirapp/pages/itemwidget.dart';
import 'package:latihankasirapp/pages/createproduk.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Homeappbar(),
          Container(
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
                              hintText: "Ketik untuk cari..."),
                          onChanged: (value) {},
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
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Daftar Produk", style: sixTextStyle.copyWith(fontSize: 18)),
                ElevatedButton(
                  onPressed: () {
                    showCreateProductModal(context);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CreateProductPage()),
                    // );
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
              ],
            ),
          ),
          Container(
            child: ItemWidget(searchQuery: ''),
              // decoration: B, design produk list
          ),
        ],
      ),
    );
  }
}
