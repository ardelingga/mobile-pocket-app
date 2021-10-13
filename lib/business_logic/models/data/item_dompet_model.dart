class ItemDompetModel {
  int id;
  String nama;
  int referensi;
  String deskripsi;
  int statusId;
  String statusName;

  ItemDompetModel(
      {this.id,
      this.nama,
      this.referensi,
      this.deskripsi,
      this.statusId,
      this.statusName});

  ItemDompetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    referensi = json['referensi'];
    deskripsi = json['deskripsi'];
    statusId = json['status_id'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['referensi'] = this.referensi;
    data['deskripsi'] = this.deskripsi;
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    return data;
  }
}
