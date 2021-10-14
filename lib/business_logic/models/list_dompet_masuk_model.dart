import 'data/item_transaksi_model.dart';

class ListDompetMasukModel {
  Meta meta;
  List<ItemTransaksiModel> data;

  ListDompetMasukModel({this.meta, this.data});

  ListDompetMasukModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = new List<ItemTransaksiModel>();
      json['data'].forEach((v) {
        data.add(new ItemTransaksiModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int code;
  String message;

  Meta({this.code, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
