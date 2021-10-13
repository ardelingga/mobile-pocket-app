import 'package:flutter/material.dart';

Widget menuParent(double widthWidget, String title){
  return Container(
      width: widthWidget,
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child:Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'StratosRegular',
          ),
        ),
      )
  );
}