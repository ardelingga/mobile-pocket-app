

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_pocket_app2/business_logic/constants/constants.dart';

class ApiService{
  // DOMPET -----
  static Future<Map<String, dynamic>> getListDompet(String status)async{
    
    var query = {
      "status":status
    };
    var queryString = Uri(queryParameters: query).query;

    var uri = Uri.parse(BASE_URL_API+"list_dompet?"+queryString);  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> getStatusDompet()async{
    var uri = Uri.parse(BASE_URL_API+"status_dompet");  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> addDompet(String nama, String referensi, String deskripsi, String id)async{

    var data = {
      "nama":nama,
      "referensi":referensi,
      "deskripsi":deskripsi,
      "status_id":id
    };

    var uri = Uri.parse(BASE_URL_API+"add_dompet");  

    var request = await http.post(
        uri,
        body: data
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> editDompet(String id, String nama, String referensi, String deskripsi, String status_id)async{

    var data = {
      "id":id,
      "nama":nama,
      "referensi":referensi,
      "deskripsi":deskripsi,
      "status_id":status_id
    };

    var uri = Uri.parse(BASE_URL_API+"edit_dompet");  

    var request = await http.post(
        uri,
        body: data
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }


  // KATEGORI =======
  static Future<Map<String, dynamic>> getListKategori(String status)async{
    
    var query = {
      "status":status
    };
    var queryString = Uri(queryParameters: query).query;

    var uri = Uri.parse(BASE_URL_API+"list_kategori?"+queryString);  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> getStatusKategori()async{
    var uri = Uri.parse(BASE_URL_API+"status_kategori");  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> addKategori(String nama, String deskripsi, String status_id)async{

    var data = {
      "nama":nama,
      "deskripsi":deskripsi,
      "status_id":status_id
    };

    var uri = Uri.parse(BASE_URL_API+"add_kategori");  

    var request = await http.post(
        uri,
        body: data
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> editKategori(String id, String nama, String deskripsi, String status_id)async{

    var data = {
      "id":id,
      "nama":nama,
      "deskripsi":deskripsi,
      "status_id":status_id
    };

    var uri = Uri.parse(BASE_URL_API+"edit_kategori");  

    var request = await http.post(
        uri,
        body: data
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }


  // DOMPET MASUK =======
  static Future<Map<String, dynamic>> getListDompetMasuk(String status)async{
    
    var query = {
      "status_transaksi":"1",
      "status":status,
    };
    var queryString = Uri(queryParameters: query).query;

    var uri = Uri.parse(BASE_URL_API+"list_transaksi?"+queryString);  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> getStatusDompetMasuk()async{
    var uri = Uri.parse(BASE_URL_API+"status_kategori");  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> generateId(String prefix)async{

    var data = {
      "prefix":prefix,
    };

    var uri = Uri.parse(BASE_URL_API+"id_generator");  

    var request = await http.post(
        uri,
        body: data
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> addDompetMasuk(
    String idGenerator, 
    String kode, 
    String deskripsi, 
    String tanggal, 
    String nilai, 
    String transaksiStatusId, 
    String dompetId, 
    String kategoriId, 
    String statusId
    )async{

    var data = {
      "id_generator":idGenerator,
      "kode":kode,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "nilai":nilai,
      "transaksi_status_id":transaksiStatusId,
      "dompet_id":dompetId,
      "kategori_id":kategoriId,
      "status_id":statusId
    };

    var uri = Uri.parse(BASE_URL_API+"add_transaksi");  

    var request = await http.post(
        uri,
        body: data,
    );
    var jsonEncode =  convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> editDompetMasuk(
    String id, 
    String idGenerator, 
    String kode, 
    String deskripsi, 
    String tanggal, 
    String nilai, 
    String transaksiStatusId, 
    String dompetId, 
    String kategoriId, 
    String statusId
    )async{

    var data = {
      "id":id,
      "id_generator":idGenerator,
      "kode":kode,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "nilai":nilai,
      "transaksi_status_id":transaksiStatusId,
      "dompet_id":dompetId,
      "kategori_id":kategoriId,
      "status_id":statusId
    };

    var uri = Uri.parse(BASE_URL_API+"edit_transaksi");  

    var request = await http.post(
        uri,
        body: data,
    );
    var jsonEncode =  convert.jsonDecode(request.body);

    return jsonEncode;
  }

  // DOMPET KELUAR =======
  static Future<Map<String, dynamic>> getListDompetKeluar(String status)async{
    
    var query = {
      "status_transaksi":"2",
      "status":status,
    };
    var queryString = Uri(queryParameters: query).query;

    var uri = Uri.parse(BASE_URL_API+"list_transaksi?"+queryString);  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> getStatusDompetKeluar()async{
    var uri = Uri.parse(BASE_URL_API+"status_kategori");  

    var request = await http.get(
        uri,
    );
    var jsonEncode = convert.jsonDecode(request.body);

    return jsonEncode;
  }

  static Future<Map<String, dynamic>> addDompetKeluar(
    String idGenerator, 
    String kode, 
    String deskripsi, 
    String tanggal, 
    String nilai, 
    String transaksiStatusId, 
    String dompetId, 
    String kategoriId, 
    String statusId
    )async{

    var data = {
      "id_generator":idGenerator,
      "kode":kode,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "nilai":nilai,
      "transaksi_status_id":transaksiStatusId,
      "dompet_id":dompetId,
      "kategori_id":kategoriId,
      "status_id":statusId
    };

    var uri = Uri.parse(BASE_URL_API+"add_transaksi");  

    var request = await http.post(
        uri,
        body: data,
    );
    var jsonEncode =  convert.jsonDecode(request.body);

    return jsonEncode;
  }
  
  static Future<Map<String, dynamic>> editDompetKeluar(
    String id, 
    String idGenerator, 
    String kode, 
    String deskripsi, 
    String tanggal, 
    String nilai, 
    String transaksiStatusId, 
    String dompetId, 
    String kategoriId, 
    String statusId
    )async{

    var data = {
      "id":id,
      "id_generator":idGenerator,
      "kode":kode,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "nilai":nilai,
      "transaksi_status_id":transaksiStatusId,
      "dompet_id":dompetId,
      "kategori_id":kategoriId,
      "status_id":statusId
    };

    var uri = Uri.parse(BASE_URL_API+"edit_transaksi");  

    var request = await http.post(
        uri,
        body: data,
    );
    var jsonEncode =  convert.jsonDecode(request.body);

    return jsonEncode;
  }

}