class IdGeneratorModel {
  String idGenerator;
  String kode;

  IdGeneratorModel({this.idGenerator, this.kode});

  IdGeneratorModel.fromJson(Map<String, dynamic> json) {
    idGenerator = json['id_generator'];
    kode = json['kode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_generator'] = this.idGenerator;
    data['kode'] = this.kode;
    return data;
  }
}