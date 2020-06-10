import 'package:demo_trangchu/layout/Chitiet_Layout_daxuly.dart';
import 'package:demo_trangchu/models/task_model.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:demo_trangchu/models/id_task_dang_theo_doi.dart';
import 'package:demo_trangchu/models/id_task_dang_theo_doi_db.dart';
import 'sizeconfig.dart';
import 'package:http/http.dart' as http;
import 'package:demo_trangchu/models/ChiTiet.dart';

class DangTheoDoiPage extends StatefulWidget {
  final String title;
  final int idTheoDoi;
  final int xoaIdTheoDoi;
  final bool isMy;
  DangTheoDoiPage({Key key, this.title,this.idTheoDoi,this.xoaIdTheoDoi,this.isMy}) : super(key: key);
  @override
  _DangTheoDoiPageState createState() => _DangTheoDoiPageState();
}

class _DangTheoDoiPageState extends State<DangTheoDoiPage> {
  List<Id_phan_anh_dang_theo_doi> danhSachIdDangTheoDoi = [];

  Future getTasks() async {
    final db = TasksDB();
    danhSachIdDangTheoDoi = await db.getTasks();
    if (this.mounted) {
      setState(() {});
      }
  }

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
    getTasks();
    //  addTasks(widget.idTheoDoi);
    //  print('-------------------------------------');
    //  print(widget.idTheoDoi);
    //  print('-------------------------------------');
    //  deleteTasks(widget.xoaIdTheoDoi);
    //  print(widget.idTheoDoi);
   // print("so phan tu " + danhSachIdDangTheoDoi.length.toString());
    // print(danhSachIdDangTheoDoi[0].id_phan_anh);
    // for (var item in danhSachIdDangTheoDoi) {
    //   print(item.id_phan_anh.toString());
    // }
    return 
       new Scaffold(
            backgroundColor: Color(0xffE2E2E2), //nền máu xám
            body: new Container(
              color: Colors.white, //nền của nội dung màu trắng
              padding: EdgeInsets.only(left: 20.0, top:5, right: 20.0),
            //  child: SingleChildScrollView(
               // physics: ScrollPhysics(),
                child: ListView(
                 // shrinkWrap: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Phản ánh đang theo dõi:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff442EB5),
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      Container(
                      //  height: 1000,
                        child: FutureBuilder(
                          future: fetchTasks(http.Client()),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                             return new Center( 
                              child: Body(),                             
                             );

                            }
                            else
                            return snapshot.hasData
                                ? ListView.builder(
                                  controller: ScrollController(),
                                 // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      bool kt = false;
                                      for (int i = 0;
                                          i < danhSachIdDangTheoDoi.length;
                                          i++) {
                                        if (danhSachIdDangTheoDoi[i]
                                                .id_phan_anh ==
                                            snapshot.data[index].id_phan_anh) {
                                          kt = true;
                                          DangTheoDoiPage(isMy: true,);
                                        }
                                      }
                                      return 
                                      ListView(
                                        controller: ScrollController() ,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                        Container(
                                         
                                          child:InkWell(
                                    child:  kt == true ? 
                                              
                                               Container(     // hiển thị 1 phản ánh 
                                              width: SizeConfig.screenHeight*30,
                                              height: SizeConfig.screenWidth*0.2,
                                              child: Stack(
                                                children: <Widget>[
                                                  //Hinh phan anh
                                                  Container(
                                                    child: Image.asset(
                                                        'images/1.jpg',
                                                        fit: BoxFit.cover),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.175,
                                                  ),

                                                  // Thong tin phan anh
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                        width: 266,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              // alignment:
                                                              //     AlignmentDirectional.bottomCenter,
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          MediaQuery.of(context).size.width*0.060,
                                                                          0,
                                                                          0,
                                                                          7),
                                                              child: Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              30),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .noi_dung
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )),
                                                            ),

                                                            //Trạng thái phản ánh
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: MediaQuery.of(context).size.width*0.142,
                                                                      top: 0),
                                                              child: Text(
                                                                'Liệt vào phản ánh ảo lúc T4 ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      0xff616770),
                                                                ),
                                                              ),
                                                            ),

                                                            //line
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      13,
                                                                      12,
                                                                      10,
                                                                      0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 1,
                                                                      color: Color(
                                                                          0xff328E8E93)),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  )
                                                ],
                                              ),
                                            )
                                          // Nếu phản ánh này không nằm trong danh sách đã lưu thì k hiển thị
                                          : Container(),
                                           onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Chitiet(phanAnhId: snapshot.data[index].id_phan_anh)),
                                                  );
                                                  print("-------------------------------------------------------------");
                                                  print(snapshot.data[index].id_phan_anh);
                                              },
                                       ) )])]);
                                }
                                )
                                // ? ListTask(tasks: snapshot.data)
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                      ),
                    ]),
              //),
            ));
  }} 


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
CircularProgressIndicator(
      backgroundColor: Colors.green,
      strokeWidth: 5,);
  }
}