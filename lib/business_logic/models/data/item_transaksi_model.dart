class ItemTransaksiModel {
  int idTransaksi;
  int id;
  String kode;
  String deskripsi;
  String tanggal;
  int nilai;
  int transaksiStatusId;
  int dompetId;
  int kategoriId;
  int statusId;
  String transaksiStatusName;
  String dompetName;
  String kategoriName;
  String statusName;

  ItemTransaksiModel(
      {this.idTransaksi,
      this.id,
      this.kode,
      this.deskripsi,
      this.tanggal,
      this.nilai,
      this.transaksiStatusId,
      this.dompetId,
      this.kategoriId,
      this.statusId,
      this.transaksiStatusName,
      this.dompetName,
      this.kategoriName,
      this.statusName});

  ItemTransaksiModel.fromJson(Map<String, dynamic> json) {
    idTransaksi = json['id_transaksi'];
    id = json['id'];
    kode = json['kode'];
    deskripsi = json['deskripsi'];
    tanggal = json['tanggal'];
    nilai = json['nilai'];
    transaksiStatusId = json['transaksi_status_id'];
    dompetId = json['dompet_id'];
    kategoriId = json['kategori_id'];
    statusId = json['status_id'];
    transaksiStatusName = json['transaksi_status_name'];
    dompetName = json['dompet_name'];
    kategoriName = json['kategori_name'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_transaksi'] = this.idTransaksi;
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['deskripsi'] = this.deskripsi;
    data['tanggal'] = this.tanggal;
    data['nilai'] = this.nilai;
    data['transaksi_status_id'] = this.transaksiStatusId;
    data['dompet_id'] = this.dompetId;
    data['kategori_id'] = this.kategoriId;
    data['status_id'] = this.statusId;
    data['transaksi_status_name'] = this.transaksiStatusName;
    data['dompet_name'] = this.dompetName;
    data['kategori_name'] = this.kategoriName;
    data['status_name'] = this.statusName;
    return data;
  }
}
