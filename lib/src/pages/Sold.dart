import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/controler/SoldController.dart';
import 'package:structurepublic/src/elements/CategorizeCardWidget.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/elements/SoldCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/SoldData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/DemandMarketPage.dart';

import 'CategorizePage.dart';
import 'chat_userdalal.dart';

class Sold extends StatefulWidget {

  final MarketData marketData;
  final Userss admins;
  @override
  Sold(this.marketData,this.admins);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Sold(this.marketData,this.admins);
  }
}

class _Sold extends StateMVC<Sold> {
  SoldController _con;
  final MarketData marketData;
  final Userss admins;
  _Sold(this.marketData,this.admins)
      : super(SoldController(marketData)) {
    _con = controller;
  }

  SoldController _get() {
    return _con;
  }

  int point=2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("العروض"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _con.listSold.length,
        itemBuilder: (context, i) {
          return CardSoldWidget(marketData,_con.listSold[i]);
        },
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() async {
            SoldData newSoldData = new SoldData();
            newSoldData.hide = false;
            newSoldData.timesTamp=0;
            newSoldData.timeSend=DateTime.now().toString();
            newSoldData.image = "";
            newSoldData.imageIcon = marketData.imageIcon;
            newSoldData.longDay=0;
            newSoldData.price=0;
            newSoldData.lastPrice=0;
            newSoldData.id ="";
            newSoldData.idMarket="";
            newSoldData.descriptionAr = "";
            newSoldData.descriptionEn = "";
            newSoldData.nameAr="";
            newSoldData.nameEn="";
            newSoldData.nameMarketAr="";
            newSoldData.nameMarketEn="";
            await _con.showEditDialog(marketData, newSoldData, _con);
          });
        },
      ),
    );
  }
}
