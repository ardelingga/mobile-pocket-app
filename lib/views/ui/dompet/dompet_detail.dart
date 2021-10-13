import 'package:flutter/material.dart';
import 'package:mobile_pocket_app2/business_logic/constants/colors.dart';
import 'package:mobile_pocket_app2/business_logic/models/add_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/item_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/status_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_status_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/services/api_services/api_service.dart';
import 'package:mobile_pocket_app2/business_logic/utils/flutter_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DompetDetail extends StatefulWidget {
  // DompetTambah({Key? key}) : super(key: key);
  ItemDompetModel data;
  Function refreshPage;
  DompetDetail(this.data, this.refreshPage);

  @override
  _DompetDetailState createState() => _DompetDetailState();
}

class _DompetDetailState extends State<DompetDetail> {
  bool isLoadingProgressbar = false;

  Size size;
  double appbarHeight;
  double statusBarHeight;

  TextEditingController tf_nama = TextEditingController();
  TextEditingController tf_referensi = TextEditingController();
  TextEditingController tf_deskripsi = TextEditingController();

  List<StatusDompetModel> listStatusDompet = [];
  StatusDompetModel valueStatus;

  bool btnEnable = false;

  @override
  void initState() {
    super.initState();
    firstAction();
  }

  Future<void> firstAction() async {
    setState(() {
      tf_nama.text = widget.data.nama;
      tf_referensi.text = widget.data.referensi.toString();
      tf_deskripsi.text = widget.data.deskripsi;
    });
    await getStatusDompet();
    print(widget.data.statusId);
    print(widget.data.statusName);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    appbarHeight = AppBar().preferredSize.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
    return ModalProgressHUD(
      inAsyncCall: isLoadingProgressbar,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(
              "Detail #"+widget.data.nama,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'StratosRegular',
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: (size.height - (appbarHeight + statusBarHeight + 40)),
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_nama,
                          decoration: InputDecoration(),
                          readOnly: true,
                          onChanged: (text) {
                            setState(() {
                              if (tf_nama.text.length >= 5 &&
                                  tf_referensi.text.length <= 20 &&
                                  valueStatus != null) {
                                btnEnable = true;
                              } else {
                                btnEnable = false;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        tf_nama.text.length == 0 || tf_nama.text.length >= 5
                            ? Container()
                            : Text(
                                "Masukan nama minimal 5 huruf",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'StratosRegular',
                                    color: Colors.red),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Referensi",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_referensi,
                          readOnly: true,
                          decoration: InputDecoration(),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            setState(() {
                              if (tf_nama.text.length >= 5 &&
                                  tf_referensi.text.length <= 20 &&
                                  valueStatus != null) {
                                btnEnable = true;
                              } else {
                                btnEnable = false;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        tf_referensi.text.length > 20
                            ? Text(
                                "Referensi Max 20",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'StratosRegular',
                                    color: Colors.red),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Deskripsi",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_deskripsi,
                          readOnly: true,
                          decoration: InputDecoration(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<StatusDompetModel>(
                            value: valueStatus,
                            hint: Text("Pilih status"),
                            isExpanded: true,
                            // onChanged: (StatusDompetModel newValue) {
                            //   setState(() {
                            //     valueStatus = newValue;
                            //     if (tf_nama.text.length >= 5 &&
                            //         tf_referensi.text.length <= 20 &&
                            //         valueStatus != null) {
                            //       btnEnable = true;
                            //     } else {
                            //       btnEnable = false;
                            //     }
                            //   });
                            // },
                            onChanged: null,
                            items: listStatusDompet
                                .map<DropdownMenuItem<StatusDompetModel>>(
                                    (valueItem) {
                              return DropdownMenuItem<StatusDompetModel>(
                                  value: valueItem,
                                  child: Text(valueItem.nama));
                            }).toList()),
                        // :
                        // DropdownButton(
                        //   isExpanded: true,
                        //   hint: Text("Pilih status"),
                        //   items: [
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController tf_controller, String title, String hint) {
    return Column(
      children: [
        Text(
          "Tambah Dompet",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'StratosRegular',
              color: Colors.white),
        ),
        TextField(
          controller: tf_controller,
          decoration: InputDecoration(),
        )
      ],
    );
  }

  Future<void> getStatusDompet() async {
    await showLoading();
    var req = await ApiService.getStatusDompet();
    ListStatusDompetModel res = ListStatusDompetModel.fromJson(req);
    var data = res.data;

    listStatusDompet = data;
    for(int i = 0; i < data.length; i++){
      // listStatusDompet.add(StatusDompetModel(id: data[i].id, nama: data[i].nama));
      if(data[i].id == widget.data.statusId && data[i].nama == widget.data.statusName){
        valueStatus = data[i];
      }
    }

    setState(() {
    });
    await hideLoading();
  }

  Future<void> editDompet() async {
    String id = widget.data.id.toString();
    String nama = tf_nama.text.toString();
    String referensi = tf_referensi.text.toString();
    String deskripsi = tf_deskripsi.text.toString();
    String status_id = valueStatus.id.toString();

    print("ID => " + widget.data.id.toString());
    print("NAMA => " + nama);
    print("REFERENSI => " + referensi);
    print("DESKRIPSI => " + deskripsi);
    print("STATUS NAME => " + valueStatus.nama);
    print("STATUS ID => " + status_id);

    showLoading();
    var req = await ApiService.editDompet(
        id, nama, referensi, deskripsi, status_id);
    AddDompetModel res = AddDompetModel.fromJson(req);

    if (res.meta.code == 200) {
      FlutterToast.success("Berhasil Edit Data!");
      widget.refreshPage();
      Navigator.of(context).pop();
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
