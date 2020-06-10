import 'dart:convert';

import 'package:http/http.dart' as http;



class ChuDe {
  final String ten_chu_de;
  final int id_chu_de;

  ChuDe(
      {this.ten_chu_de,
      this.id_chu_de,});

  factory ChuDe.fromJson(Map<String, dynamic> json) {
    return ChuDe(
      ten_chu_de: json["ten_chu_de"],
      id_chu_de: json["chu_de_id"],
    );
  }
}

Future<List<ChuDe>> fetchChuDe(http.Client client) async {
 final response = await http.get("http://apidemo.lamgigio.net/cong-phan-anh/100//api/phan-anh/get-chu-de", headers: <String, String>{
      'Content-type': 'application/json',
      'app-key': 'PHANANH'
    });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body)["result"].cast<Map<String, dynamic>>();
    return parsed.map<ChuDe>((json) => ChuDe.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load');
  }
}
