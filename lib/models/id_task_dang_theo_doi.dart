import 'package:demo_trangchu/models/ChiTiet.dart';
import 'package:flutter/cupertino.dart';

class Id_phan_anh_dang_theo_doi {
  final int id_phan_anh;

  Id_phan_anh_dang_theo_doi({Key key,this.id_phan_anh}) ;

  Map<String, dynamic> toMap() {
    return {
      'id_phan_anh': id_phan_anh,
    };
  }
}
