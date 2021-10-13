import 'package:flutter/material.dart';
import 'package:mobile_pocket_app2/business_logic/constants/colors.dart';
import 'package:mobile_pocket_app2/business_logic/constants/popup_menu.dart';
import 'package:mobile_pocket_app2/business_logic/models/add_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/item_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/services/api_services/api_service.dart';
import 'package:mobile_pocket_app2/business_logic/utils/flutter_toast.dart';
import 'package:mobile_pocket_app2/views/ui/dompet/dompet_tambah.dart';
import 'package:mobile_pocket_app2/views/widgets/item_tabbar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'dompet_detail.dart';
import 'dompet_edit.dart';

class DompetPage extends StatefulWidget {
  // const DompetPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKeyParent;
  DompetPage(this._scaffoldKeyParent);
  @override
  _DompetPageState createState() => _DompetPageState();
}

class _DompetPageState extends State<DompetPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Size size;
  double appbarHeight;
  double statusBarHeight;

  bool isLoadingProgressbar = false;

  List<ItemDompetModel> listItemDompetAll = [];
  List<ItemDompetModel> listItemDompetAktif = [];
  List<ItemDompetModel> listItemDompetTdkAktif = [];

  List<ItemDompetModel> _searchListItemDompetAll = [];
  List<ItemDompetModel> _searchListItemDompetAktif = [];
  List<ItemDompetModel> _searchListItemDompetTdkAktif = [];

  bool isSearching = false;

  TextEditingController tf_searching = TextEditingController();
  FocusNode fn_search = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    firstAction();
  }

  Future<void> firstAction() async {
    await getListDompet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    appbarHeight = AppBar().preferredSize.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
    return ModalProgressHUD(
      inAsyncCall: isLoadingProgressbar,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          title: !isSearching
              ? Text(
                  "Dompet Ardelingga",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'StratosRegular',
                      color: Colors.white),
                )
              : TextField(
                  controller: tf_searching,
                  focusNode: fn_search,
                  onChanged: (text){
                    onSearchTextChanged(
                      tabController.index == 0 ? _searchListItemDompetAll :
                      tabController.index == 1 ? _searchListItemDompetAktif : _searchListItemDompetTdkAktif,
                      tabController.index == 0 ? listItemDompetAll :
                      tabController.index == 1 ? listItemDompetAktif : listItemDompetTdkAktif,
                      text
                    );
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Cari dompet',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
          actions: [
            IconButton(
              icon: !isSearching ? Icon(Icons.search) : Icon(Icons.close),
              onPressed: () {
                !isSearching ? fn_search.requestFocus() : FocusScope.of(context).requestFocus(FocusNode());
                isSearching ? tf_searching.clear() : null;
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black87,
                        indicatorWeight: 3,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'StratosRegular',
                        ),
                        tabs: [
                          itemTabbar("Semua", listItemDompetAll.length),
                          itemTabbar("Aktif", listItemDompetAktif.length),
                          itemTabbar(
                              "Tidak Aktif", listItemDompetTdkAktif.length),
                        ]),
                  ),
                  Flexible(
                    child: Container(
                      width: size.width,
                      height:
                          (size.height - (appbarHeight + statusBarHeight + 50)),
                      // color: Colors.blue,
                      child: TabBarView(controller: tabController, children: [
                        contentDompet(
                            listItemDompetAll, _searchListItemDompetAll),
                        contentDompet(
                            listItemDompetAktif, _searchListItemDompetAktif),
                        contentDompet(
                            listItemDompetTdkAktif, _searchListItemDompetAktif),
                      ]),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DompetTambah(getListDompet)));
                    },
                    child: Icon(Icons.add),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getListDompet() async {
    await showLoading();
    var req = await ApiService.getListDompet("0");
    ListDompetModel response = ListDompetModel.fromJson(req);

    print(req.toString());
    print(response.meta.message);

    var data = response.data;
    listItemDompetAll.clear();
    listItemDompetAktif.clear();
    listItemDompetTdkAktif.clear();
    for (int i = 0; i < data.length; i++) {
      listItemDompetAll.add(data[i]);

      if (data[i].statusId == 1) {
        listItemDompetAktif.add(data[i]);
      } else {
        listItemDompetTdkAktif.add(data[i]);
      }
    }
    setState(() {});

    print("LIST ALL => " + listItemDompetAll.toString());
    print("LIST AKTIF => " + listItemDompetAktif.toString());
    print("LIST TDK AKTIF => " + listItemDompetTdkAktif.toString());

    await hideLoading();
  }

  Widget contentDompet(
      List<ItemDompetModel> listItem, List<ItemDompetModel> searchItem) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            children: [
              searchItem.length != 0 || tf_searching.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchItem.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return itemDompet(searchItem[i]);
                      })
                  : ListView.builder(
                      itemCount: listItem.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return itemDompet(listItem[i]);
                      }),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDompet(ItemDompetModel itemData) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.yellow,
          border:
              Border(bottom: BorderSide(color: Colors.grey[300], width: 2))),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Stack(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(width: 5, color: Colors.purple)),
                      child: Center(
                        child: Text(itemData.nama.substring(0, 1),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'StratosRegular',
                                color: Colors.purple)),
                      ),
                    )),
                    Flexible(
                        child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemData.nama,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'StratosRegular',
                                  color: Colors.black87)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(itemData.referensi.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'StratosRegular',
                                  color: Colors.black87)),
                          Text(itemData.deskripsi,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'StratosRegular',
                                  color: Colors.black87)),
                          Text(itemData.statusName,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'StratosRegular',
                                  color: Colors.black87)),
                        ],
                      ),
                    )),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          ),
                      child: PopupMenuButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onSelected: (result) {
                            if (result == PopupMenuConst.DETAIL) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DompetDetail(itemData, getListDompet)));
                            } else if (result == PopupMenuConst.UBAH) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DompetEdit(itemData, getListDompet)));
                            } else if (result == PopupMenuConst.AKTIF) {
                              editDompet(itemData, "2");
                            } else if (result == PopupMenuConst.TDK_AKTIF) {
                              editDompet(itemData, "1");
                            }
                          },
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("Detail"),
                                  value: PopupMenuConst.DETAIL,
                                ),
                                PopupMenuItem(
                                  child: Text("Ubah"),
                                  value: PopupMenuConst.UBAH,
                                ),
                                PopupMenuItem(
                                  child: Text(itemData.statusId == 1
                                      ? "Tidak Aktif"
                                      : "Aktif"),
                                  // child: Text("Tidak Aktif"),
                                  value: itemData.statusId == 1
                                      ? PopupMenuConst.AKTIF
                                      : PopupMenuConst.TDK_AKTIF,
                                ),
                              ])),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onSearchTextChanged(List<ItemDompetModel> _searchList, List<ItemDompetModel> listItem, String text) async {
    print("TAB BAR => "+tabController.index.toString());
    print("LIST COUNT => "+listItem.length.toString());
    print("LIST SEARCH COUNT => "+_searchList.length.toString());
    print("LIST DATA => "+listItem.toString());
    _searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    listItem.forEach((itemDompet) {
      if (itemDompet.nama.toLowerCase().contains(text.toLowerCase()) ||
          itemDompet.referensi.toString().toLowerCase().contains(text.toLowerCase()) ||
          itemDompet.deskripsi.toLowerCase().contains(text.toLowerCase()))
          
        _searchList.add(itemDompet);
    });

    setState(() {});
  }

  Future<void> editDompet(ItemDompetModel data, String status_id) async {
    String id = data.id.toString();
    String nama = data.nama.toString();
    String referensi = data.referensi.toString();
    String deskripsi = data.deskripsi.toString();

    print("ID => " + id);
    print("NAMA => " + nama);
    print("REFERENSI => " + referensi);
    print("DESKRIPSI => " + deskripsi);
    print("STATUS NAME => " + data.statusName);
    print("STATUS ID => " + status_id);

    showLoading();
    var req =
        await ApiService.editDompet(id, nama, referensi, deskripsi, status_id);
    AddDompetModel res = AddDompetModel.fromJson(req);
    hideLoading();

    if (res.meta.code == 200) {
      FlutterToast.success("Berhasil Edit Status!");
      getListDompet();
    } else {
      FlutterToast.failed("GAGAL!");
    }
  }

  Future<void> showLoading() {
    setState(() => isLoadingProgressbar = true);
  }

  Future<void> hideLoading() {
    setState(() => isLoadingProgressbar = false);
  }
}
