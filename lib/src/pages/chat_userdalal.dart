import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/page_chat_controller_dalal.dart';
import 'package:structurepublic/src/elements/cardchatdalal.dart';
import 'package:structurepublic/src/elements/cardmarketWidget.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SectionData.dart';

import '../../main.dart';
class PageChatUserdala extends StatefulWidget
{
MarketData market;
PageChatUserdala(this.market);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageChatUserdala(this.market);
  }
}

class  _PageChatUserdala extends StateMVC<PageChatUserdala>
{
  PageChatUserControllerdalal _con2;
MarketData market;
  _PageChatUserdala(this.market) : super( PageChatUserControllerdalal(market.id)) {
    // _con = controller;
    _con2 = controller;
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("المحادثة",style: TextStyle(color: Theme.of(context).primaryColorDark),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: ListView.builder(
          itemCount: _con2.listusers.length,
          // itemBuilder: (context, i) {
          //      return CardMarketWidget(marketData: _con2.listMarket[i],);
          //
          // },
          itemBuilder: (BuildContext context, int index) =>
              CardChatWidgetdalal(_con2.listusers[index],market)
      ),

    ) ;
  }

}