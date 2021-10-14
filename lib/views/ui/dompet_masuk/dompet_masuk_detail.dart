import 'package:flutter/material.dart';
import 'package:mobile_pocket_app2/business_logic/constants/colors.dart';
import 'package:mobile_pocket_app2/business_logic/models/add_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/id_generator_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/item_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/item_kategori_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/item_transaksi_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/data/status_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_dompet_masuk_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_kategori_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/list_status_dompet_model.dart';
import 'package:mobile_pocket_app2/business_logic/models/res_id_generator_model.dart';
import 'package:mobile_pocket_app2/business_logic/services/api_services/api_service.dart';
import 'package:mobile_pocket_app2/business_logic/utils/flutter_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DompetMasukDetail extends StatefulWidget {
  // DompetTambah({Key? key}) : super(key: key);
  Function refreshPage;
  ItemTransaksiModel itemData;
  DompetMasukDetail(this.itemData, this.refreshPage);

  @override
  _DompetMasukDetailState createState() => _DompetMasukDetailState();
}

class _DompetMasukDetailState extends State<DompetMasukDetail> {
  bool isLoadingProgressbar = false;

  Size size;
  double appbarHeight;
  double statusBarHeight;
  DateTime selectedDate = DateTime.now();

  TextEditingController tf_kode = TextEditingController();
  TextEditingController tf_date = TextEditingController();
  TextEditingController tf_tanggal = TextEditingController();
  TextEditingController tf_deskripsi = TextEditingController();
  ItemKategoriModel valueKategori;
  ItemDompetModel valueDompet;
  TextEditingController tf_nilai = TextEditingController();
  StatusDompetModel valueStatus;

  List<ItemKategoriModel> listKategori = [];
  List<ItemDompetModel> listDompet = [];
  List<StatusDompetModel> listStatus = [];

  IdGeneratorModel idGenerator;

  @override
  void initState() {
    super.initState();
    firstAction();
  }

