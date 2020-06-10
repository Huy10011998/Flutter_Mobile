import 'package:demo_trangchu/layout/Tatcaphananh_Layout.dart';
import 'package:flutter/material.dart';
import 'package:demo_trangchu/layout/Chitiet_Layout_daxuly.dart';
import 'package:demo_trangchu/layout/Trangchu_Layout.dart';
import 'package:demo_trangchu/layout/Theodoi_Layout.dart';
import 'package:demo_trangchu/layout/dang_theo_doi.dart';
import 'package:demo_trangchu/layout/Tatcaphananh_Layout.dart';
import 'package:demo_trangchu/layout/bottom_sheet_content.dart';


class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
         '/home': (context) => TrangchuLayout(),
          '/detail': (context) => Chitiet(),
      },
      home: ThanhBar(),
    );
  }
}

class ThanhBar extends StatefulWidget {
  @override
  _ThanhBarState createState() => _ThanhBarState();
}

class _ThanhBarState extends State<ThanhBar> {
   int navigation = 0;
  Widget selectedroute(int nav) {
    switch (nav) {
      case 0:
        return TrangchuLayout();
        break;
    /*  case 0:
        return Chitietchuaxuly();
        break;
      case 1:
        return Chitiet();
        break;*/
      case 1:
      return DangTheoDoiPage();
       break;
      //  case 2: 
      //  return Tatcaphananh();
      //  break;
      default:
        return TrangchuLayout();
      //default: 
    //   return Chitietchuaxuly();
        
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            children: <Widget>[
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/building.jpg"))),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cổng phản ánh",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Nhanh chóng - Tiện lợi - Bảo mật",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Floating Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                 _showModalBottomSheet(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TheodoiLayout()),
                // );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            //  elevation: 2.0,
            ),
          ),
        ),         
        body: selectedroute(navigation),
        //  body:    selectedFAB(floatingbutton),
        bottomNavigationBar: BottomAppBar(
       //  child: Opacity(
      //      opacity: 0,
          // Thanh Bar Dưới
          child:  BottomNavigationBar(
            //backgroundColor: Colors.none,
           type: BottomNavigationBarType.fixed,
            fixedColor: Colors.blue,
            currentIndex: navigation,
            onTap: (value) {
              setState(() {
                navigation = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 34,
                ),
                backgroundColor: Colors.lightBlue,
                title: Text(
                  "Trang chủ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            /*  BottomNavigationBarItem(
                icon: Icon(
                  Icons.cast_connected,
                  size: 34,
                ),
                backgroundColor: Colors.lightBlue,
                title: Text(
                  "Chưa Xử Lý",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              */
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mail,
                  size: 34,
                ),
                backgroundColor: Colors.lightBlue,
                title: Text(
                  "Đang Theo Dõi",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.cast_connected,
              //     size: 34,
              //   ),
              //   backgroundColor: Colors.lightBlue,
              //   title: Text(
              //     "Tất Cả Phản Ánh",
              //     style: TextStyle(
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
            ],  
          ),
           //),  
             shape: CircularNotchedRectangle(),
         notchMargin: 12.0,
        ),
        
      );
  }
}
  _showModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return BottomSheetContent();
        });
  }

