import 'dart:ui';

import 'package:demo_trangchu/layout/dang_theo_doi.dart';
import 'package:demo_trangchu/layout/gui_that_bai_page.dart';
import 'package:demo_trangchu/models/id_task_dang_theo_doi.dart';
import 'package:demo_trangchu/models/id_task_dang_theo_doi_db.dart';
import 'package:flutter/material.dart';
import 'package:before_after/before_after.dart';
import 'dart:convert';
//import 'package:demo_trangchu/layout/sizeconfig.dart';
import 'package:demo_trangchu/layout/sizeconfig.dart';

//import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:demo_trangchu/models/ChiTiet.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Chitiet extends StatefulWidget {
  final String title;
  final int phanAnhId;
  const Chitiet({Key key, this.title,this.phanAnhId}) : super(key: key);
  @override
  _ChitietState createState() => _ChitietState();
}

class _ChitietState extends State<Chitiet> {
  
  

  List<String> items = List<String>(1);
  bool isLoading = false;
  int total = 1;
  List<Future> futures = new List<Future>();


  Future getData(int id) async {
   final  url ='http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/chi-tiet-pa?phan_anh_id='+id.toString();
    final response = await http.get(url, headers: <String, String>{
      'Content-type': 'application/json',
      'app-key' : 'PHANANH'
    });
    final distances = json.decode(response.body);
   // print(distances);
    return distances;
  }

  Future<ChiTiet> chiTietAlbum(int id) async {
    final url = 'http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/chi-tiet-pa?phan_anh_id='+id.toString();
    final response = await http.get(url, headers: <String, String>{
      'Content-type': 'application/json',
      'app-key': 'PHANANH'
    },
    
    );
    print(id.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return ChiTiet.fromJson(json.decode(response.body)['result']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("Loi");
                            
                        
    }
  }


  bool visibilityOne = true;
  bool visibilityTwo = false;
  bool visibilityThree = false;
  bool visibilityFour = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "one") {
        visibilityOne = visibility;
      }
      if (field == "two") {
        visibilityTwo = visibility;
      }
      if (field == "three") {
        visibilityThree = visibility;
      }
      if (field == "four") {
        visibilityFour = visibility;
      }
    });
  }

  bool _isFavorited = true;
  Future<bool> _toggleFavorite(int id) async
  {
    final db = TasksDB();
    futures.add(db.getTasks()); 
    await futures[0].then((v)=>{
     for (int i = 0; i < danhSachIdDangTheoDoi.length;i++) {
     if (danhSachIdDangTheoDoi[i]
      .id_phan_anh ==id) {
       _isFavorited = true
     }
       else{
      _isFavorited = false
         }
     }
    });
  }

bool changeFavorite(){
  setState(() {
    if(_isFavorited)
    {
      _isFavorited = false;
    }
    else{
      _isFavorited = true;
    }
  });
  return true;
}

/**
 * Khi mới mở trang này ra
 * Thì phải kiểm tra có thích hay chưa, để hiển thi cái màu cho cái nút
 */
checkLala(bool lala) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //Tạo 1 biến để lấy giá trị ra
   lala = (prefs.getBool('_isFavorited') ?? true);

  //Nếu không có
  if (lala == true) {
    //Tạo mới với cái key đó(keyNE)
    await prefs.setBool('_isFavorited', lala);
  } 
  //Nếu có rồi thì setState để cho giao diện hiện cái nút màu xanh(đã thích)
  else {
    setState(
      (){
        _isFavorited = lala;
      });
  }
  return lala;
}
//====================================================================

/**
 * Khi nhấn vào nút thích
 */
onTapThick()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();

  //Tạo 1 biến để lấy giá trị ra kiểm tra
  bool lala = (prefs.getBool('_isFavorited') ?? true);

  //Nếu không có
  if (lala == true) {
    //Tạo mới với cái key đó(keyNE)
    await prefs.setBool('_isFavorited', false);
    //setState để cho giao diện hiện cái nút màu xanh(đã thích)
    setState((){
      _isFavorited = false;
      });
  } 
  //Nếu có rồi thì setState để cho giao diện hiện cái nút màu xanh(đã thích)
  else {
    //Tạo mới với cái key đó(keyNE)
    await prefs.setBool('keyNE', true);
    setState((){
      _isFavorited = lala;
      });
  }
  return onThemeChanged(lala);
}
initState(){
  onTapThick();
  super.initState();
}

