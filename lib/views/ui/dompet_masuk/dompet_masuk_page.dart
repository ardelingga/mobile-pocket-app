import 'package:flutter/material.dart';

class DompetMasukPage extends StatefulWidget {
  // const DompetMasukPage({Key? key}) : super(key: key);

  @override
  _DompetMasukPageState createState() => _DompetMasukPageState();
}

class _DompetMasukPageState extends State<DompetMasukPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text(
            "Dompet Masuk Page",
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