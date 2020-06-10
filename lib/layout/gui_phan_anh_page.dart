import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_trangchu/layout/bottom_sheet_content.dart';

class GuiPhanAnhPage extends StatefulWidget {
  GuiPhanAnhPage({Key key}) : super(key: key);

  @override
  _GuiPhanAnhPageState createState() => _GuiPhanAnhPageState();
}

class _GuiPhanAnhPageState extends State<GuiPhanAnhPage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Gửi phản ánh'),
                onPressed: () {
                  _showModalBottomSheet(context);
                }),
            
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return BottomSheetContent();
        });
  }
}