  Future<void> firstAction() async {
    setState(() {
      tf_kode.text = widget.itemData.kode;
      tf_tanggal.text = widget.itemData.tanggal;
      tf_deskripsi.text = widget.itemData.deskripsi;
      tf_nilai.text = widget.itemData.nilai.toString();
    });
    await generateId();
    await getListKategori();
    await getListDompet();
    await getStatusDompet();

    setState(() {
      tf_kode.text = widget.itemData.kode;
      tf_tanggal.text = widget.itemData.tanggal;
      tf_deskripsi.text = widget.itemData.deskripsi;
      tf_nilai.text = widget.itemData.nilai.toString();
    });
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
              "Detail #"+widget.itemData.kode,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'StratosRegular',
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: (size.height - (appbarHeight + statusBarHeight + 40)),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kode",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_kode,
                          decoration: InputDecoration(),
                          readOnly: true,
                          enabled: false,
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Tanggal",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_tanggal,
                          decoration: InputDecoration(),
                          readOnly: true,
                          enabled: false,
                          onTap: () {
                            // _selectDate(context);
                          },
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
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
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Kategori",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<ItemKategoriModel>(
                            value: valueKategori,
                            hint: Text("Pilih Kategori"),
                            isExpanded: true,
                            onChanged: null,
                            items: listKategori
                                .map<DropdownMenuItem<ItemKategoriModel>>(
                                    (valueItem) {
                              return DropdownMenuItem<ItemKategoriModel>(
                                  value: valueItem,
                                  child: Text(valueItem.nama));
                            }).toList()),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Dompet",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<ItemDompetModel>(
                            value: valueDompet,
                            hint: Text("Pilih dompet"),
                            isExpanded: true,
                            onChanged: null,
                            items: listDompet
                                .map<DropdownMenuItem<ItemDompetModel>>(
                                    (valueItem) {
                              return DropdownMenuItem<ItemDompetModel>(
                                  value: valueItem,
                                  child: Text(valueItem.nama));
                            }).toList()),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Nilai",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'StratosRegular',
                              color: Colors.black87),
                        ),
                        TextField(
                          controller: tf_nilai,
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(),
                          keyboardType: TextInputType.number,
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
                            onChanged: null,
                            items: listStatus
                                .map<DropdownMenuItem<StatusDompetModel>>(
                                    (valueItem) {
                              return DropdownMenuItem<StatusDompetModel>(
                                  value: valueItem,
                                  child: Text(valueItem.nama));
                            }).toList()),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    print("DATE -> " + selectedDate.toString());
    setState(() => tf_tanggal.text = selectedDate.toString().substring(0, 10));
  }

  Future<void> generateId() async {
    await showLoading();
    var req = await ApiService.generateId("WIN");
    ResIdGeneratorModel res = ResIdGeneratorModel.fromJson(req);

    await hideLoading();

    setState(() {
      idGenerator = res.data;
      tf_kode.text = idGenerator.kode;
    });
  }

  Future<void> getListKategori() async {
    await showLoading();
    var req = await ApiService.getListKategori("0");
    ListKategoriModel res = ListKategoriModel.fromJson(req);
    var data = res.data;
    listKategori = data;
    for(int i = 0; i < data.length; i++){
      // listStatusDompet.add(StatusDompetModel(id: data[i].id, nama: data[i].nama));
      if(data[i].id == widget.itemData.kategoriId && data[i].nama == widget.itemData.kategoriName){
        valueKategori = data[i];
      }
    }

    setState(() {
    });
    await hideLoading();
  }

  Future<void> getListDompet() async {
    await showLoading();
    var req = await ApiService.getListDompet("0");
    ListDompetModel res = ListDompetModel.fromJson(req);
    var data = res.data;
    
    listDompet = data;
    for(int i = 0; i < data.length; i++){
      // listStatusDompet.add(StatusDompetModel(id: data[i].id, nama: data[i].nama));
      if(data[i].id == widget.itemData.dompetId && data[i].nama == widget.itemData.dompetName){
        valueDompet = data[i];
      }
    }

    setState(() {
    });
    await hideLoading();
  }

  Future<void> getStatusDompet() async {
    await showLoading();
    var req = await ApiService.getStatusDompet();
    ListStatusDompetModel res = ListStatusDompetModel.fromJson(req);
    var data = res.data;
    listStatus = data;
    for(int i = 0; i < data.length; i++){
      // listStatusDompet.add(StatusDompetModel(id: data[i].id, nama: data[i].nama));
      if(data[i].id == widget.itemData.statusId && data[i].nama == widget.itemData.statusName){
        valueStatus = data[i];
      }
    }

    setState(() {
    });
    await hideLoading();
  }

  Future<void> addDompetMasuk() async {
    String kode = tf_kode.text.toString();
    String tanggal = tf_tanggal.text.toString();
    String deskripsi = tf_deskripsi.text.toString();
    String kategori_id = valueKategori.id.toString();
    String dompet_id = valueDompet.id.toString();
    String nilai = tf_nilai.text.toString();
    String status_id = valueStatus.id.toString();

    print("ID GENERATOR => " + idGenerator.idGenerator);
    print("KODE => " + kode);
    print("TANGGAL => " + tanggal);
    print("DESKRIPSI => " + deskripsi);
    print("KATEGORI ID => " + kategori_id);
    print("DOMPET ID => " + dompet_id);
    print("NILAI => " + nilai);
    print("STATUS ID => " + status_id);

    if (kode.isNotEmpty &&
        tanggal.isNotEmpty &&
        deskripsi.isNotEmpty &&
        kategori_id.isNotEmpty &&
        dompet_id.isNotEmpty &&
        nilai.isNotEmpty &&
        status_id.isNotEmpty) {
      showLoading();
      var req = await ApiService.editDompetMasuk(widget.itemData.idTransaksi.toString(), idGenerator.idGenerator, kode,
          deskripsi, tanggal, nilai, "1", dompet_id, kategori_id, status_id);

      print(req.toString());

      ListDompetMasukModel res = ListDompetMasukModel.fromJson(req);
      hideLoading();
      if (res.meta.code == 200) {
        FlutterToast.success("Berhasil Edit Data!");
        widget.refreshPage();
        Navigator.of(context).pop();
      } else {
        FlutterToast.failed("GAGAL!");
      }
    } else {
      FlutterToast.failed("Pastikan data sudah terisi lengkap!");
    }
  }

  Future<void> showLoading() {
    setState(() => isLoadingProgressbar = true);
  }

  Future<void> hideLoading() {
    setState(() => isLoadingProgressbar = false);
  }
}
