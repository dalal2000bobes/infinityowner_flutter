import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';

import '../helpers/custom_trace.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();

//LocationData locationData;
Future<List<ProductData>> getProduct(CategorizeData categorizeData) async {
  List<ProductData> list = [];
  await FirebaseFirestore.instance
      .collection("product")
      .where("id_categorize", isEqualTo: categorizeData.id.toString())
      .get()
      .then((value) {
    for (int i = 0; i < value.docs.length; i++) {
      list.add(ProductData.fromJson(value.docs[i].data()));
    }
  }).catchError((e) {});

  return list;
}

Future<List<ProductData>> getProductNode(CategorizeData categorizeData) async {
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/product/admin/get');

  http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode({"id_categorize":categorizeData.id}),
  );
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    List<ProductData> product=[];
    product=body.map((p) => ProductData.fromJson(p)).toList();
    return product;
  } else {
    List<ProductData> product=[];
    return product;
  }
}

void postProductNode(ProductData productData)async{
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/product/');
  var response = await http.post(
    url,
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body: jsonEncode({
      "description_ar" : productData.description_ar,
      "description_en" :productData.description_en,
      "hide" : productData.hide,
      "id" : productData.id,
      "id_categorize" : productData.id_categorize,
      "image" :productData.image,
      "name_ar" : productData.nameAr,
      "name_en" : productData.nameEn,
      "note" :productData.note,
      "price" : productData.price
    }),
  );
}

Future editID(String uid, ProductData productData) async {
  await FirebaseFirestore.instance
      .collection("product")
      .doc(uid)
      .set(productData.toJson())
      .then((value) {
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeelllllllllllllllllllllll");
  }).catchError((e) {});
}

Future editProduct(ProductData productData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + productData.id);
  await FirebaseFirestore.instance
      .collection("product")
      .doc(productData.id)
      .set(productData.toJson())
      .then((value) {
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeelllllllllllllllllllllll");
  }).catchError((e) {});
}

Future<String> upLoadImage(File image) async {
  String urlPhot;
  Uint8List photo = image.readAsBytesSync();
  Reference reference =
      FirebaseStorage.instance.ref().child(Uuid().generateV4());
  final TaskSnapshot uploadTask = await reference.putData(photo);
  urlPhot = await uploadTask.ref.getDownloadURL();
  print("lllllllllllllllloooooooooooooooooooooobbbbbbbbbbbbbbbbbbb" +
      urlPhot.toString());
  return urlPhot;
}

Future hideProduct(ProductData productData) async {
  print("222dddddddddddddddddddddddddddddddddddddd" + productData.id);
  await FirebaseFirestore.instance
      .collection("product")
      .doc(productData.id)
      .set(productData.toJson())
      .then((value) {})
      .catchError((e) {});
}
