import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/controler/login_controller.dart';


import '../../generated/l10n.dart';
import '../controler/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

import 'package:firebase_core/firebase_core.dart';










extension extString on String {
  bool get isValidEmaill {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }


}

class PasswordResetMain extends StatefulWidget {
  @override
  _PasswordResetMain createState() =>  _PasswordResetMain();
}


class _PasswordResetMain extends StateMVC<PasswordResetMain> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool  _passwordVisible;

  // UserController _con;
  LoginController _loginrController;

  _PasswordResetMain() : super( LoginController()) {
    // _con = controller;
    _loginrController = controller;
  }
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    Firebase.initializeApp();
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[

                Container(
                  height: 700,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/wall.PNG'),
                        fit: BoxFit.cover,

                      )
                  ),
                  child: Stack(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left:30.0,top:270,right: 30),
                        child:
                        Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),

                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10)
                                      )
                                    ]
                                ),

                                child:Form(
                                  key: _formKey,
                                  child:
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Center(
                                          child: Text("إعادة تعيين كلمة المرور", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                        ),

                                      ),

                                      SizedBox(height: 14,),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        // decoration: BoxDecoration(
                                        //     border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                        // ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          controller: _loginrController.emailController,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(color: Colors.red[900]),
                                            hintText: 'ادخل الإيميل الخاص بك',
                                            hintStyle:  TextStyle(color: Colors.black),
                                            labelText: "الإيميل",
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            suffixIcon: Icon(Icons.email,color: Colors.white,),
                                            fillColor: Colors.white,
                                            enabledBorder:OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red[900],)
                                            ),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red[900],)
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'الرجاء ادخال الإيميل ';
                                            }

                                            if(!value.isValidEmaill)
                                            { return 'ادخل الإيميل بشكل صحيح ';}

                                            return null;
                                          },
                                        ),
                                      ),

                                      SizedBox(height: 14,),
                                      InkWell(child:
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.red[900],
                                        ),
                                        child: Center(
                                          child: Text("ارسال كلمة المرور", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                        onTap: () async {
                                          if (_formKey.currentState.validate()) {

                                            //   _loginrController.signupfirebase();
                                            _loginrController.sendpasswordresetemail();
                                          }

                                        },
                                      )
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(height: 20,),

                          ],
                        ),

                      ),








                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(30.0),
                //   child: Column(
                //     children: <Widget>[
                //        Container(
                //         padding: EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10),
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Color.fromRGBO(143, 148, 251, .2),
                //                   blurRadius: 20.0,
                //                   offset: Offset(0, 10)
                //               )
                //             ]
                //         ),
                //         child: Column(
                //           children: <Widget>[
                //             Container(
                //               padding: EdgeInsets.all(8.0),
                //               decoration: BoxDecoration(
                //                   border: Border(bottom: BorderSide(color: Colors.grey[100]))
                //               ),
                //               child: TextFormField(
                //                 decoration: InputDecoration(
                //                   labelText: "Resevior Name",
                //                   fillColor: Colors.white,
                //                   enabledBorder:OutlineInputBorder(
                //                     borderSide: const BorderSide(color: Colors.black, width: 2.0),
                //                     borderRadius: BorderRadius.circular(25.0),
                //                   ),),
                //               ),
                //             ),
                //             Container(
                //               padding: EdgeInsets.all(8.0),
                //               child: TextField(
                //                 decoration: InputDecoration(
                //                     border: InputBorder.none,
                //                     hintText: "Password",
                //                     hintStyle: TextStyle(color: Colors.grey[400])
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 30,),
                //       Container(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             gradient: LinearGradient(
                //                 colors: [
                //                   Color.fromRGBO(143, 148, 251, 1),
                //                   Color.fromRGBO(143, 148, 251, .6),
                //                 ]
                //             )
                //         ),
                //         child: Center(
                //           child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                //         ),
                //       ),
                //       SizedBox(height: 70,),
                //       Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
                //     ],
                //   ),
                // )

              ],
            ),
          ),
        )
    );
  }
}