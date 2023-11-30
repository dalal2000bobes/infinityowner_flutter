import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/models/route_argument.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  Userss user = new Userss();
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
   OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

  }


}
