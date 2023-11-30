import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:slider_button/slider_button.dart';
import 'package:structurepublic/src/controler/DemandController.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/models/DemandData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/UserDemand.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/CategorizePage.dart';
import 'package:structurepublic/src/pages/InfoDemandPage.dart';

class CardDemandInfoWidget extends StatefulWidget {
  const CardDemandInfoWidget(this.product);

  final Product product;

  @override
  _CardDemandInfoWidgetState createState() {
    return _CardDemandInfoWidgetState(this.product);
  }
}

class _CardDemandInfoWidgetState extends State<CardDemandInfoWidget> {
  _CardDemandInfoWidgetState(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        color: Colors.white70,
        margin: EdgeInsets.all(10),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    product.number.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 5,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    product.image,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.nameAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product.descriptionAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                if(product.note.isNotEmpty)
                Text(
                  product.note,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                if(product.note.isNotEmpty)
                SizedBox(
                  height: 5,
                ),
                if(product.note.isNotEmpty)
                Divider(
                  color: Colors.grey,
                ),
                if(product.note.isNotEmpty)
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ل.س",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      product.priceTotal.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
