import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SectionData.dart';
import 'package:structurepublic/src/repository/page_chat_user_repositorydalal.dart' as repo;


import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageChatUserControllerdalal extends ControllerMVC {
  //User user = new User();
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<Userss> listusers = [];
  ageChatUserController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  String marketid;
  PageChatUserControllerdalal(this.marketid);
  @override
  void initState() {
    super.initState();
    getUserschat();
  }

  getUserschat() async {
    setState((){
      listusers.clear();
    });
    await repo.getUserChat(marketid).then((value) {
      setState((){
        print("kkkkkkkkkkkkkkkkkkkk"   + value.length.toString());
        listusers.addAll(value);

      }

      );

      print(listusers.length.toString() + "444444444444444444444444444444444444444444444");
    });



  }
}
