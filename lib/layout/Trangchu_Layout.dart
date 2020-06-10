import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:demo_trangchu/layout/sizeconfig.dart';
import 'package:demo_trangchu/models/phanAnhs.dart';
import 'Chitiet_Layout_daxuly.dart';

class TrangchuLayout extends StatefulWidget {
  final String title;
  TrangchuLayout([Key key, this.title]) : super(key: key);
  @override
  _TrangchuLayoutState createState() => _TrangchuLayoutState();
}

class _TrangchuLayoutState extends State<TrangchuLayout> {
  // final url =
  //     'http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/danh-sach';
  // int perPage = 10;
  // int count = 0;
  // bool isLoading = false;
  // double scroll;
  // int currentPage = 1;

  final uri =
      'http://apidemo.lamgigio.net/cong-phan-anh/100/api/phan-anh/danh-sach';
  final headers = <String, String>{
    'Content-type': 'application/json',
    'app-key': 'PHANANH'
  };
  List<Result> listResult = new List<Result>();
  int perPage = 10;
  int totalItem = 0;
  int currentPage = 1;
  bool isLoadMore = false;
  double scroll;

  @override
  void initState() {
    super.initState();
    setState(() {
      scroll = 0;
    });

    _getTotalItem().then((value) async {
      setState(() {
        totalItem = int.parse(value);
      });
    });
  }

