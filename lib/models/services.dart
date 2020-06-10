import 'dart:convert';
import 'models.dart';
import 'package:http/http.dart' as http; 

class Services {
  
  static const String url = "https://jsonplaceholder.typicode.com/photos";

  static Future<List<HinhAnh>> getHinhAnh() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200)
      {
        List<HinhAnh> list = parseHinhAnh(response.body);
        return list;
      }
      else{
        throw Exception("Error");
      }
    }
    catch (e){
      throw Exception(e.toString());
    }
    }
  }
  
  
   List<HinhAnh> parseHinhAnh(String hinh_anhJson) {
  final parsed = json.decode(hinh_anhJson).cast<Map<String,dynamic>>();
  return parsed.map<HinhAnh>((json) => HinhAnh.fromJson(json)).toList();
}