import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class ItemWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 1; i < 8; i++)
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          decoration: BoxDecoration(
            color: Color(0xF8FAFC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent[700],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "images/login.jpg",
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nama Produk",
                  style: thirdTextStyle,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Deskripsi Produk",
                  style: fiveTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.redAccent[700],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}