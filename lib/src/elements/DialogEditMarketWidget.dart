import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';

import 'SnakBar.dart';

class EditMarket extends StatefulWidget {
  final MarketData marketData;
  final PageMarketController marketController;

  const EditMarket(this.marketData, this.marketController);

  @override
  _EditMarketState createState() {
    return _EditMarketState(this.marketData, this.marketController);
  }
}

class _EditMarketState extends State<EditMarket> {
  final MarketData marketData;
  final PageMarketController marketController;

  bool imageError = false;

  _EditMarketState(this.marketData, this.marketController) {
    marketController.imageUrlIcon = marketData.imageIcon;
    marketController.imageUrl = marketData.image;
    marketController.descriptionAr.text = marketData.descriptionAr;
    marketController.descriptionEn.text = marketData.descriptionEn;
    marketController.nameAr.text = marketData.nameAr;
    marketController.nameEn.text = marketData.nameEn;
    marketController.long = marketData.long;
    marketController.lat = marketData.lat;
    //LatLng latLng = new LatLng(marketData.lat, marketData.lat);
    //marketController.locationResultMarket = new LocationResult(latLng: LatLng(marketData.lat,marketData.long),address: null);
    //marketController.locationResultMarket.latLng=marketData.lat as LatLng;
    marketController.open = TimeOfDay(
        hour:
            DateTime.fromMillisecondsSinceEpoch(marketData.timesTampOpen).hour,
        minute: DateTime.fromMillisecondsSinceEpoch(marketData.timesTampOpen)
            .minute);
    marketController.close = TimeOfDay(
        hour:
            DateTime.fromMillisecondsSinceEpoch(marketData.timesTampClose).hour,
        minute: DateTime.fromMillisecondsSinceEpoch(marketData.timesTampClose)
            .minute);
  }

  final _formkey = GlobalKey<FormState>();

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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    marketData.active?Icons.visibility:Icons.visibility_off,
                    color: marketData.active?Colors.green:Colors.red,
                  ),
                  Text(marketData.active?"\t\t\tActive":"\t\t\tNo Active",
                    style: TextStyle(color: marketData.active?Colors.green:Colors.red,),),
                ],
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.maxFinite,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
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
                                      marketController.imageUrl),
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: ListTile(
                                tileColor: marketData.hide == false
                                    ? Colors.white
                                    : Colors.grey,
                                leading: CircleAvatar(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        this.marketController.getImageIcon();
                                      });
                                    },
                                    minWidth: 0.0,
                                  ),
                                  backgroundColor: Colors.black12,
                                  backgroundImage: CachedNetworkImageProvider(
                                    marketController.imageUrlIcon,
                                  ),
                                ),
                                title: Text(
                                  marketData.nameAr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //subtitle: Text(marketController.locationMarket.toString()),
                                subtitle: Text(
                                  marketData.descriptionAr,
                                ),
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
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
                              this.marketController.getImage();
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
                  "الرجاء التأكد من ادخال صورة غلاف و أيقونة المتجر",
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
                      controller: marketController.nameAr,
                      decoration: InputDecoration(
                        labelText: ' اسم المتجر بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          marketData.nameAr = marketController.nameAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال اسم المتجر بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: marketController.nameEn,
                      decoration: InputDecoration(
                        labelText: 'Market Name In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          marketData.nameEn = marketController.nameEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Market Name In English';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: marketController.descriptionAr,
                      decoration: InputDecoration(
                        labelText: 'وصف المتجر بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          marketData.descriptionAr =
                              marketController.descriptionAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال وصف المتجر بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: marketController.descriptionEn,
                      decoration: InputDecoration(
                        labelText: 'Market Description In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          marketData.descriptionEn =
                              marketController.descriptionEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Market Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        marketController.selectTimeOpen();
                        setState(() {
                          marketController.open;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.more_time, color: Colors.lightBlue),
                          SizedBox(width: 10),
                          Text('وقت الفتح : '),
                          SizedBox(width: 10,),
                          Text('${marketController.open.format(context)}')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        marketController.selectTimeClose();
                        setState(() {
                          marketController.close;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.more_time, color: Colors.red),
                          SizedBox(width: 10),
                          Text('وقت الإغلاق :'),
                          SizedBox(width: 10,),
                          Text('${marketController.close.format(context)}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            minWidth: 10,
                            height: 10,
                            child: Icon(
                              Icons.edit_location_outlined,
                              color: Colors.green,
                              size: 25,
                            ),
                            onPressed: () async {
                              // showLocationPicker(
                              //   context, "AIzaSyDO3WfoiEpkRKCiMePjGszgKZdHvycs_jI",
                              //   initialCenter: LatLng(31.1975844, 29.9598339),
                              //   myLocationButtonEnabled: true,
                              //   layersButtonEnabled: true,
                              //   //countries: ['AE', 'NG'],
                              // );
                              await this
                                  .marketController
                                  .editLocation(marketData);
                              //print("aaaaaaaaaaaaaaaaallllllllllooooooooooooooooooo${marketController.locationMarket.latitude.toString()}");
                              print(
                                  "aaaaaaaaaaaaaaaaallllllllllooooooooooooooooooo${marketController.locationResultMarket.toString()}");
                              // dispose();
                              // Navigator.pop(context);
                            },
                          ),
                        ),
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
                              this.marketController.imageUrl;
                              this.marketController.imageUrlIcon;
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
                            if (marketController.imageUrl.isEmpty ||
                                marketController.imageUrl == null ||
                                marketController.imageUrlIcon.isEmpty ||
                                marketController.imageUrlIcon == null) {
                              setState(() {
                                imageError = true;
                              });
                            } else if (marketController.imageUrl.isNotEmpty ||
                                marketController.imageUrl != null ||
                                marketController.imageUrlIcon.isNotEmpty ||
                                marketController.imageUrlIcon != null) {
                              setState(() {
                                imageError = false;
                              });
                            }
                            if (_formkey.currentState.validate() &&
                                !imageError) {
                              await marketController.editMarket(marketData);
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
