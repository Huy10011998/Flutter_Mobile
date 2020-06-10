import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_trangchu/layout/sizeconfig.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tatcaphananh extends StatefulWidget {
  @override
  _TatcaphananhState createState() => _TatcaphananhState();
}

class _TatcaphananhState extends State<Tatcaphananh> {
  List<String> items = List<String>.generate(2, (i) => "myData");
  int present = 2;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future _getMoreData() async {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {
      if (present < 8) {
        items.addAll({""});
      }
      present++;
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);
    SizeConfig2().init(context);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfor) {
          if (!isLoading &&
              scrollInfor.metrics.pixels == scrollInfor.metrics.maxScrollExtent) {
            _getMoreData();
            setState(() {
              isLoading = true;
            });
          }
          return;
        },
        child: new FutureBuilder(
          builder: (context, snapshot) {
            final myData = json.decode(snapshot.data.toString());
            return new ListView.builder(
              itemCount: (present <= 8) ? items.length + 1 : items.length,
              itemBuilder: (BuildContext context, int index) {
                if (items.length == index) {
                  return Container(
                    height: isLoading ? 40 : 0,
                    color: Colors.transparent,
                    child: Center(child: new CircularProgressIndicator()),
                  );
                }
                return new Container(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 3),
                    child: new Card(
                        child: new Row(children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 2, color: Colors.blueAccent)),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      myData[index]['tinh_trang_pa'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueAccent),
                                    ),
                                  ]),
                            ),
                            Container(
                              height: 65,
                              width: 270,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                myData[index]['noi_dung'],
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.indigo,
                                  ),
                                  Text(
                                    myData[index]['vi_tri'],
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    myData[index]['thoi_gian_xay_ra'],
                                    style: TextStyle(color: Colors.pinkAccent),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        width: 120,
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Image.network(
                              myData[index]['hinh_anh'],
                              fit: BoxFit.fill,
                              height: 110,
                              width: 110,
                            ),
                          ],
                        ),
                      ),
                    ])));
              },
            );
          },
          future: DefaultAssetBundle.of(context).loadString("assets/aaa.json"),
        ),
      ),
    );
  }
}
