import 'package:flutter/material.dart';
import 'package:mobile_pocket_app/business_logic/constants/constants.dart';
import 'package:mobile_pocket_app/views/ui/dompet_keluar_page.dart';
import 'package:mobile_pocket_app/views/ui/dompet_masuk_page.dart';
import 'package:mobile_pocket_app/views/ui/dompet_page.dart';
import 'package:mobile_pocket_app/views/ui/kategori_page.dart';
import 'package:mobile_pocket_app/views/widgets/menu_item.dart';
import 'package:mobile_pocket_app/views/widgets/menu_parent.dart';

import 'laporan_transaksi_page.dart';

class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late Size size;
  var currentPage = DrawerSelections.dompet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var container;

    if(currentPage == DrawerSelections.dompet){
      container = DompetPage();
    }else if(currentPage == DrawerSelections.kategori){
      container = KategoriPage();
    }else if(currentPage == DrawerSelections.dompet_masuk){
      container = DompetMasukPage();
    }else if(currentPage == DrawerSelections.dompet_keluar){
      container = DompetKeluarPage();
    }else if(currentPage == DrawerSelections.laporan_transaksi){
      container = LaporanTransaksiPage();
    }
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Dompet Ardelingga",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'StratosRegular',
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      drawer: navigationDrawer(),
      body: Container(

      ),
    );
  }

  Widget navigationDrawer(){
    return Drawer(
      child: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                headerDrawer(),
                listMenuDrawer()
              ],
            )
          )
        ),
      ),
    );
  }

  Widget headerDrawer(){
    return Container(
      width: size.width,
      color: Color(0xff8561c5),
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.asset(PATH_ICON+"icon_admin.png"),
            ),
            SizedBox(height: 10,),
            Text(
                "Ardelingga",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'StratosRegular',
                color: Colors.white
              ),
            ),
            Text(
                "ardelingga@pocket.com",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'StratosRegular',
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget listMenuDrawer(){
    return Container(
      // margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          menuParent(size.width, "Master"),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              setState(() {
                currentPage = DrawerSelections.dompet;
              });
            },
            child: menuItem(1, Icons.home, "Dompet", currentPage == DrawerSelections.dompet ? true : false)
          ),
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
                setState(() {
                  currentPage = DrawerSelections.kategori;
                });
              },
              child: menuItem(1, Icons.home, "Kategori", currentPage == DrawerSelections.kategori
                  ? true : false)
          ),
          menuParent(size.width, "Transaksi"),
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
                setState(() {
                  currentPage = DrawerSelections.dompet_masuk;
                });
              },
              child: menuItem(1, Icons.home, "Dompet Masuk", currentPage == DrawerSelections.dompet_masuk ? true : false)
          ),
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
                setState(() {
                  currentPage = DrawerSelections.dompet_keluar;
                });
              },
              child: menuItem(1, Icons.home, "Dompet Masuk", currentPage == DrawerSelections.dompet_keluar ? true : false)
          ),
          menuParent(size.width, "Laporan"),
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
                setState(() {
                  currentPage = DrawerSelections.laporan_transaksi;
                });
              },
              child: menuItem(1, Icons.home, "Laporan Transaksi", currentPage == DrawerSelections.laporan_transaksi ? true : false)
          ),
        ],
      ),
    );
  }
}

enum DrawerSelections{
  dompet,
  kategori,
  dompet_masuk,
  dompet_keluar,
  laporan_transaksi
}
