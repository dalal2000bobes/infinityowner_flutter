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
import 'package:structurepublic/src/pages/Sold.dart';

import 'CategorizePage.dart';
import 'chat_userdalal.dart';

class MarketDemand extends StatefulWidget {
  //final CategorizeData categorizeData;

  final Userss admins;
  final MarketData marketData;

  @override
  MarketDemand(this.admins,this.marketData);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MarketDemand(this.admins,this.marketData);
  }
}

class _MarketDemand extends StateMVC<MarketDemand> {
  DemandController _con;
  final Userss admins;
  final MarketData marketData;

  _MarketDemand(this.admins,this.marketData) : super(DemandController(admins,true,marketData.id)) {
    _con = controller;
  }

  DemandController _get() {
    return _con;
  }

  int point = 1;

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
              Icons.chat,
              //  color: Theme.of(context).primaryColorLight,
            ),
            title: Text(
              "المحادثات",
              //  style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
             backgroundColor:Colors.white38,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_grocery_store,
            ),
            title: Text(
              " الطلبات",
            ),
            backgroundColor:Colors.white38,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.style,
            ),
            title: Text(
              " العروض",
            ),
            backgroundColor:Colors.white38,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_mall,
            ),
            title: Text(
              " الأصناف",
            ),
            backgroundColor:Colors.white38,
          ),
        ],
        onTap: (index) {
          setState(() {
            point = index;
              if (point == 0) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return PageChatUserdala(marketData);
                }));
              }
              if (point == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return MarketDemand(admins, marketData);
                }));
              }
              if (point == 2) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Sold(marketData,admins)
                ));
              }
              if (point == 3) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Categorize(marketData,admins),
                ));
              }
          });
        },
      ),
    );
  }
}
