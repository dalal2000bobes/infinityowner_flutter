import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';

import 'SnakBar.dart';

class EditCategorize extends StatefulWidget {
  final MarketData marketData;
  final CategorizeData categorizeData;
  final PageCategorizeController categorizeController;

  const EditCategorize(
      this.marketData, this.categorizeData, this.categorizeController);

  @override
  _EditCategorizeState createState() {
    return _EditCategorizeState(
        this.marketData, this.categorizeData, this.categorizeController);
  }
}

class _EditCategorizeState extends State<EditCategorize> {
  final MarketData marketData;
  final CategorizeData categorizeData;
  final PageCategorizeController categorizeController;

  _EditCategorizeState(
      this.marketData, this.categorizeData, this.categorizeController) {
    categorizeController.imageUrl = categorizeData.image;
    categorizeController.nameProductAr.text = categorizeData.nameAr;
    categorizeController.nameProductEn.text = categorizeData.nameEn;
  }

  final _formkey = GlobalKey<FormState>();

  bool imageError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.maxFinite,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: GestureDetector(
                        child: Expanded(
                          child: Container(
                            child: Center(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                padding: EdgeInsets.all(0.5),
                                color: Colors.black12,
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 100.0,
                                      minHeight: 40.0,
                                      maxHeight: 50),
                                  alignment: Alignment.center,
                                  child: Text(
                                    categorizeData.nameAr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                onError: (url, error) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                image: CachedNetworkImageProvider(
                                    categorizeController.imageUrl),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: EdgeInsets.all(15),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              this.categorizeController.getImage();
                            });
                          },
                          minWidth: 0.0,
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (imageError)
              Center(
                child: Text(
                  "الرجاء التأكد من ادخال صورة عن الصنف",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: categorizeController.nameProductAr,
                      decoration: InputDecoration(
                        labelText: ' اسم الصنف بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          categorizeData.nameAr =
                              categorizeController.nameProductAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال اسم الصنف بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: categorizeController.nameProductEn,
                      decoration: InputDecoration(
                        labelText: 'Categorize Name In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          categorizeData.nameEn =
                              categorizeController.nameProductEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Categorize Name In English';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.refresh,
                            color: Colors.red[300],
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              this.categorizeController.imageUrl;
                            });
                            // dispose();
                            // Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.send,
                            color: Colors.indigo[500],
                            size: 30,
                          ),
                          onPressed: () async {
                            if (categorizeController.imageUrl.isEmpty ||
                                categorizeController.imageUrl == null) {
                              setState(() {
                                imageError=true;
                              });
                            }else if(categorizeController.imageUrl.isNotEmpty ||
                                categorizeController.imageUrl != null) {
                              setState(() {
                                imageError=false;
                              });

                            }
                            if (_formkey.currentState.validate() && !imageError) {
                              await categorizeController.editCategorize(
                                  marketData, categorizeData);
                              dispose();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
