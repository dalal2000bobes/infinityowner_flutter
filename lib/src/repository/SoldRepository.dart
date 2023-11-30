import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/controler/SoldController.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SoldData.dart';

import '../helpers/custom_trace.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();

Future<List<SoldData>> getSold(MarketData marketData) async {
  List<SoldData> list = [];
  await FirebaseFirestore.instance
      .collection("sold")
      .where("id_market", isEqualTo: marketData.id.toString())
      .get()
      .then((value) async {
    for (int i = 0; i < value.docs.length; i++) {
      SoldData soldData = SoldData.fromJson(value.docs[i].data());

      if (DateTime.now().microsecondsSinceEpoch > DateTime.parse(soldData.timeSend)
          .add(Duration(days: soldData.longDay)).microsecondsSinceEpoch) {
        await hideSold(soldData);
        soldData.hide=true;
        list.add(SoldData.fromJson(value.docs[i].data()));
      } else if (DateTime.now().microsecondsSinceEpoch<DateTime.parse(soldData.timeSend)
          .add(Duration(days: soldData.longDay)).microsecondsSinceEpoch) {
        list.add(SoldData.fromJson(value.docs[i].data()));
      }
    }
  }).catchError((e) {});

  return list;
}

Future hideSold(SoldData soldData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + soldData.id);
  soldData.hide = true;
  await FirebaseFirestore.instance
      .collection("sold")
      .doc(soldData.id)
      .set(soldData.toJson())
      .then((value) {})
      .catchError((e) {});
}

Future editSold(SoldData soldData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + soldData.id);
  await FirebaseFirestore.instance
      .collection("sold")
      .doc(soldData.id)
      .set(soldData.toJson())
      .then((value) {
    //hideSold(marketData, soldData);
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeelllllllllllllllllllllll");
  }).catchError((e) {});
}


Future<List<SoldData>> getSoldNode(MarketData marketData) async {
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/sold/admin/get');

  http.Response res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode({"id_market":marketData.id}),
  );
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    List<SoldData> sold=[];
    sold=body.map((p) => SoldData.fromJson(p)).toList();
    return sold;
  } else {
    List<SoldData> sold=[];
    return sold;
  }
}

void postSoldNode(SoldData soldData,bool notification)async{
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/sold/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "description_ar" : soldData.descriptionAr,
      "description_en" : soldData.descriptionEn,
      "hide" : soldData.hide,
      "id" : soldData.id,
      "notification":notification,
      "id_market" : soldData.idMarket,
      "image" : soldData.image,
      "image_icon":soldData.imageIcon,
      "lastPrice":soldData.lastPrice,
      "longDay":soldData.longDay,
      "name_ar" : soldData.nameAr,
      "name_en" : soldData.nameEn,
      "name_market_ar" : soldData.nameMarketAr,
      "name_market_en" : soldData.nameMarketEn,
      "price" : soldData.price,
      "timeSend":soldData.timeSend,
      "timesTamp":soldData.timesTamp
    }),
  );
  print(response.body.toString());
}
