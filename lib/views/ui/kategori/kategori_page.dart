import 'package:flutter/material.dart';

class KategoriPage extends StatefulWidget {
  // const KategoriPage({Key? key}) : super(key: key);

  @override
  _KategoriPageState createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text(
            "Kategori Page",
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
