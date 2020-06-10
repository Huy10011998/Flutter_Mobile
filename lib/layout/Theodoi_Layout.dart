import 'package:flutter/material.dart';

class TheodoiLayout extends StatefulWidget {
  @override
  _TheodoiLayoutState createState() => _TheodoiLayoutState();
}

class _TheodoiLayoutState extends State<TheodoiLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Phản ánh đang theo dõi:",
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  // Phản ánh
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 120,
                          child: Image.asset(
                            "images/building.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                          ),
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Bảo vệ nhà giữ xe block A không sắp xếp xe trong hầm...",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.indigo,
                                  ),
                                  Text(
                                    "Tòa nhà F" + " - ",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.lime,
                                  ),
                                  Text(
                                    "2h",
                                    style: TextStyle(color: Colors.lime),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Đã xử lý lúc 8/5/2020",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 30,
                    color: Colors.black12,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 120,
                          child: Image.asset(
                            "images/building.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                          ),
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Bảo vệ nhà giữ xe block A không sắp xếp xe trong hầm...",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.indigo,
                                  ),
                                  Text(
                                    "Tòa nhà F" + " - ",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.lime,
                                  ),
                                  Text(
                                    "2h",
                                    style: TextStyle(color: Colors.lime),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Đang xử lý",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 30,
                    color: Colors.black12,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 120,
                          child: Image.asset(
                            "images/building.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                          ),
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Bảo vệ nhà giữ xe block A không sắp xếp xe trong hầm...",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.indigo,
                                  ),
                                  Text(
                                    "Tòa nhà F" + " - ",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.lime,
                                  ),
                                  Text(
                                    "2h",
                                    style: TextStyle(color: Colors.lime),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Phản ánh ảo",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 30,
                    color: Colors.black12,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
