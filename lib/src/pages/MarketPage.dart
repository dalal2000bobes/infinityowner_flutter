import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/elements/cardmarketWidget.dart';
import 'package:structurepublic/src/models/SectionData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/DemandPage.dart';

import 'chatDalal.dart';

class PageMarket extends StatefulWidget {
  //final SectionData sectionData;
  final Userss admin;

  PageMarket(this.admin);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageMarket(this.admin);
  }
}

class _PageMarket extends StateMVC<PageMarket> {
  //final SectionData sectionData;
  final Userss admin;
  PageMarketController _con2;

  // _PageMarket(this.sectionData) : super(PageMarketController(sectionData)) {
  //   // _con = controller;
  //   _con2 = controller;
  // }

  _PageMarket(this.admin) : super(PageMarketController(admin)) {
    // _con = controller;
    _con2 = controller;
  }

  int point = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
          itemCount: _con2.listMarket.length,
          itemBuilder: (context, i) {
            return CardMarketWidget(_con2.listMarket[i], _con2,admin);
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
                      builder: (context) => PageMarket(admin),
                    ),
                  );
                }
                if (point ==1 ) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminDemand(admin),
                    ),
                  );
                }
                if (point == 2) {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context)=>Profile(),),);
                }
              });
            }));
  }

  void navigetor(String app) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      //return Pagelist_detail();
    }));
  }
}
