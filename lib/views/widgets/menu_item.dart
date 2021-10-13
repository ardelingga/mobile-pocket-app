import 'package:flutter/material.dart';

Widget menuItem(int id, IconData icon, String title, bool selected){
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    height: 50,
    decoration: BoxDecoration(
      color: selected ? Colors.grey[300] : Colors.white
    ),
    child:Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
            icon,
        ),
        SizedBox(width: 16,),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
              title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'StratosRegular',
            ),
          ),
        )
      ],
    )
  );
}