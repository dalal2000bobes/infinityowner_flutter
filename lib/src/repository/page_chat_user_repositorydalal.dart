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
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SectionData.dart';
import 'package:structurepublic/src/models/user.dart';

import '../helpers/custom_trace.dart';
import '../models/setting.dart';
import 'package:intl/intl.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();
bool bz=false;
//LocationData locationData;
Future<List<Userss>> getUserChat(String idmarket) async {
  List<Userss> list = [];
print("halaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  // await FirebaseFirestore.instance
  //     .collection('messages').where("user.uid",isEqualTo:idmarket).get().
  //     then((value) async {
  //   for(int i=0;i<value.docs.length;i++){
  //     list1.add(Message.fromJson(value.docs[i].data()));
  //     print("2222222222222222222222222222222222222");
  //
  //   }
  //   print(list1.length);
  //   print("cccccccccccccccccc");
  //   print(list1[0].lastName);
  //   print("cccccccccccccccccc");
  //   print(list1[0].id);
  //
  //   for (int i = 0; i < list1.length; i++) {
  //     for (int j = i + 1; j < list1.length; j++) {
  //       if (list1[i].lastName == list1[j].lastName) {
  //         list2.add(list1[i]);
  //       }
  //     }
  //   }
  //
  //   for (int i = 0; i < list2.length; i++) {
  //     list1.remove(list2[i]);
  //   }


    await FirebaseFirestore.instance
        .collection("users").where("role",isEqualTo: "users")
        .get()
        .then((value) {
          for(int i=0;i<value.docs.length;i++)
       list.add(Userss.fromJson(value.docs[i].data()));
     });


  return list;
}




