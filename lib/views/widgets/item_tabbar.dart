import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pocket_app2/business_logic/constants/colors.dart';

Widget itemTabbar(String title, int itemCount) {
  return Tab(
    child: Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
              height: 20,
              width: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: colorPrimary),
              child: Center(
                  child: Text(
                itemCount.toString(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'StratosRegular',
                ),
              ))),
        ),
      ],
    )),
  );
}
