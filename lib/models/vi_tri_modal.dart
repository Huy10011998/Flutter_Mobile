import 'dart:convert';

import 'package:http/http.dart' as http;



class ViTri {
  final String ten_vi_tri;
  final String id_vi_tri;

  ViTri(
      {this.ten_vi_tri,
      this.id_vi_tri,
      });

  factory ViTri.fromJson(Map<String, dynamic> json) {
    return ViTri(
      ten_vi_tri: json["ten_vi_tri"],
      id_vi_tri: json["vi_tri_id"],
    );
  }
}

Future<List<ViTri>> fetchViTri(http.Client client) async {
 final response = await http.get("http://apidemo.lamgigio.net/cong-phan-anh/100//api/phan-anh/get-vi-tri", headers: <String, String>{
      'Content-type': 'application/json',
      'app-key': 'PHANANH'
    });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body)["result"].cast<Map<String, dynamic>>();
    return parsed.map<ViTri>((json) => ViTri.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load');
  }
}
