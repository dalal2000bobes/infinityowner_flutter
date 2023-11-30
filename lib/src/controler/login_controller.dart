import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/controler/user_controller.dart';
import 'package:structurepublic/src/models/route_argument.dart';
import 'package:structurepublic/src/pages/MarketPage.dart';
import 'package:structurepublic/src/repository/login_repository.dart';

import 'package:structurepublic/src/repository/login_repository.dart'as repo;
import '../../generated/l10n.dart';
import '../../main.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/user_repository.dart' as repository;

class LoginController extends ControllerMVC{


  //User user = new User();
  bool loading = false;
  bool loading1 = false;
  bool loadingpass = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  int start=60;
  String id,vjson;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  //VarifyController varifyController=new VarifyController();

  LoginrController() {

    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

  }



  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   print("BACK BUTTON!");
  //
  //   // Do some stuff. return true;
  // }
  // @override
  // void initState()  {
  //   super.initState();
  //   BackButtonInterceptor.add(myInterceptor);
  //
  // }
  // @override
  // void dispose()
  // {
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }

//
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(),),);

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get nameController => _nameController;



  void sendpasswordresetemail() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
     // Get.snackbar("Password Reset email link is been sent", "Success");
      print("aaaaaaaaaaaaaaaaaa");loadingpass=true;
      _onLoadingPassword();
    }).catchError((onError){print("zzzzzzzzzzzzzzzzzzzzzzz"); _onLoadingError();},
    );
        //Get.snackbar("Error In Email Reset", onError.message) );
  }


  Future<String> loginfirebase() async
  {

  _onLoading();

    await  loginSettings(emailController.text,passwordController.text).then((value) async{
      if(value== null){
        print("error login");

      }
      else {
        loading=true;

        print("Sucsess login");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('user', json.encode(value.toJson()));
        preferences.setString('userID', value.id);

        //Navigator.pop(context);//pop dialog ////////////////////g
        Navigator.pop(context);//pop login///////////////////// g
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ( BuildContext context)=> PageMarket(Userss(id: preferences.getString('userID'))),),);/////////////g
       // Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context)=> PageMain(),),);
    //    print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
       // varifyController. Checkemail();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Verfiy() ) );

       // varifyController. Checkemail();


      }
    });


  }

  Future<void> signupfirebase() async
  {
    //_onLoading();
    await  signupSettings(emailController.text,passwordController.text,nameController.text).then((value) async {
      if(value == null){
        print("error signup");

      }else{
        print("Sucsess signin");

        id=value.id;
        vjson=json.encode(value.toJson());
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('user', json.encode(value.toJson()));
        // preferences.setString('userID', value.id);






         //varifyController. Checkemail();
        // Navigator.pop(context);//pop dialog
        // Navigator.pop(context);//pop signup
        // Navigator.pushReplacement( context, MaterialPageRoute(builder: (BuildContext context)=> StartMain(),),);
        //varifyController. Checkemail();
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Verfiy() ) );

      }
    });
  }






  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:
          new Container(
            decoration: new BoxDecoration(
                color: Colors.red[900],
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 150.0,
            height:100.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "loading.. wait...",
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // new Row(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     new CircularProgressIndicator(),
          //     SizedBox(width: 5,),
          //     new Text("Loading"),
          //   ],
          // ),
        );
      },
    );
    new Future.delayed(new Duration(seconds:30), () {
      if(!loading)
      {
        Navigator.pop(context); //pop dialog
        _onLoadingError();
      }

    }

    );
  }









  void _onLoadingPassword() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:
          new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height:200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 2.0,
                    ),
                    //Icon(Icons.email,color: Colors.blueAccent,)
                  ),
                ),
                new Center(child:Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child:  Center(
                    child:  Column(
                        children: <Widget>[
                          Center(child:Row(children: <Widget>[
                            Text("        "),
                            Icon(Icons.email,color: Colors.blueAccent,size: 33,),
                            Text(
                              "       Password Reset  \n   email link is been sent  ",
                              style: new TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 17
                              ),
                            ),
                          ]),),

                        ]
                    ),

                  ),
                ),)
              ],
            ),
          ),
          // new Row(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     new CircularProgressIndicator(),
          //     SizedBox(width: 5,),
          //     new Text("Loading"),
          //   ],
          // ),
        );
      },
    );

    new Future.delayed(new Duration(seconds:40),() {
      if (!loadingpass) {
        Navigator.pop(context); //pop dialog
        _onLoadingError();
      }

      if (loadingpass) {
        Navigator.pop(context); //pop dialog
        Navigator.pop(context);
      }

    }

    );
  }



  void _onLoadingError() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:
          new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 150.0,
            height:80.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                      height: 10.0,
                      width: 10.0,
                      child: Icon(Icons.error,color: Colors.red,)
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "Error...Try again ",
                      style: new TextStyle(
                          color: Colors.red,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // new Row(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     new CircularProgressIndicator(),
          //     SizedBox(width: 5,),
          //     new Text("Loading"),
          //   ],
          // ),
        );
      },
    );

    new Future.delayed(new Duration(seconds:3), () {
     Navigator.pop(context); //pop dialog
    }

    );
  }



  void _onLoadingEmail() {

    showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:
          new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height:200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 2.0,
                      ),
                      //Icon(Icons.email,color: Colors.blueAccent,)
                  ),
                ),
                new Center(child:Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child:  Center(
                    child:  Column(
                        children: <Widget>[
                          Center(child:Row(children: <Widget>[
                             Text("                           "),
                             Icon(Icons.email,color: Colors.red[900],size: 25,),
                            Text(
                              "   Hi   "+ nameController.text,
                              style: new TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 16
                              ),
                            ),
                          ]),),
                          Text(
                            "",
                            style: new TextStyle(
                                fontSize: 6
                            ),
                          ),
                          Text(
                             "A message was sent to check the email.. ",
                            style: new TextStyle(
                                color: Colors.red[900],
                                fontSize: 14
                            ),
                          ),

                          Text(
                            "",
                            style: new TextStyle(
                                fontSize: 3
                            ),
                          ),
                          Text(
                            " please  press the sender link ",
                            style: new TextStyle(
                                color: Colors.red[900],
                                fontSize: 16
                            ),
                          ),


                        ]
                    ),

                  ),
                ),)
              ],
            ),
          ),
          // new Row(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     new CircularProgressIndicator(),
          //     SizedBox(width: 5,),
          //     new Text("Loading"),
          //   ],
          // ),
        );
      },
    );

    new Future.delayed(new Duration(seconds:90),() {
      if (!loading1) {
        Navigator.pop(context); //pop dialog
        _onLoadingError();
      }

    }

    );
  }

}