onThemeChanged(bool value) async {
  (value)
      ? _isFavorited=false
      :_isFavorited=true;
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool('_isFavorited', _isFavorited);
}
List<Id_phan_anh_dang_theo_doi> danhSachIdDangTheoDoi = [];
void addTasks(int idPhanAnh) async {
    final db = TasksDB();
    final task =new Id_phan_anh_dang_theo_doi(
      id_phan_anh: idPhanAnh,
    );
    await db.insert(task);
  }

  Future deleteTasks(int id) async {
    final db = TasksDB();
    await db.delete(id);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Chi tiết phản ánh',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
              actions: <Widget>[
                FutureBuilder<ChiTiet>  (
          future: chiTietAlbum(widget.phanAnhId),
          builder: (BuildContext context, snapshot) {
             _toggleFavorite(snapshot.data.phanAnhId);
             Future.wait(futures);
            // DangTheoDoiPage(isMy: _isFavorited);
            //snapshot.data.isFavorist = _isFavorited;
            ChiTiet mychiTietAlbumAPI = snapshot.data ?? [];
         return 
         IconButton(
            icon:
             _isFavorited  ? Icon(
              Icons.bookmark,
              color: Colors.white,
            )
            :Icon(
              Icons.book,
              color: Colors.blue,) ,
             onPressed: () 
            {
                if(
                  changeFavorite())
                 {                  
                  setState((){
                    print(_isFavorited);
                    if(_isFavorited==false){
                      addTasks(mychiTietAlbumAPI.phanAnhId);
                      print('-------Add--------'+ mychiTietAlbumAPI.phanAnhId.toString() +'-----------------');
                     
                    }
                    else if(_isFavorited==true){
                      deleteTasks(mychiTietAlbumAPI.phanAnhId);
                       print('-------Delete--------'+ mychiTietAlbumAPI.phanAnhId.toString() +'-----------------');
                      
                    }
                  });
                 }    
            },
          );
          },
          ),
        ],
      ),
      body: Center(
        child: new FutureBuilder<ChiTiet>(
          future: chiTietAlbum(widget.phanAnhId),
          builder: (BuildContext context, snapshot) {
            if(snapshot.hasError){
              return GuiThatBaiPage();
            }
            ChiTiet mychiTietAlbumAPI = snapshot.data ?? [];
            return new Container(
             child: ListView.builder(
                   shrinkWrap: true,
                  // physics: ScrollPhysics(),
                  itemCount:1,
                  itemBuilder: (BuildContext context, int index) {                          
                    // final currentIndex =
                    //     ModalRoute.of(context).settings.arguments;
                    ChiTiet chiTietAlbum = mychiTietAlbumAPI;
                    print(chiTietAlbum.noiDung.length);
                    return Container (
                        child:GestureDetector(
                             child:  Column(
                              children: <Widget>[
                             new Container(
                                  margin: new EdgeInsets.all(0.0),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      visibilityOne
                                          ? new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                // Ảnh 1
                                                new Expanded(
                                                  flex: 1,
                                                  child: new Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        38,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        38,
                                                    child: chiTietAlbum.hinhNguoiDung1 =="" &&chiTietAlbum.hinhTraLoi1 =="" 
                                                    ?
                                                          Image.asset(
                                                          'images/loi-hinh-anh.jpg',
                                                          fit:BoxFit.fill)
                                                    : BeforeAfter(
                                                      beforeImage:
                                                          chiTietAlbum.hinhNguoiDung1 != "" ?  Image.network(
                                                          chiTietAlbum.hinhNguoiDung1,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh người dùng thì hiện full tl
                                                          Image.network(
                                                          chiTietAlbum.hinhTraLoi1,
                                                          fit:BoxFit.fill),
                                                      afterImage: chiTietAlbum.hinhTraLoi1 != "" ?  Image.network(
                                                          chiTietAlbum.hinhTraLoi1,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh tl thì hiện full ảnh người dùng
                                                          Image.network(
                                                          chiTietAlbum.hinhNguoiDung1,
                                                          fit:BoxFit.fill),
                                                      imageHeight: SizeConfig
                                                              .safeBlockVertical *
                                                          40,
                                                      imageWidth: SizeConfig
                                                              .safeBlockHorizontal *
                                                          85,
                                                      imageCornerRadius: 0,
                                                      thumbRadius: chiTietAlbum.hinhTraLoi1 == "" ||  chiTietAlbum.hinhNguoiDung1 == "" ? 0  : 16,
                                                      overlayColor: chiTietAlbum.hinhTraLoi1 == "" || chiTietAlbum.hinhNguoiDung1 == "" ?  null : Colors.blue,
                                                      thumbColor: chiTietAlbum.hinhTraLoi1 == "" || chiTietAlbum.hinhNguoiDung1 == "" ? null   : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : new Container(),
                                      visibilityTwo
                                          ? new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                // Ảnh 2
                                                new Expanded(
                                                  flex: 1,
                                                  child: new Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        38,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        38,
                                                    child:chiTietAlbum.hinhNguoiDung2 =="" &&chiTietAlbum.hinhTraLoi2 =="" 
                                                    ?
                                                          Image.asset(
                                                          'images/loi-hinh-anh.jpg',
                                                          fit:BoxFit.fill)
                                                    : BeforeAfter(
                                                      beforeImage:
                                                          chiTietAlbum.hinhNguoiDung2 != "" ?  Image.network(
                                                          chiTietAlbum.hinhNguoiDung2,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh người dùng thì hiện full tl
                                                          Image.network(
                                                          chiTietAlbum.hinhTraLoi2,
                                                          fit:BoxFit.fill),
                                                      afterImage: chiTietAlbum.hinhTraLoi2 != "" ?  Image.network(
                                                          chiTietAlbum.hinhTraLoi2,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh tl thì hiện full ảnh người dùng
                                                          Image.network(
                                                          chiTietAlbum.hinhNguoiDung2,
                                                          fit:BoxFit.fill),
                                                      imageHeight: SizeConfig
                                                              .safeBlockVertical *
                                                          40,
                                                      imageWidth: SizeConfig
                                                              .safeBlockHorizontal *
                                                          85,
                                                      imageCornerRadius: 0,
                                                      thumbRadius: chiTietAlbum.hinhTraLoi2 == "" ||  chiTietAlbum.hinhNguoiDung2 == "" ? 0  : 16,
                                                      overlayColor: chiTietAlbum.hinhTraLoi2 == "" || chiTietAlbum.hinhNguoiDung2 == "" ?  null : Colors.blue,
                                                      thumbColor: chiTietAlbum.hinhTraLoi2 == "" || chiTietAlbum.hinhNguoiDung2 == "" ? null   : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : new Container(),
                                      visibilityThree
                                          ? new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                // Ảnh 3
                                                new Expanded(
                                                  flex: 1,
                                                  child: new Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        38,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        38,
                                                    child:chiTietAlbum.hinhNguoiDung3 == "" &&chiTietAlbum.hinhTraLoi3 == "" 
                                                    ?
                                                          Image.asset(
                                                          'images/loi-hinh-anh.jpg',
                                                          fit:BoxFit.fill)
                                                    : BeforeAfter(
                                                      beforeImage:
                                                          chiTietAlbum.hinhNguoiDung3 != "" ?  Image.network(
                                                          chiTietAlbum.hinhNguoiDung3,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh người dùng thì hiện full tl
                                                          Image.network(
                                                          chiTietAlbum.hinhTraLoi3,
                                                          fit:BoxFit.fill),
                                                      afterImage: chiTietAlbum.hinhTraLoi3 != "" ?  Image.network(
                                                          chiTietAlbum.hinhTraLoi3,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh tl thì hiện full ảnh người dùng
                                                          Image.network(
                                                          chiTietAlbum.hinhNguoiDung3,
                                                          fit:BoxFit.fill),
                                                      imageHeight: SizeConfig
                                                              .safeBlockVertical *
                                                          40,
                                                      imageWidth: SizeConfig
                                                              .safeBlockHorizontal *
                                                          85,
                                                      imageCornerRadius: 0,
                                                      thumbRadius: chiTietAlbum.hinhTraLoi3 == "" ||  chiTietAlbum.hinhNguoiDung3 == "" ? 0  : 16,
                                                      overlayColor: chiTietAlbum.hinhTraLoi3 == "" || chiTietAlbum.hinhNguoiDung3 == "" ?  null : Colors.blue,
                                                      thumbColor:  chiTietAlbum.hinhTraLoi3 == "" || chiTietAlbum.hinhNguoiDung3 == "" ? null   : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : new Container(),
                                      visibilityFour
                                          ? new Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                //Ảnh 4
                                                new Expanded(
                                                  flex: 1,
                                                  child: new Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        38,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        38,
                                                    child:(chiTietAlbum.hinhNguoiDung4 == "" && chiTietAlbum.hinhTraLoi4 == "") 
                                                    ?
                                                          Image.asset(
                                                          'images/loi-hinh-anh.jpg',
                                                          fit:BoxFit.fill)
                                                    : BeforeAfter(
                                                      beforeImage:
                                                          chiTietAlbum.hinhNguoiDung4 != "" ?  Image.network(
                                                          chiTietAlbum.hinhNguoiDung4,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh người dùng thì hiện full tl
                                                          Image.network(
                                                          chiTietAlbum.hinhTraLoi4,
                                                          fit:BoxFit.fill),
                                                      afterImage: chiTietAlbum.hinhTraLoi4 != "" ?  Image.network(
                                                          chiTietAlbum.hinhTraLoi4,
                                                          fit:BoxFit.fill) : 
                                                          // Điều Kiện : Không Có ảnh tl thì hiện full ảnh người dùng
                                                          Image.network(
                                                          chiTietAlbum.hinhNguoiDung4,
                                                          fit:BoxFit.fill),
                                                      imageHeight: SizeConfig
                                                              .safeBlockVertical *
                                                          40,
                                                      imageWidth: SizeConfig
                                                              .safeBlockHorizontal *
                                                          85,
                                                      imageCornerRadius: 0,
                                                      thumbRadius: chiTietAlbum.hinhTraLoi4 == "" ||  chiTietAlbum.hinhNguoiDung4 == "" ? 0  : 16,
                                                      overlayColor: chiTietAlbum.hinhTraLoi4 == "" || chiTietAlbum.hinhNguoiDung4 == "" ?  null : Colors.blue,
                                                      thumbColor: chiTietAlbum.hinhTraLoi4 == "" || chiTietAlbum.hinhNguoiDung4 == "" ? null   : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : new Container(),
                                    ],
                                  )),
                              new Container(
                             child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Ảnh Icon 1
                                  new InkWell(
                                      onTap: () {
                                        visibilityOne
                                            ? ""
                                            : _changed(true, "one");
                                        _changed(false, "two");
                                        _changed(false, "three");
                                        _changed(false, "four");
                                      },
                                      child: new Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 16,
                                        height:
                                            SizeConfig.blockSizeVertical * 16,
                                        margin: new EdgeInsets.only(top: 8.0),
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              padding: EdgeInsets.all(4),
                                              child: Image.asset('images/user-image.png',
                                              color:chiTietAlbum.hinhNguoiDung1=="" ||chiTietAlbum.hinhTraLoi1=="" 
                                              ? Colors.grey :Colors.green,
                                              width: 50,height: 40,),
                                              decoration: BoxDecoration(
                                               // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                border: Border.all(width:2.0,color: visibilityOne ? Colors.purple : Colors.white),
                                              ),
                                            ),
                                            // new Icon(Icons.image,
                                            //     size: 45.0,
                                            //     color: visibilityOne
                                            //         ? Colors.blue[600]
                                            //         : Colors.grey[400]),
                                          ],
                                        ),
                                      )),
                                  new SizedBox(width: 5.0),
                                  // Ảnh Icon 2
                                  new InkWell(
                                      onTap: () {
                                        visibilityTwo
                                            ? ""
                                            : _changed(true, "two");
                                        _changed(false, "one");
                                        _changed(false, "three");
                                        _changed(false, "four");
                                      },
                                      child: new Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 16,
                                        height:
                                            SizeConfig.blockSizeVertical * 16,
                                        margin: new EdgeInsets.only(top: 8.0),
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              padding: EdgeInsets.all(4),
                                              child: Image.asset('images/user-image.png',
                                              color:chiTietAlbum.hinhNguoiDung2=="" ||chiTietAlbum.hinhTraLoi2=="" 
                                              ? Colors.grey :Colors.green,
                                              width: 50,height: 40,),
                                              decoration: BoxDecoration(
                                               // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                border: Border.all(width:2.0,color: visibilityTwo ? Colors.purple : Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  new SizedBox(width: 5.0),
                                  // Ảnh Icon 3
                                  new InkWell(
                                      onTap: () {
                                        visibilityThree
                                            ? ""
                                            : _changed(true, "three");
                                        _changed(false, "one");
                                        _changed(false, "two");
                                        _changed(false, "four");
                                      },
                                      child: new Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 16,
                                        height:
                                            SizeConfig.blockSizeVertical * 16,
                                        margin: new EdgeInsets.only(top: 8.0),
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              padding: EdgeInsets.all(4),
                                              child: Image.asset('images/user-image.png',
                                              color:chiTietAlbum.hinhNguoiDung3=="" ||chiTietAlbum.hinhTraLoi3=="" 
                                              ? Colors.grey :Colors.green,
                                              width: 50,height: 40,),
                                              decoration: BoxDecoration(
                                               // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                border: Border.all(width:2.0,color: visibilityThree ? Colors.purple : Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  new SizedBox(width: 5.0),
                                  // Ảnh Icon 4
                                  new InkWell(
                                      onTap: () {
                                        visibilityFour
                                            ? ""
                                            : _changed(true, "four");
                                        _changed(false, "one");
                                        _changed(false, "three");
                                        _changed(false, "two");
                                      },
                                      child: new Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 16,
                                        height:
                                            SizeConfig.blockSizeVertical * 16,
                                        margin: new EdgeInsets.only(top: 8.0),
                                        child: new Column(
                                          children: <Widget>[
                                            new Container(
                                              padding: EdgeInsets.all(4),
                                              child: Image.asset('images/user-image.png',
                                              color:chiTietAlbum.hinhNguoiDung4=="" ||chiTietAlbum.hinhTraLoi4=="" 
                                              ? Colors.grey :Colors.green,
                                              width: 50,height: 40,),
                                              decoration: BoxDecoration(
                                               // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                border: Border.all(width:2.0,color: visibilityFour ? Colors.purple : Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                          ),
                              
                              // Khung chi tiết
                             Container(
                               height:chiTietAlbum.noiDung.length <=950 
                               ? MediaQuery.of(context).size.height*(0.62+(chiTietAlbum.noiDung.length/1600))
                               :MediaQuery.of(context).size.height*(0.64+(chiTietAlbum.noiDung.length/1600)),
                                // padding: EdgeInsets.only(
                                //   top: 20,
                                // ),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.black)),
                                // Phần thông tin chi tiết người dùng đăng
                                child: Column(                             
                                  children: <Widget>[
                                    
                                    Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: <Widget>[
                                            // Mô tả chi tiết
                                            Text(
                                              chiTietAlbum.noiDung,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            // Nơi xảy ra phản ánh
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.place,
                                                  color: Colors.white54,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  chiTietAlbum.diaDiem,
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            // Thời gian xảy ra
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.white54,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  chiTietAlbum.thoiGianXayRaPA,
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                              endIndent: 40,
                                              indent: 40,
                                            ),  
                                          ],
                                        )),
                                         // Chủ đề, mã, thời gian tạo phản ánh
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context).size.width*0.18, 0, 0, 0),
                                              child: Column(
                                                children: <Widget>[
                                                  // Chủ đề
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Chủ đề:",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        width: 90,
                                                      ),
                                                      Text(
                                                        chiTietAlbum.tenChuDe,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  // Mã phản ánh
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Mã phản ánh:",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text(
                                                        chiTietAlbum.phanAnhId.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  // Thời gian phản ánh
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Thời gian phản ánh:",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        chiTietAlbum.thoiGianTaoPhanAnh,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Phần phản hồi từ người quản trị
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        children: <Widget>[
                                          // Tình trạng
                                          Row(
                                            children: <Widget>[
                                              chiTietAlbum.tinhTrangPA == '1'
                                                  ? Container(
                                                      child:Row(children: <Widget>[
                                                        Text(
                                                        'Tình Trạng: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                        Text(
                                                        'Đợi xử lý',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      ]), 
                                                    )
                                                  : chiTietAlbum.tinhTrangPA == '2'
                                                      ? Container(
                                                          child: Row(children: <Widget>[
                                                        Text(
                                                        'Tình Trạng: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                        Text(
                                                        'Phản ánh ảo',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      ]),
                                                        )
                                                      : chiTietAlbum.tinhTrangPA == '3'
                                                          ? Container(
                                                              child: Row(children: <Widget>[
                                                        Text(
                                                        'Tình Trạng: ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                        Text(
                                                        'Đã trả lời',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      ]), 
                                                            )
                                                              : Container(),
                                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // Lời nhắn
                                          Text(
                                            chiTietAlbum.noiDungTraLoi,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                             ]),
                              
                        )
                          
                                           
                    );
                  }),
            );
          },
        //  future: DefaultAssetBundle.of(context).loadString("assets/aaa.json"),
        ),
      ),
    );
  }
}
