import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/DemandController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/CardDemandWidget.dart';
import 'package:structurepublic/src/elements/CategorizeCardWidget.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/MarketPage.dart';

class AdminDemand extends StatefulWidget {
  //final CategorizeData categorizeData;

  final Userss admins;

  @override
  AdminDemand(this.admins);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminDemand(this.admins);
  }
}

class _AdminDemand extends StateMVC<AdminDemand> {
  DemandController _con;
  final Userss admins;

  _AdminDemand(this.admins) : super(DemandController(admins,false,"")) {
    _con = controller;
  }

  DemandController _get() {
    return _con;
  }

  int point = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:Stack(
        children: <Widget>[
          // new Center(
          //   child: new SizedBox(
          //     height: 30.0,
          //     width: 30.0,
          //     child: new CircularProgressIndicator(
          //       value: null,
          //       strokeWidth: 7.0,
          //     ),
          //   ),
          // ),
          new ListView.builder(
            shrinkWrap: true,
            itemCount: _con.listByAdmin.length,
            itemBuilder: (context, i) {
              return CardDemandWidget(
                  _con.listByAdmin[i], _con.selectUser[i], _con);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: point,
          selectedFontSize: 15,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Colors.black45,
          unselectedFontSize: 5,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                //  color: Colors.black45,
              ),
              title: Text(
                "الرئيسية",
                // style: TextStyle(color: Colors.black45),
              ),
              backgroundColor: Colors.white38,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_grocery_store,
                // color: Colors.black45,
              ),
              title: Text(
                "طلباتي",
                //  style: TextStyle(color: Colors.black45),
              ),
              //  backgroundColor:Colors.white38,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                // color: Colors.black45,
              ),
              title: Text(
                "حسابي",
                //   style: TextStyle(color: Colors.black45),
              ),
              // backgroundColor:Colors.white38,
            ),
          ],
          onTap: (index) {
            setState(() {
              point = index;
              if (point == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageMarket(admins),
                  ),
                );
              }
              if (point == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDemand(admins),
                  ),
                );
              }
              if (point == 2) {
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context)=>Profile(),),);
              }
            });
          }),
    );
  }
}
