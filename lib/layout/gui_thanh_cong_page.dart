import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:demo_trangchu/layout/gui_that_bai_page.dart';
import 'package:demo_trangchu/Navigationbar.dart';

class GuiThanhCongPage extends StatelessWidget {
  const GuiThanhCongPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/thanhcong.png'),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.17),
                        child: Image.asset(
                          'images/thanhcongicon.png',
                          width: MediaQuery.of(context).size.width * 0.38,
                        )))),
            Text(
              'Gửi thành công!',
              style: TextStyle(color: Color(0xff442EB5), fontSize: 27),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      // set the default style for the children TextSpans
                      style: Theme.of(context).textTheme.body1.copyWith(
                          fontSize: 17,
                          height: 1.4,
                          color: Color(
                            0xff919195,
                          )),
                      children: [
                        TextSpan(
                          text: 'Tra cứu phản ánh của bạn với mã số ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThanhBar()),
                                );
                              },
                            text: '124 ',
                            style: TextStyle(color: Color(0xff442EB5))),
                        TextSpan(
                          text: 'hoặc theo dõi ở mục ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThanhBar()),
                                );
                              },
                            text: 'Đang theo dõi',
                            style: TextStyle(color: Color(0xff442EB5))),
                      ])),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: RaisedButton(
                color: Color(0xff442EB5),
                disabledColor: Color(0xff442EB5),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Text(
                  'Đồng ý',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
