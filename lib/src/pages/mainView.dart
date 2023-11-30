import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/elements/ItemWidget.dart';

import '../../generated/l10n.dart';
import '../controler/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class MainStateWidget extends StatefulWidget {
  @override
  _ManeStateWidgetState createState() => _ManeStateWidgetState();
}

class _ManeStateWidgetState extends StateMVC<MainStateWidget> {
  UserController _con;

  _ManeStateWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: new Text(""),
        title: Text(
          "Title",
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).focusColor,
        elevation: 50.0,
        centerTitle: true,
      ),
      body: new Stack(
        children: [
          Image.asset(
            'assets/img/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: new ItemWidget(index: index)
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
