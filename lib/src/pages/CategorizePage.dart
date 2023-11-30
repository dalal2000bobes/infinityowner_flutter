import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/CategorizeCardWidget.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/DemandMarketPage.dart';
import 'package:structurepublic/src/pages/DemandPage.dart';
import 'package:structurepublic/src/pages/Sold.dart';
import 'package:structurepublic/src/pages/chat_userdalal.dart';

// ignore: must_be_immutable
class Categorize extends StatefulWidget {
  final MarketData marketData;
  final Userss admins;
  Categorize(this.marketData,this.admins);

  int c = 0;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Categorize(this.marketData,this.admins);
  }
}

class _Categorize extends StateMVC<Categorize> {
  final MarketData marketData;
  CategorizeData categorizeData;
  final Userss admins;
  PageCategorizeController _categorizeController;

  _Categorize(this.marketData,this.admins)
      : super(
          PageCategorizeController(marketData),
        ) {
    _categorizeController = controller;
    //_con= _categorizeDetail._get();

    //_con=controller;
  }

  bool select = false;
  int point = 3;
  int pointt = 0;
  int z = 0;

  // _ProductDetail(this.pointt);
  Decoration _decoration1 = BoxDecoration(
    color: Colors.black12,
  );
  Decoration _decoration = BoxDecoration(
    color: Colors.white24,
    border: Border(
      bottom: BorderSide(width: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        Container(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "البحث ....",
                    icon: Icon(Icons.search),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(marketData.image),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(1.5),
                    crossAxisCount: 2,
                    childAspectRatio: 0.98,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      _categorizeController.listCategorize.length,
                          (index) => CardCategorizeWidget(
                          _categorizeController.listCategorize[index],
                          _categorizeController,
                          marketData),
                    ),
                  )),
            ])),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: point,
        selectedFontSize: 15,
        selectedItemColor: Colors.blue[300],
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
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() async {
            CategorizeData newcategorize = new CategorizeData();
            newcategorize.hide = false;
            newcategorize.image = "";
            newcategorize.id = "";
            newcategorize.nameAr = "";
            newcategorize.nameEn = "";
            await _categorizeController.showEditDialog(
                marketData, newcategorize, _categorizeController);
            //_con.listProduct.add(newProductData);
          });
        },
      ),
    );
//
  }
}
