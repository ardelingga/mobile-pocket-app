import 'package:flutter/material.dart';

class LaporanTransaksiPage extends StatefulWidget {
  // const LaporanTransaksiPage({Key? key}) : super(key: key);

  @override
  _LaporanTransaksiPageState createState() => _LaporanTransaksiPageState();
}

class _LaporanTransaksiPageState extends State<LaporanTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text(
            "Laporan Transaksi Page",
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
