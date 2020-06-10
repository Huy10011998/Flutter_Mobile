import 'dart:convert';

import 'package:http/http.dart' as http;



class Task {
  final String thoi_gian_xay_ra;
  final int id_phan_anh;
  final String noi_dung;
  final String tinh_trang_pa;
  final String ten_vi_tri;
  final String anh_nguoi_dung;
  final String anh_nguoi_tl;
  final bool isMy;
  Task(
      {this.thoi_gian_xay_ra,
      this.id_phan_anh,
      this.noi_dung,
      this.tinh_trang_pa,
      this.ten_vi_tri,
      this.anh_nguoi_dung,
      this.anh_nguoi_tl,
      this.isMy});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      thoi_gian_xay_ra: json["thoi_gian_xay_ra"],
      id_phan_anh: json["phan_anh_id"],
      noi_dung: json["noi_dung"],
      tinh_trang_pa: json["tinh_trang_pa"],
      ten_vi_tri: json["ten_vi_tri"],
      anh_nguoi_dung: json["anh_nguoi_dung"],
      anh_nguoi_tl: json["anh_nguoi_tl"],
    );
  }
}

Future<List<Task>> fetchTasks(http.Client client) async {
 final response = await http.post("http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/danh-sach", headers: <String, String>{
      'Content-type': 'application/json',
      'app-key': 'PHANANH'
    });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body)["result"].cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load');
  }
}
