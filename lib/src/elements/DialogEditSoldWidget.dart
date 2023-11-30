import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/controler/SoldController.dart';
import 'package:structurepublic/src/elements/SnakBar.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/SoldData.dart';

class AddSold extends StatefulWidget {
  final SoldData soldData;
  final SoldController _controller;
  final MarketData marketData;

  const AddSold(this.soldData, this._controller, this.marketData);

  @override
  _AddSoldState createState() {
    return _AddSoldState(this.soldData, this._controller, this.marketData);
  }
}

class _AddSoldState extends State<AddSold> {
  final SoldData soldData;
  final SoldController _controller;
  final MarketData marketData;

  _AddSoldState(this.soldData, this._controller, this.marketData) {
    _controller.imageUrl = soldData.image;
    _controller.nameAr.text = soldData.nameAr;
    _controller.nameEn.text = soldData.nameEn;
    _controller.descriptionSoldAr.text = soldData.descriptionAr;
    _controller.descriptionSoldEn.text = soldData.descriptionEn;
    if (soldData.price != 0) {
      _controller.price.text = soldData.price.toString();
    }
    if (soldData.lastPrice != 0) {
      _controller.lastPrice.text = soldData.lastPrice.toString();
    }
    if (soldData.longDay != 0) {
      _controller.longDaySold.text = soldData.longDay.toString();
    }
  }

  final _formkey = GlobalKey<FormState>();

  String convertDate(DateTime dateTime) {
    String stateDate;
    if (dateTime.hour >= 12)
      stateDate = "PM";
    else if (dateTime.hour < 12) stateDate = "AM";

    String ourDate =
        "${dateTime.year.toString()}/${dateTime.month.toString()}/${dateTime.day.toString()}\t\t\t${dateTime.hour.toString()}:${dateTime.minute.toString()}:${dateTime.second.toString()}\t\t $stateDate";
    // ourDate+=dateTime.year.toString();
    // ourDate+="-";
    // ourDate+=dateTime.month.toString();
    // ourDate+="-";
    // ourDate+=dateTime.day.toString();
    // ourDate+="  |  ";
    // ourDate+=dateTime.hour.toString();
    // ourDate+=":";
    // ourDate+=dateTime.minute.toString();
    // ourDate+=":";
    // ourDate+=dateTime.second.toString();
    return ourDate;
  }

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
                children: <Widget>[
                  Container(
                    height: 350,
                    width: double.maxFinite,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  color: Colors.white,
                                  child: Text(
                                    // "\t\t\t\t\t" +
                                    //     convertDate(
                                    //         DateTime.fromMicrosecondsSinceEpoch(
                                    //             soldData.timesTamp)),
                                    "\t\t\t\t\t" +
                                        convertDate(
                                            DateTime.parse(soldData.timeSend)),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightGreen),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Image(
                                  errorBuilder: (context, url, error) =>
                                      Image.asset(
                                        'assets/img/loading.gif',
                                        fit: BoxFit.cover,
                                      ),
                                  image: CachedNetworkImageProvider(
                                      _controller.imageUrl),
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: ListTile(
                                tileColor: Colors.white,
                                trailing: Text(
                                  soldData.price.toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red[300]),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  backgroundImage: CachedNetworkImageProvider(
                                    soldData.imageIcon,
                                  ),
                                ),
                                title: Text(
                                  _controller.nameAr.text,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  _controller.descriptionSoldAr.text,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                              this._controller.getImage();
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
                  "الرجاء التأكد من ادخال صورة عن العرض",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controller.nameAr,
                      decoration: InputDecoration(
                        labelText: 'اسم العرض بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.nameAr = _controller.nameAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال اسم العرض بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controller.nameEn,
                      decoration: InputDecoration(
                        labelText: 'Sold Name In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.nameEn = _controller.nameEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Sold Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controller.descriptionSoldAr,
                      decoration: InputDecoration(
                        labelText: 'وصف العرض بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.descriptionAr =
                              _controller.descriptionSoldAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال وصف العرض بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controller.descriptionSoldEn,
                      decoration: InputDecoration(
                        labelText: 'Sold Description In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.descriptionEn =
                              _controller.descriptionSoldEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Sold Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller.price,
                      decoration: InputDecoration(
                        labelText: 'سعر العرض',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.price = int.parse(_controller.price.text);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال سعر العرض';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller.lastPrice,
                      decoration: InputDecoration(
                        labelText: 'السعر القديم للعرض',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.lastPrice =
                              int.parse(_controller.lastPrice.text);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال السعر القديم للعرض';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller.longDaySold,
                      decoration: InputDecoration(
                        labelText: 'مدة عرض العرض بالأيام',
                      ),
                      onChanged: (text) {
                        setState(() {
                          soldData.longDay =
                              int.parse(_controller.longDaySold.text);
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'أدخل عدد أيام عرض العرض';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 100,
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
                              this._controller.imageUrl;
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
                            if (_controller.imageUrl.isEmpty ||
                                _controller.imageUrl == null) {
                              setState(() {
                                imageError = true;
                              });
                            } else if (_controller.imageUrl.isNotEmpty ||
                                _controller.imageUrl != null) {
                              setState(() {
                                imageError = false;
                              });
                            }
                            if (_formkey.currentState.validate()) {
                              await _controller.addSold(marketData, soldData);
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
