class ItemKategoriModel {
  int id;
  String nama;
  String deskripsi;
  int statusId;
  String statusName;

  ItemKategoriModel(
      {this.id, this.nama, this.deskripsi, this.statusId, this.statusName});

  ItemKategoriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    statusId = json['status_id'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['deskripsi'] = this.deskripsi;
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    return data;
  }
}
