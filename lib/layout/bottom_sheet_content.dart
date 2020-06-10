import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'gui_thanh_cong_page.dart';
import 'package:demo_trangchu/models/chu_de_modal.dart';
import 'package:demo_trangchu/models/vi_tri_modal.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';


class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  File imageFile, imageFile1, imageFile2, imageFile3;
  var images = [];
  var files = [];
  List<int> idHinhKhongHopLe = [];
  List<int> idFileKhongHopLe = [];
  bool textInvalid = false;
  var idImg;
  String uploadedFileURL;
  String uploadedFileURL1;
  String uploadedFileURL2;
  String uploadedFileURL3;

  String dropdownValue;

  _taoPhanAnh(String link1, link2, link3, link4, noiDung, chuDeId, timeXayRa,
      viTriId, moTa) async {
    String url =
        'http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/tao-pa';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'app-key': 'PHANANH'
    };
    String json =
        '{"link_hinh_anh_1":"$link1","link_hinh_anh_2":"$link2","link_hinh_anh_3":"$link3","link_hinh_anh_4":"$link4", "noi_dung":"$noiDung","chu_de_id":"$chuDeId", "time_xay_ra_pa":"$timeXayRa", "vi_tri_id": "$viTriId", "mo_ta_dia_diem": "$moTa"}';
    print("testLink " + json);
    Response response = await post(url, headers: headers, body: json);

    int statusCode = response.statusCode;
    statusCode == 200
        ? print('Add thanh cong :' + response.body)
        : print("add that bai :" + response.body);
  }

  _openGalary(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.gallery));

    this.setState(() {
      imageFile = picture;
      images.add(imageFile.path);
    });
    Navigator.of(context).pop();
  }

  _openGalary1(BuildContext context) async {
    var picture1 = (await ImagePicker.pickImage(source: ImageSource.gallery));

    this.setState(() {
      imageFile1 = picture1;
      images.add(imageFile1.path);
    });
    Navigator.of(context).pop();
  }

  _openGalary2(BuildContext context) async {
    var picture2 = (await ImagePicker.pickImage(source: ImageSource.gallery));

    this.setState(() {
      imageFile2 = picture2;
      images.add(imageFile2.path);
    });
    Navigator.of(context).pop();
  }

  _openGalary3(BuildContext context) async {
    var picture3 = (await ImagePicker.pickImage(source: ImageSource.gallery));
    this.setState(() {
      imageFile3 = picture3;
      images.add(imageFile3.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.camera));
    this.setState(() {
      imageFile = picture;
      images.add(imageFile.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera1(BuildContext context) async {
    var picture1 = (await ImagePicker.pickImage(source: ImageSource.camera));
    this.setState(() {
      imageFile1 = picture1;
      images.add(imageFile1.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera2(BuildContext context) async {
    var picture2 = (await ImagePicker.pickImage(source: ImageSource.camera));
    this.setState(() {
      imageFile2 = picture2;
      images.add(imageFile2.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera3(BuildContext context) async {
    var picture3 = (await ImagePicker.pickImage(source: ImageSource.camera));
    this.setState(() {
      imageFile3 = picture3;
      images.add(imageFile3.path);
    });
    Navigator.of(context).pop();
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
      });
      print("0:" + uploadedFileURL.toString());
    });
  }

  Future uploadFile1() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(imageFile1.path)}}');
    StorageUploadTask uploadTask1 = storageReference.putFile(imageFile1);
    await uploadTask1.onComplete;
    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL1 = fileURL;
      });
      print("1:" + uploadedFileURL1.toString());
    });
  }

  Future uploadFile2() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(imageFile2.path)}}');
    StorageUploadTask uploadTask2 = storageReference.putFile(imageFile2);
    await uploadTask2.onComplete;
    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL2 = fileURL;
      });
      print("2:" + uploadedFileURL2.toString());
    });
  }

  Future uploadFile3() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(imageFile3.path)}}');
    StorageUploadTask uploadTask3 = storageReference.putFile(imageFile3);
    await uploadTask3.onComplete;
    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL3 = fileURL;
      });
      print("3:" + uploadedFileURL3.toString());
    });
  }

  bool moTaTrong = false;
  bool viTriTrong = false;
  var check;
  final moTaController = TextEditingController();
  final thoiGianController = TextEditingController();
  final moTaThemController = TextEditingController();
  Color _getColor(bool moTaTrong) {
    if (moTaTrong == true)
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
                  Container(
                    child: Row(children: <Widget>[
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
                          width: 70.0,
                          child: Container(
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              // itemCount: 4,
                              // itemBuilder: (BuildContext ctxt, int index)

                              child: imageFile == null
                                  ? Container(
                                      //  margin: EdgeInsets.only(right: 10),
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                      ))
                                  : Container(
                                      padding: EdgeInsets.only(),
                                      child: Image.asset(
                                        imageFile.path,
                                        width: 80,
                                        height: 80,
                                      ))),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          final act = CupertinoActionSheet(
                              title: Text('Tải lên ảnh vi phạm'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: Text('Máy ảnh'),
                                  onPressed: () {
                                    _openCamera1(context);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Text('Thư viện'),
                                  onPressed: () {
                                    _openGalary1(context);
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
                          width: 70.0,
                          child: Container(
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              // itemCount: 4,
                              // itemBuilder: (BuildContext ctxt, int index)

                              child: imageFile1 == null
                                  ? Container(
                                      // margin: EdgeInsets.only(right: 10),
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                      ))
                                  : Container(
                                      padding: EdgeInsets.only(),
                                      child: Image.asset(
                                        imageFile1.path,
                                        width: 80,
                                        height: 80,
                                      ))),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          final act = CupertinoActionSheet(
                              title: Text('Tải lên ảnh vi phạm'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: Text('Máy ảnh'),
                                  onPressed: () {
                                    _openCamera2(context);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Text('Thư viện'),
                                  onPressed: () {
                                    _openGalary2(context);
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
                          width: 70.0,
                          child: Container(
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              // itemCount: 4,
                              // itemBuilder: (BuildContext ctxt, int index)

                              child: imageFile2 == null
                                  ? Container(
                                      // margin: EdgeInsets.only(right: 10),
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                      ))
                                  : Container(
                                      padding: EdgeInsets.only(),
                                      child: Image.asset(
                                        imageFile2.path,
                                        width: 80,
                                        height: 80,
                                      ))),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          final act = CupertinoActionSheet(
                              title: Text('Tải lên ảnh vi phạm'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: Text('Máy ảnh'),
                                  onPressed: () {
                                    _openCamera3(context);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Text('Thư viện'),
                                  onPressed: () {
                                    _openGalary3(context);
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
                          width: 70.0,
                          child: Container(
                              // physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              // itemCount: 4,
                              // itemBuilder: (BuildContext ctxt, int index)

                              child: imageFile3 == null
                                  ? Container(
                                      //  margin: EdgeInsets.only(right: 10),
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                      ))
                                  : Container(
                                      padding: EdgeInsets.only(),
                                      child: Image.asset(
                                        imageFile3.path,
                                        width: 80,
                                        height: 80,
                                      ))),
                        ),
                      ),
                    ]),
                  ),
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
                            onTap: () {
                              moTaTrong = false;
                              setState(() {});
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
                                      decoration: snapshot
                                                  .data[index].id_chu_de ==
                                              check
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
                                      )),
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
                          color: Color(0xff442eb5)),
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
                            border:
                                Border.all(width: 1, color: Color(0xff442EB5))),
                        child: FutureBuilder<List<ViTri>>(
                          future: fetchViTri(http.Client()),
                          builder: (context, snapshot) {
                            return DropdownButton<String>(
                              underline: Container(),
                              hint: Text("Chọn toà nhà  "),
                              value: dropdownValue,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff3F36AE),
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
                      //mo ta? them
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          width: MediaQuery.of(context).size.width - 120 - 30,
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff442EB5))),
                          child: TextField(
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
            //Check Empty Location
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

                    if (moTaController.text.isEmpty == false &&
                        dropdownValue != null) {
                      uploadFile();
                      uploadFile1();
                      uploadFile2();
                      uploadFile3();
                      print("test " + uploadedFileURL);
                      _taoPhanAnh(
                          uploadedFileURL,
                          uploadedFileURL1,
                          uploadedFileURL2,
                          uploadedFileURL3,
                          // "https://i.pinimg.com/originals/92/a7/8b/92a78ba51b1769d5e4baf07cd38dfd22.jpg",
                          // "https://i.pinimg.com/originals/92/a7/8b/92a78ba51b1769d5e4baf07cd38dfd22.jpg",
                          // "https://i.pinimg.com/originals/92/a7/8b/92a78ba51b1769d5e4baf07cd38dfd22.jpg",
                          // "https://i.pinimg.com/originals/92/a7/8b/92a78ba51b1769d5e4baf07cd38dfd22.jpg",
                          moTaController.text,
                          check,
                          thoiGianController.text,
                          dropdownValue,
                          moTaThemController.text);
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //         content: Column(
                      //           children: <Widget>[
                      //             Text("Nội dung: " + moTaController.text),
                      //             Text("Id chủ đề: " + check.toString()),
                      //             Text( "Id vị trí: " + dropdownValue.toString()),
                      //             Text("Thời gian: " + thoiGianController.text),
                      //             Text("Mô tả thêm: " + moTaThemController.text),
                      //           ],
                      //         ),
                      //       );
                      //     });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuiThanhCongPage()),
                      );
                    }
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
