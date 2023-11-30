import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/DemandController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/CardDemandWidget.dart';
import 'package:structurepublic/src/elements/CategorizeCardWidget.dart';
import 'package:structurepublic/src/elements/DemandInfoCardWidget.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/DemandData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/MarketPage.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDemand extends StatefulWidget {
  //final CategorizeData categorizeData;

  final DemandData demandData;
  final Userss user;
  final DemandController demandController;

  const InfoDemand(this.demandData, this.user, this.demandController);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InfoDemand(this.demandData, this.user, this.demandController);
  }
}

class _InfoDemand extends StateMVC<InfoDemand> {
  final DemandData demandData;
  final Userss user;
  final DemandController demandController;

  _InfoDemand(this.demandData, this.user, this.demandController);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "\t\t\t\t\t" +
              demandController.convertDate(DateTime.fromMicrosecondsSinceEpoch(
                  demandData.timesTampCreat)),
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, bottom: 30, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black12,
              backgroundImage: CachedNetworkImageProvider(
                user.image,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    demandController.showLocation(user);
                  },
                  child: Icon(
                    Icons.location_history,
                    color: Colors.green,
                  ),
                ),
                MaterialButton(
                  height: double.minPositive,
                  onPressed: () {
                    launch(('tel://${user.phone}'));
                  },
                  child: Icon(
                    Icons.call,
                    color: Colors.red,
                  ),
                ),
                MaterialButton(
                  height: double.minPositive,
                  onPressed: () {
                    demandController.launchURL("mailto:" + user.email);
                  },
                  child: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10),
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  demandData.priceTotal.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "ل.س",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          for (int i = 0;
                              i < demandData.product.length;
                              i = i + 2)
                            CardDemandInfoWidget(demandData.product[i]),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          for (int i = 1;
                              i < demandData.product.length;
                              i = i + 2)
                            CardDemandInfoWidget(demandData.product[i]),
                        ],
                      ),
                      if(demandData.product.length<=1)
                        SizedBox(width: 150,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
