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
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';

import '../helpers/custom_trace.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();

//LocationData locationData;
Future<List<CategorizeData>> getCategorize(MarketData marketData) async {
  List<CategorizeData> list = [];
  await FirebaseFirestore.instance
      .collection("market")
      .doc(marketData.id)
      .collection("categorize")
      .get()
      .then((value) {
    for (int i = 0; i < value.docs.length; i++) {
      list.add(CategorizeData.fromJson(value.docs[i].data()));
    }
  }).catchError((e) {});

  return list;
}

Future hideCategorize(MarketData marketData, CategorizeData categorizeData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + categorizeData.id);
  await FirebaseFirestore.instance
      .collection("market")
      .doc(marketData.id)
      .collection("categorize")
      .doc(categorizeData.id)
      .set(categorizeData.toJson())
      .then((value) {})
      .catchError((e) {});
}


Future editCategorize(MarketData marketData,CategorizeData categorizeData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + categorizeData.id);
  await FirebaseFirestore.instance
      .collection("market")
      .doc(marketData.id)
      .collection("categorize")
      .doc(categorizeData.id)
      .set(categorizeData.toJson())
      .then((value) {
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeelllllllllllllllllllllll");
  }).catchError((e) {});
}

Future<List<CategorizeData>> getCategorizeNode(MarketData marketData) async {
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/categorize/admin/get');

  http.Response res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode({"id_market":marketData.id}),
  );
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    List<CategorizeData> categorize=[];
    categorize=body.map((p) => CategorizeData.fromJson(p)).toList();
    return categorize;
  } else {
    List<CategorizeData> categorize=[];
    return categorize;
  }
}

void postCategorizeNode(MarketData marketData,CategorizeData categorizeData)async{
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/categorize/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "hide" : categorizeData.hide,
      "id" : categorizeData.id,
      "id_market" : marketData.id,
      "image" :categorizeData.image,
      "name_ar" : categorizeData.nameAr,
      "name_en" : categorizeData.nameEn
    }),
  );
}

