

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_pocket_app2/business_logic/constants/constants.dart';

class ApiService{
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


}