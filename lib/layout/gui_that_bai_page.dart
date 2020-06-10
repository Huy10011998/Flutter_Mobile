import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GuiThatBaiPage extends StatelessWidget {
  const GuiThatBaiPage({Key key}) : super(key: key);

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
                        image: AssetImage('images/thatbai.png'),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.17),
                        child: Image.asset(
                          'images/thatbaiicon.png',
                          width: MediaQuery.of(context).size.width * 0.38,
                        )))),
            Text(
              'Có lỗi xảy ra',
              style: TextStyle(color: Color(0xffFF0005), fontSize: 27),
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
                          text: 'Phản ánh của bạn chưa được gửi \n Vui lòng thử lại !',
                        ),
                        
                      ])),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: RaisedButton(
                color: Color(0xffFF0005),
                disabledColor: Color(0xffFF0005),
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
                  'Thử lại',
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