  Future<List<Result>> _fetchData() async {
    Map<String, int> request = {"page": currentPage, "per_page": perPage};
    final response =
        await http.post(uri, headers: headers, body: json.encode(request));
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body)['result'];
      if (listResult.length == 0 ||
          listResult.length < totalItem && isLoadMore) {
        setState(() {
          responseJson
              .forEach((item) => {listResult.add(new Result.fromJson(item))});

          isLoadMore = false;
        });

        print("listsResult: " + listResult.length.toString());
      }
    }
    await new Future.delayed(new Duration(seconds: 1));
    return listResult;
  }

  Future _getTotalItem() async {
    Map<String, int> request = {"page": 1, "per_page": perPage};
    var body = json.encode(request);
    final response = await http.post(uri, headers: headers, body: body);
    return json.decode(response.body)['count'];
  }

  _getTotalPage() {
    var diviner = (totalItem / perPage) == 1
        ? (totalItem ~/ perPage)
        : (totalItem ~/ perPage) + 1;
    return diviner;
  }

  void _onScrollDown() {
    if (currentPage < _getTotalPage()) {
      setState(() {
        currentPage++;
        isLoadMore = true;
      });
    }
  }

  Widget build(BuildContext context) {
    SizeConfig1().init(context);
    return Stack(children: <Widget>[
      Positioned(
        child: AnimatedPadding(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(top: scroll, bottom: 10.0),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfor) {
              if (!isLoadMore &&
                  scrollInfor.metrics.pixels ==
                      scrollInfor.metrics.maxScrollExtent) {
                _onScrollDown();
              }
              return true;
            },
            child: FutureBuilder<List<Result>>(
                future: _fetchData() ?? [],
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      // return new Center(child:Text('Loading...'));
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else {
                        List<Result> myData = snapshot.data ?? [];
                        return ListView.builder(
                            itemCount: myData.length,
                            itemBuilder: (BuildContext context, int index) {
                              Result album = myData[index];
                              return InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: Container(
                                    child: Column(children: <Widget>[
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.place,
                                                  color: Colors.blueGrey[200],
                                                  size: 20,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 2, left: 5),
                                                  child: Text(
                                                    album.tenViTri + "  •  ",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[200],
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.blueGrey[100],
                                                  size: 20,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                      top: 2,
                                                      left: 5,
                                                    ),
                                                    child: Text(
                                                      album.timeXayRaPa,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueGrey[200],
                                                          fontSize: 15.0),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    album.tinhTrangPa == '1'
                                                        ? Container(
                                                            child: Text(
                                                              'Đợi xử lý',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                          .blue[
                                                                      600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : album.tinhTrangPa ==
                                                                '2'
                                                            ? Container(
                                                                child: Text(
                                                                  'Phản ánh ảo',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            : album.tinhTrangPa ==
                                                                    '3'
                                                                ? Container(
                                                                    child: Text(
                                                                      'Đã trả lời',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .green,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                  ])),
                                        ],
                                      )),
                                      album.hinhnguoidung1 != "" &&
                                              album.hinhnguoidung2 != "" &&
                                              album.hinhnguoidung3 != ""
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    album.noiDung,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )))
                                          : Container(
                                              padding: EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 10.0,
                                                  bottom: 10),
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    album.noiDung,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))),
                                      album.hinhnguoidung1 == "" &&
                                              album.hinhnguoidung2 == "" &&
                                              album.hinhnguoidung3 == "" //1 Anh
                                          ? Container(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 5,
                                                    left: 5,
                                                    right: 5),
                                                child: Image.network(
                                                    album.hinhnguoidung4,
                                                    fit: BoxFit.fill),
                                              ),
                                            )
                                          : album.hinhnguoidung1 == "" &&
                                                  album.hinhnguoidung2 == "" &&
                                                  album.hinhnguoidung4 ==
                                                      "" //1 Anh
                                              ? Container(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5,
                                                        left: 5,
                                                        right: 5),
                                                    child: Image.network(
                                                        album.hinhnguoidung3,
                                                        fit: BoxFit.fill),
                                                  ),
                                                )
                                              : album.hinhnguoidung1 == "" &&
                                                      album.hinhnguoidung3 ==
                                                          "" &&
                                                      album.hinhnguoidung4 ==
                                                          "" //1 Anh
                                                  ? Container(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 5,
                                                            left: 5,
                                                            right: 5),
                                                        child: Image.network(
                                                            album
                                                                .hinhnguoidung2,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    )
                                                  : album.hinhnguoidung2 ==
                                                              "" &&
                                                          album.hinhnguoidung3 ==
                                                              "" &&
                                                          album.hinhnguoidung4 ==
                                                              "" //1 Anh
                                                      ? Container(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 5,
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Image.network(
                                                                album
                                                                    .hinhnguoidung1,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        )
                                                      : album.hinhnguoidung1 ==
                                                                  "" &&
                                                              album.hinhnguoidung2 ==
                                                                  "" //2 anh
                                                          ? Container(
                                                              child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            3.0,
                                                                        left:
                                                                            5.0),
                                                                    width: SizeConfig1
                                                                            .blockSizeHorizontal *
                                                                        48,
                                                                    height: SizeConfig1
                                                                        .screenWidth,
                                                                    child: Image
                                                                        .network(
                                                                      album
                                                                          .hinhnguoidung3,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            3.0,
                                                                        left:
                                                                            5.0),
                                                                    width: SizeConfig1
                                                                            .blockSizeHorizontal *
                                                                        48,
                                                                    height: SizeConfig1
                                                                        .screenWidth,
                                                                    child: Image
                                                                        .network(
                                                                      album
                                                                          .hinhnguoidung4,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                              ],
                                                            ))
                                                          : album.hinhnguoidung1 ==
                                                                      "" &&
                                                                  album.hinhnguoidung3 ==
                                                                      "" //2anh
                                                              ? Container(
                                                                  child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                3.0,
                                                                            left:
                                                                                5.0),
                                                                        width: SizeConfig1.blockSizeHorizontal *
                                                                            48,
                                                                        height: SizeConfig1
                                                                            .screenWidth,
                                                                        child: Image
                                                                            .network(
                                                                          album
                                                                              .hinhnguoidung2,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                3.0,
                                                                            left:
                                                                                5.0),
                                                                        width: SizeConfig1.blockSizeHorizontal *
                                                                            48,
                                                                        height: SizeConfig1
                                                                            .screenWidth,
                                                                        child: Image
                                                                            .network(
                                                                          album
                                                                              .hinhnguoidung4,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                                  ],
                                                                ))
                                                              : album.hinhnguoidung1 ==
                                                                          "" &&
                                                                      album.hinhnguoidung4 ==
                                                                          "" //2anh
                                                                  ? Container(
                                                                      child:
                                                                          Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                            width: SizeConfig1.blockSizeHorizontal * 48,
                                                                            height: SizeConfig1.screenWidth,
                                                                            child: Image.network(
                                                                              album.hinhnguoidung2,
                                                                              fit: BoxFit.cover,
                                                                            )),
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                            width: SizeConfig1.blockSizeHorizontal * 48,
                                                                            height: SizeConfig1.screenWidth,
                                                                            child: Image.network(
                                                                              album.hinhnguoidung3,
                                                                              fit: BoxFit.cover,
                                                                            )),
                                                                      ],
                                                                    ))
                                                                  : album.hinhnguoidung2 ==
                                                                              "" &&
                                                                          album.hinhnguoidung3 ==
                                                                              "" //2anh
                                                                      ? Container(
                                                                          child:
                                                                              Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                                margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                height: SizeConfig1.screenWidth,
                                                                                child: Image.network(
                                                                                  album.hinhnguoidung1,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                            Container(
                                                                                margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                height: SizeConfig1.screenWidth,
                                                                                child: Image.network(
                                                                                  album.hinhnguoidung4,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                          ],
                                                                        ))
                                                                      : album.hinhnguoidung2 == "" &&
                                                                              album.hinhnguoidung4 == "" //2anh
                                                                          ? Container(
                                                                              child: Row(
                                                                              children: <Widget>[
                                                                                Container(
                                                                                    margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                    width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                    height: SizeConfig1.screenWidth,
                                                                                    child: Image.network(
                                                                                      album.hinhnguoidung1,
                                                                                      fit: BoxFit.cover,
                                                                                    )),
                                                                                Container(
                                                                                    margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                    width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                    height: SizeConfig1.screenWidth,
                                                                                    child: Image.network(
                                                                                      album.hinhnguoidung3,
                                                                                      fit: BoxFit.cover,
                                                                                    )),
                                                                              ],
                                                                            ))
                                                                          : album.hinhnguoidung3 == "" && album.hinhnguoidung4 == "" //2anh
                                                                              ? Container(
                                                                                  child: Row(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                        margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                        width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                        height: SizeConfig1.screenWidth,
                                                                                        child: Image.network(
                                                                                          album.hinhnguoidung1,
                                                                                          fit: BoxFit.cover,
                                                                                        )),
                                                                                    Container(
                                                                                        margin: EdgeInsets.only(bottom: 3.0, left: 5.0),
                                                                                        width: SizeConfig1.blockSizeHorizontal * 48,
                                                                                        height: SizeConfig1.screenWidth,
                                                                                        child: Image.network(
                                                                                          album.hinhnguoidung2,
                                                                                          fit: BoxFit.cover,
                                                                                        )),
                                                                                  ],
                                                                                ))
                                                                              : album.hinhnguoidung1 == "" //3anh
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: SizeConfig1.screenHeight * 0.025, left: SizeConfig1.screenWidth * 0.025),
                                                                                      width: SizeConfig1.screenHeight * 91,
                                                                                      height: SizeConfig1.screenWidth * 0.91,
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                              margin: EdgeInsets.only(bottom: 2, left: 5.0),
                                                                                              width: SizeConfig1.blockSizeHorizontal * 47,
                                                                                              height: SizeConfig1.screenWidth,
                                                                                              child: Image.network(
                                                                                                album.hinhnguoidung2,
                                                                                                fit: BoxFit.cover,
                                                                                              )),
                                                                                          Container(
                                                                                            margin: EdgeInsets.only(left: 5.0),
                                                                                            width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                            height: SizeConfig1.screenWidth * 0.9,
                                                                                            child: Column(
                                                                                              children: <Widget>[
                                                                                                Container(
                                                                                                    width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                    height: SizeConfig1.screenWidth * 0.44,
                                                                                                    margin: EdgeInsets.only(bottom: 3.0),
                                                                                                    child: Image.network(
                                                                                                      album.hinhnguoidung3,
                                                                                                      fit: BoxFit.fill,
                                                                                                    )),
                                                                                                Container(
                                                                                                  width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                  height: SizeConfig1.screenWidth * 0.44,
                                                                                                  child: Image.network(
                                                                                                    album.hinhnguoidung4,
                                                                                                    fit: BoxFit.fill,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ))
                                                                                  : album.hinhnguoidung2 == "" //3anh
                                                                                      ? Container(
                                                                                          margin: EdgeInsets.only(top: SizeConfig1.screenHeight * 0.025, left: SizeConfig1.screenWidth * 0.025),
                                                                                          width: SizeConfig1.screenHeight * 91,
                                                                                          height: SizeConfig1.screenWidth * 0.91,
                                                                                          child: Row(
                                                                                            children: <Widget>[
                                                                                              Container(
                                                                                                  margin: EdgeInsets.only(bottom: 2, left: 5.0),
                                                                                                  width: SizeConfig1.blockSizeHorizontal * 47,
                                                                                                  height: SizeConfig1.screenWidth,
                                                                                                  child: Image.network(
                                                                                                    album.hinhnguoidung1,
                                                                                                    fit: BoxFit.cover,
                                                                                                  )),
                                                                                              Container(
                                                                                                margin: EdgeInsets.only(left: 5.0),
                                                                                                width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                height: SizeConfig1.screenWidth * 0.9,
                                                                                                child: Column(
                                                                                                  children: <Widget>[
                                                                                                    Container(
                                                                                                        width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                        height: SizeConfig1.screenWidth * 0.44,
                                                                                                        margin: EdgeInsets.only(bottom: 3.0),
                                                                                                        child: Image.network(
                                                                                                          album.hinhnguoidung3,
                                                                                                          fit: BoxFit.fill,
                                                                                                        )),
                                                                                                    Container(
                                                                                                      width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                      height: SizeConfig1.screenWidth * 0.44,
                                                                                                      child: Image.network(
                                                                                                        album.hinhnguoidung4,
                                                                                                        fit: BoxFit.fill,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ))
                                                                                      : album.hinhnguoidung3 == "" //3 anh
                                                                                          ? Container(
                                                                                              margin: EdgeInsets.only(top: SizeConfig1.screenHeight * 0.025, left: SizeConfig1.screenWidth * 0.025),
                                                                                              width: SizeConfig1.screenHeight * 91,
                                                                                              height: SizeConfig1.screenWidth * 0.91,
                                                                                              child: Row(
                                                                                                children: <Widget>[
                                                                                                  Container(
                                                                                                      margin: EdgeInsets.only(bottom: 2, left: 5.0),
                                                                                                      width: SizeConfig1.blockSizeHorizontal * 47,
                                                                                                      height: SizeConfig1.screenWidth,
                                                                                                      child: Image.network(
                                                                                                        album.hinhnguoidung1,
                                                                                                        fit: BoxFit.cover,
                                                                                                      )),
                                                                                                  Container(
                                                                                                    margin: EdgeInsets.only(left: 5.0),
                                                                                                    width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                    height: SizeConfig1.screenWidth * 0.9,
                                                                                                    child: Column(
                                                                                                      children: <Widget>[
                                                                                                        Container(
                                                                                                            width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                            height: SizeConfig1.screenWidth * 0.44,
                                                                                                            margin: EdgeInsets.only(bottom: 3.0),
                                                                                                            child: Image.network(
                                                                                                              album.hinhnguoidung2,
                                                                                                              fit: BoxFit.fill,
                                                                                                            )),
                                                                                                        Container(
                                                                                                          width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                          height: SizeConfig1.screenWidth * 0.44,
                                                                                                          child: Image.network(
                                                                                                            album.hinhnguoidung4,
                                                                                                            fit: BoxFit.fill,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ))
                                                                                          : album.hinhnguoidung4 == "" //3anh
                                                                                              ? Container(
                                                                                                  margin: EdgeInsets.only(top: SizeConfig1.screenHeight * 0.025, left: SizeConfig1.screenWidth * 0.025),
                                                                                                  width: SizeConfig1.screenHeight * 91,
                                                                                                  height: SizeConfig1.screenWidth * 0.91,
                                                                                                  child: Row(
                                                                                                    children: <Widget>[
                                                                                                      Container(
                                                                                                          margin: EdgeInsets.only(bottom: 2, left: 5.0),
                                                                                                          width: SizeConfig1.blockSizeHorizontal * 47,
                                                                                                          height: SizeConfig1.screenWidth,
                                                                                                          child: Image.network(
                                                                                                            album.hinhnguoidung1,
                                                                                                            fit: BoxFit.cover,
                                                                                                          )),
                                                                                                      Container(
                                                                                                        margin: EdgeInsets.only(left: 5.0),
                                                                                                        width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                        height: SizeConfig1.screenWidth * 0.9,
                                                                                                        child: Column(
                                                                                                          children: <Widget>[
                                                                                                            Container(
                                                                                                                width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                height: SizeConfig1.screenWidth * 0.44,
                                                                                                                margin: EdgeInsets.only(bottom: 3.0),
                                                                                                                child: Image.network(
                                                                                                                  album.hinhnguoidung2,
                                                                                                                  fit: BoxFit.fill,
                                                                                                                )),
                                                                                                            Container(
                                                                                                              width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                              height: SizeConfig1.screenWidth * 0.44,
                                                                                                              child: Image.network(
                                                                                                                album.hinhnguoidung3,
                                                                                                                fit: BoxFit.fill,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ))
                                                                                              : album.hinhnguoidung1 == "" && album.hinhnguoidung2 == "" && album.hinhnguoidung3 == "" && album.hinhnguoidung4 == "" // khong anh
                                                                                                  ? Container(
                                                                                                      padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                                                                                      child: Container(
                                                                                                          alignment: Alignment.topLeft,
                                                                                                          child: Text(
                                                                                                            album.noiDung,
                                                                                                            style: TextStyle(fontSize: 20),
                                                                                                          )))
                                                                                                  : album.hinhnguoidung1 != "" && album.hinhnguoidung2 != "" && album.hinhnguoidung3 != "" && album.hinhnguoidung4 != "" //4 anh
                                                                                                      ? Container(
                                                                                                          margin: EdgeInsets.only(top: SizeConfig1.screenHeight * 0.025, left: SizeConfig1.screenWidth * 0.05),
                                                                                                          width: SizeConfig1.screenHeight * 90,
                                                                                                          height: SizeConfig1.screenWidth * 0.91,
                                                                                                          child: Row(
                                                                                                            children: <Widget>[
                                                                                                              Container(
                                                                                                                margin: EdgeInsets.only(left: 5.0),
                                                                                                                width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                height: SizeConfig1.screenWidth * 0.9,
                                                                                                                child: Column(
                                                                                                                  children: <Widget>[
                                                                                                                    Container(
                                                                                                                        width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                        height: SizeConfig1.screenWidth * 0.44,
                                                                                                                        margin: EdgeInsets.only(bottom: 3.0),
                                                                                                                        child: Image.network(
                                                                                                                          album.hinhnguoidung1,
                                                                                                                          fit: BoxFit.fill,
                                                                                                                        )),
                                                                                                                    Container(
                                                                                                                      width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                      height: SizeConfig1.screenWidth * 0.44,
                                                                                                                      child: Image.network(
                                                                                                                        album.hinhnguoidung2,
                                                                                                                        fit: BoxFit.fill,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                              Container(
                                                                                                                margin: EdgeInsets.only(left: 5.0),
                                                                                                                width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                height: SizeConfig1.screenWidth * 0.9,
                                                                                                                child: Column(
                                                                                                                  children: <Widget>[
                                                                                                                    Container(
                                                                                                                        width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                        height: SizeConfig1.screenWidth * 0.44,
                                                                                                                        margin: EdgeInsets.only(bottom: 3.0),
                                                                                                                        child: Image.network(
                                                                                                                          album.hinhnguoidung3,
                                                                                                                          fit: BoxFit.fill,
                                                                                                                        )),
                                                                                                                    Container(
                                                                                                                      width: SizeConfig1.blockSizeHorizontal * 45,
                                                                                                                      height: SizeConfig1.screenWidth * 0.44,
                                                                                                                      child: Image.network(
                                                                                                                        album.hinhnguoidung4,
                                                                                                                        fit: BoxFit.fill,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ))
                                                                                                      : Container(),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Divider(
                                          color: Colors.blueGrey[100],
                                          indent: 5.0,
                                          endIndent: 5.0,
                                          height: 0.0,
                                        ),
                                      ),

                                      // new Container(
                                      //   margin: EdgeInsets.only(
                                      //       bottom: 5, left: 5, right: 5),
                                      //   width: SizeConfig1.screenHeight,
                                      //   height: SizeConfig1.screenWidth,
                                      //   child: Image.network(
                                      //       myData[index]['hinh_anh'],
                                      //       fit: BoxFit.fill),
                                      // ),
                                    ]),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chitiet(
                                            phanAnhId: album.phanAnhId)),
                                  );
                                },
                              );
                            });
                      }
                  }
                }),
          ),
        ),
      ),
    ]);
  }
}
