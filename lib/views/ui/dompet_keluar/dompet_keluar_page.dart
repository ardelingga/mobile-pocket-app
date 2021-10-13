import 'package:flutter/material.dart';

class DompetKeluarPage extends StatefulWidget {

  @override
  _DompetKeluarPageState createState() => _DompetKeluarPageState();
}

class _DompetKeluarPageState extends State<DompetKeluarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text(
            "Dompet Keluar Page",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'StratosRegular',
            ),
          ),
        )
    );
  }
}
