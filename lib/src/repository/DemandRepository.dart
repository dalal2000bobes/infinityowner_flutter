import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/DemandData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SoldData.dart';
import 'package:structurepublic/src/models/UserDemand.dart';
import 'package:structurepublic/src/models/WorkerData.dart';
import 'package:structurepublic/src/models/user.dart';

import '../helpers/custom_trace.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();


Future<Userss> getUserDemand(DemandData demandData) async {
  Userss userDemand=new Userss();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(demandData.idUser)
      .get()
      .then((value) {
    userDemand= Userss.fromJson(value.data()) ;
  }).catchError((e) {});
   return userDemand;
}


Future<List<WorkerData>> getWorker(String idMarket)async{
  List<WorkerData> listWorkerData=[];
  WorkerData workerData=new WorkerData();
  await FirebaseFirestore.instance
      .collection("worker")
      .where("id_market", arrayContains: idMarket)
      .get()
      .then((value) {
        for(int i=0;i<value.docs.length;i++){
           workerData=WorkerData.fromJson(value.docs[i].data()) ;
           print("mmmmmmooooooooooooo99999999999999"+value.docs.length.toString());
          listWorkerData.add(workerData);
        }
        print("wowowowowowowowowo3330000"+listWorkerData.isEmpty.toString());
  }).catchError((e) {
    print("wwwwwwwwwwooooooooooooooooooottttttgggggggdddddddddddddd222222222222"+e.toString());
  });
  return listWorkerData;
}

Future<List<DemandData>> getDemandNode(String id_admin) async {
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/demand/get/');
  print("demand dalal ddddddddddddddddddddddddd");
  http.Response res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode({"id_admin":id_admin}),
  );
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    List<DemandData> demand=[];
    demand=body.map((p) => DemandData.fromJson(p)).toList();
    print(demand.toString()+"mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm2");
    return demand;
  } else {
    List<DemandData> demand=[];
    return demand;
  }
}

void postDamandNode(DemandData demandData,bool notification)async{
  var url = Uri.parse('https://infinityserver2020.herokuapp.com/demand/admin/post/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'done':demandData.done,
      'product' : demandData.product.map((v) => v.toJson()).toList(),
      'id': demandData.id,
      'id_user':demandData.idUser,
      'id_worker':demandData.idWorker,
      'id_market': demandData.idMarket,
      'id_admins':demandData.idAdmins,
      'state_ar':demandData.stateAr,
      'state_en': demandData.stateEn,
      'remove': demandData.remove,
      'timesTampdemand': demandData.timesTampdemand,
      'timesTampCreat': demandData.timesTampCreat,
      'priceTotal':demandData.priceTotal,
      'rating':demandData.rating,
      'iscoupon':demandData.iscoupon,
      'notification':notification
    }),
  );
  print(response.body.toString());
}
