import 'dart:convert';

import 'package:flutter/foundation.dart';

class JsonMau{
  final String noi_dung;
  final String mo_ta;
  final String vi_tri;
  final String thoi_gian_xay_ra;
  final String thoi_gian_tao_pa;
  final List<String> tinh_trang_pa;
  final String tinh_trang_xu_ly;
  final String chu_de;
  final String thoi_gian_trl;
  final String nguoi_tra_loi;
  final String noi_dung_tra_loi;
  final String ma_phan_anh;
  
 // final List<HinhAnh> hinh_anh;
  JsonMau({
  this.noi_dung,
  this.mo_ta,
  this.vi_tri,
  this.thoi_gian_xay_ra,
  this.thoi_gian_tao_pa,
  this.tinh_trang_pa,
  this.tinh_trang_xu_ly,
  this.chu_de,
  this.thoi_gian_trl,
  this.nguoi_tra_loi,
  this.noi_dung_tra_loi,
  this.ma_phan_anh,
//  this.hinh_anh,
  });

  factory JsonMau.fromJson(Map<String, dynamic> json){
    return JsonMau(
      noi_dung: json['noidung'],
      mo_ta: json['mota'],
      vi_tri: json['vitri'],
      thoi_gian_xay_ra: json['thoigianxayra'],
      thoi_gian_tao_pa: json['thoigiantaopa'],
      tinh_trang_pa: parseTinhTrangPA(json['tinhtrangpa']),
      tinh_trang_xu_ly: json['tinhtrangxuly'],
      chu_de: json['chude'],
      thoi_gian_trl: json['thoigiantrl'],
      nguoi_tra_loi: json['nguoitraloi'],
      noi_dung_tra_loi: json['noidungtraloi'],
      ma_phan_anh: json['maphananh'],
//      hinh_anh: parseHinhAnh(json['hinhanh']),
    );
  }

  static List<String> parseTinhTrangPA(tinh_trang_paJson){
    List<String> tinh_trang_paList = new List<String>.from(tinh_trang_paJson);
    return tinh_trang_paList;
  }
  static List<HinhAnh> parseHinhAnh(String hinh_anhJson) {
  final parsed = json.decode(hinh_anhJson).cast<Map<String, dynamic>>();
  return parsed.map<HinhAnh>((json) => HinhAnh.fromJson(json)).toList();
}
}

class HinhAnh{
  final int id;
  final String url;
  
  HinhAnh({this.id,this.url});

  factory HinhAnh.fromJson(Map<String, dynamic> json) {
    return HinhAnh(
      id: json['id'] ,
      url: json['url'] ,
    );
  }
}