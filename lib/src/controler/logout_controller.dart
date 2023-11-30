import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/main.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/loginEmail.dart';


class LogoutController extends StatefulWidget {
  @override
  _LogoutController createState() => _LogoutController();
}

class _LogoutController extends State<LogoutController> {

  var user;

  Future getEmail()async{
    print("llllllllllllllllllllllllllllllll");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user = preferences.getString('user');
    });
    print("2222222222222222222222222222222222222222");
  }

  Future logOut(BuildContext context)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
    Fluttertoast.showToast(
        msg: "Logout Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginEmail(),),);
  }


  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    print("55555555555555555555555555555555555555555555555555555555");
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الخروج'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: user== " " ? Text('kkkkkkkkkkkkk') : Text(user ?? " ")),
          SizedBox(height: 20,),
          MaterialButton(
            color: Colors.red[900],
            onPressed: (){
              logOut(context);
            },child: Text("تسجيل الخروج",style: TextStyle(color: Colors.white),),),
        ],
      ),

    );
  }
}