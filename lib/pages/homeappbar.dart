import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'theme.dart';

class HomeAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Colors.red[900],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "Dasbor",
              style: thirdTextStyle,
            ),
          ),
          Spacer(),
          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: Text(
              "3",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // child: InkWell(
            //   onTap: () {},
            //   child: Icon(
            //     Icons.c,
            //     size: 32,
            //     color: Colors.red[600],
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}