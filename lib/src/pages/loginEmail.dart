import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structurepublic/src/controler/login_controller.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/MarketPage.dart';
import 'package:structurepublic/src/pages/page_welcome.dart';
import 'package:structurepublic/src/pages/passwordReset.dart';

import '../../generated/l10n.dart';
import '../controler/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';





// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;
//
//   FadeAnimation(this.delay, this.child);
//
//   @override
//   Widget build(BuildContext context) {
//     // final tween = MultiTrackTween([
//     //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
//     //   Track("translateY").add(
//     //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
//     //       curve: Curves.easeOut)
//     // ]);
//
//     return ControlledAnimation(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       //duration: tween.duration,
//       //tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(0, animation["translateY"]),
//             child: child
//         ),
//       ),
//     );
//   }
// }




class LoginEmail extends StatefulWidget {
  @override
  _LoginEmail createState() =>  _LoginEmail();
}


class _LoginEmail extends StateMVC<LoginEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool  _passwordVisible;


  // UserController _con;
  LoginController _loginrController;

  _LoginEmail() : super( LoginController()) {
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
                  height: 620,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/wall.PNG'),
                        fit: BoxFit.cover,

                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:30.0,top:220,right: 30),
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
                                          child: Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                                        ),

                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        // decoration: BoxDecoration(
                                        //     border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                        // ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          controller: _loginrController.emailController,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          // ],
                                          cursorColor: Colors.red[900],
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(color: Colors.red[900]),
                                            hintText: 'أدخل الإيميل الخاص بك',
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
                                              return 'الرجاء ادخال إيميلك';
                                            }
                                            if (!value.isValidEmaill) {
                                              return 'أدخل إيميلك بشكل صحيح';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          obscureText: !_passwordVisible,
                                          controller: _loginrController.passwordController,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(color: Colors.red[900]),
                                            labelText: "كلمة المرور",
                                            hintStyle:  TextStyle(color: Colors.black),
                                            hintText: "ادخل كلمة المرور",
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                            ),
                                            fillColor: Colors.white,
                                            enabledBorder:OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red[900],)
                                          ),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red[900],)
                                            ),
                                          ),

                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'الرجاء ادخال كلمة المرور';
                                            }
                                            if (value.length<8 || value.length>15) {
                                              return  'كلمة المرور يلي أن تكون بين 8 و 15 حرف';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      InkWell(child:
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                           color: Colors.red[900]
                                        ),
                                        child: Center(
                                          child: Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                        onTap: () async {
                                          if (_formKey.currentState.validate()) {
                                           // new VarifyController(_loginrController).Checkemaill();
                                              _loginrController.loginfirebase() ;

                                            // _loginrController.Checkemaill() ;
                                              }

                                            //_loginrController.loginfirebase();
                                           // Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context) => StartMain() ) );
                                            //SignupMain


                                        },
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(height: 20,),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10,),
                                Text("هل نسيت كلمة المرور   ", style: TextStyle(color: Colors.black,fontSize: 15),),
                              InkWell(
                                child:    Text("ذكرني", style: TextStyle(color: Colors.red[900],fontSize: 15,fontWeight: FontWeight.bold),),
                                onTap: () {


                                  //_loginrController.loginfirebase();
                                  Navigator.push(context, MaterialPageRoute(builder: ( context) => PasswordResetMain() ) );
                                  //SignupMain

                                },


                              ),

                            ],),
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