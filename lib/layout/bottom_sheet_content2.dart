import 'dart:io';

import 'package:demo_trangchu/models/chu_de_modal.dart';
import 'package:demo_trangchu/models/vi_tri_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'gui_thanh_cong_page.dart';

import 'package:http/http.dart' as http;

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  File imageFile;

  _openGalary(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.gallery));
    this.setState(() {
      imageFile = picture;
      images.add(imageFile);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.camera));
    this.setState(() {
      imageFile = picture;
      images.add(imageFile);
    });
    Navigator.of(context).pop();
  }



  var images = [];
  var files = [];
  // Giả sử hình có id là 0, 1 là hình lỗi
  // List<int> idHinhKhongHopLe = [0, 1];
  // List<int> idFileKhongHopLe = [0, 1];
  List<int> idHinhKhongHopLe = [];
  List<int> idFileKhongHopLe = [];
  bool moTaTrong = false;
  bool viTriTrong = false;
  var check;

  final moTaController = TextEditingController();
  final thoiGianController = TextEditingController();
  final moTaThemController = TextEditingController();

  Color _getColor(bool kiemTraTrong) {
    if (kiemTraTrong == true)
      return Colors.red;
    else
      return Color(0xff442eb5);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    moTaController.dispose();
    super.dispose();
  }

  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 57,
      decoration: BoxDecoration(
          color: Color(0xfff4f3f3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Thanh chức năng
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              padding: EdgeInsets.only(top: 4, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          child: Container(
                            child: Text(
                              'Huỷ      ',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff016ADD)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Text(
                    'Gửi phản ánh',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff442EB5)),
                  )),
                  Expanded(child: Text('')),
                ],
              ),
            ),

            // Up ảnh minh chứng
            Container(
              color: Color(0xffffffff),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text
                  idHinhKhongHopLe.length != 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 0, 5),
                          child: Text(
                            'Ảnh minh chứng:',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ))
                      : Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 0, 5),
                          child: Text(
                            'Ảnh minh chứng',
                            style: TextStyle(
                                color: Color(0xff442EB5),
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )),

                  // 4 Nút upload
                  FlatButton(
                    onPressed: () {
                      final act = CupertinoActionSheet(
                          title: Text('Tải lên ảnh vi phạm'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text('Máy ảnh'),
                              onPressed: () {
                                _openCamera(context);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Thư viện'),
                              onPressed: () {
                                _openGalary(context);
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('Huỷ bỏ'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ));
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => act);
                    },
                    child: Container(
                      height: 70.0,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                                margin: EdgeInsets.only(right: 10),
                                width: (MediaQuery.of(context).size.width -
                                        30 -
                                        40 +
                                        8) /
                                    4,
                                height: 70,
                                child: DottedBorder(
                                  dashPattern: [2],
                                  color: Color(0xff442EB5),
                                  strokeWidth: 1,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'images/upload.svg',
                                      height: 26,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ));
                          }),
                    ),
                  )
                ],
              ),
            ),

            // Nội dung trả lời
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text

                  Container(
                      margin: EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        'Mô tả vấn đề (*):',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: _getColor(moTaTrong)),
                      )),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: _getColor(moTaTrong))),
                          height: 150,
                          child: TextField(
                            controller: moTaController,
                            onChanged: (s) {
                              setState(() {
                                moTaController.text = s;
                                moTaTrong = false;
                                moTaController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: moTaController.text.length));
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintMaxLines: 2,
                                hintText:
                                    'Xin vui lòng mô tả chi tiết vấn đề để được hỗ trợ sớm nhất.',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                )),
                            textInputAction: TextInputAction.done,
                          )),
                      moTaTrong == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                '* Vui lòng mô tả vấn đề',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),

            // Chủ đề
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Chủ đề (*):',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff442eb5)),
                      )),

                  FutureBuilder(
                    future: fetchChuDe(http.Client()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return snapshot.hasData
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      check = snapshot.data[index].id_chu_de;
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                        snapshot.data[index].id_chu_de == check
                                            ? BoxDecoration(
                                                color: Color(0xff3F36AE),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff442EB5)))
                                            : BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff442EB5))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      snapshot.data[index].ten_chu_de,
                                      style: snapshot.data[index].id_chu_de ==
                                              check
                                          ? TextStyle(
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              })
                          // ? ListTask(tasks: snapshot.data)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ],
              ),
            ),

            // Thời gian
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 120,
                    child: Text(
                      'Thời gian:',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff442eb5)),
                    ),
                  ),

                  Container(
                      width: MediaQuery.of(context).size.width - 120 - 30,
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xff442EB5))),
                      child: TextField(
                        controller: thoiGianController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintMaxLines: 1,
                            hintText: 'Ví dụ: tối T6, ngày 16/6/2019...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            )),
                      ))
                ],
              ),
            ),

            // Địa điểm
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 120,
                    child: Text(
                      'Địa điểm (*):',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: _getColor(viTriTrong)),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //drop down chọn địa điểm
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: _getColor(viTriTrong))),
                        child: FutureBuilder<List<ViTri>>(
                          future: fetchViTri(http.Client()),
                          builder: (context, snapshot) {
                            return DropdownButton<String>(
                              underline: Container(),
                              hint: Text("Chọn toà nhà  "),
                              value: dropdownValue,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              items: snapshot.data.map((item) {
                                return DropdownMenuItem<String>(
                                  child: Text(item.ten_vi_tri),
                                  value: item.id_vi_tri.toString(),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  viTriTrong = false;
                                });
                              },
                            );
                          },
                        ),
                      ),

                      // mô tả thêm

                      Container(
                          margin: EdgeInsets.only(top: 8),
                          width: MediaQuery.of(context).size.width - 120 - 30,
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff442EB5))),
                          child: TextField(
                            controller: moTaThemController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintMaxLines: 1,
                                hintText: 'Mô tả thêm về địa điểm',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                )),
                          )),
                    ],
                  )
                ],
              ),
            ),

            viTriTrong == true
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 15, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '* Vui lòng chọn toà nhà ',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(),

            // dòng note
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  '(*): Không được bỏ trống.',
                  style: TextStyle(
                      color: Color(0xff442EB5),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),

            // Button
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20, bottom: 50),
                child: Center(
                    child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  elevation: 0,
                  color: Color(0xff8E8E93),
                  onPressed: () {
                    
                    if (moTaController.text.isEmpty) {
                      setState(() {
                        moTaTrong = true;
                      });
                    } 
                    if (dropdownValue == null) {
                      setState(() {
                        viTriTrong = true;
                      });
                    } 
                    
                    if (moTaController.text.isEmpty == false && dropdownValue != null)
                    
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                children: <Widget>[
                                  Text("Nội dung: " + moTaController.text),
                                  Text("Id chủ đề: " + check.toString()),
                                  Text("Id vị trí: " + dropdownValue.toString()),
                                  Text("Thời gian: " + thoiGianController.text),
                                  Text("Mô tả thêm: " + moTaThemController.text),
                                ],
                              ),
                            );
                          });

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => GuiThanhCongPage()),
                    // );
                  },
                  child: Container(
                      width: 185,
                      height: 35,
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'images/plane.svg',
                            width: 20,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Gửi đến ban quản lý',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )),
                )))
          ],
        ),
      ),
    );
  }
}
