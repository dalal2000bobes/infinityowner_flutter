import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/SoldData.dart';
import 'package:structurepublic/src/pages/ProductPage.dart';

// ignore: must_be_immutable

String convertDate(DateTime dateTime) {
  String stateDate;
  if (dateTime.hour >= 12)
    stateDate = "PM";
  else if (dateTime.hour < 12) stateDate = "AM";
  String ourDate =
      "${dateTime.year.toString()}/${dateTime.month.toString()}/${dateTime.day.toString()}\t\t\t${dateTime.hour.toString()}:${dateTime.minute.toString()}:${dateTime.second.toString()}\t\t$stateDate                                                                                         ";
  return ourDate;
}

class CardSoldWidget extends StatelessWidget {
  const CardSoldWidget(
    this.marketData,
    this.soldData,
  );

  final MarketData marketData;
  final SoldData soldData;

  //var now=DateTime.now();
  //var date=DateTime.parse(soldData.dateSend);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.maxFinite,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    //color: soldData.hide == false ? Colors.white : Colors.grey,
                    child: Text(
                      "\t\t\t\t\t" +
                          convertDate(DateTime.fromMicrosecondsSinceEpoch(
                              soldData.timesTamp)),
                      //"\t\t\t\t\t" +convertDate(DateTime.parse(soldData.timeSend)),
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
                    image: CachedNetworkImageProvider(
                      soldData.image,
                    ),
                    errorBuilder: (context, url, error) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                        ),
                    fit: BoxFit.cover),
              ),
              Expanded(
                child: ListTile(
                  tileColor:
                      soldData.hide == false ? Colors.white : Colors.grey[400],
                  leading: CircleAvatar(
                    backgroundColor: Colors.black12,
                    backgroundImage: CachedNetworkImageProvider(
                      soldData.imageIcon,
                    ),
                  ),
                  trailing: Text(
                    soldData.price.toString(),
                    style: TextStyle(fontSize: 15, color: Colors.red[300]),
                  ),
                  title: Text(
                    soldData.nameAr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    soldData.descriptionAr ?? " ",
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: soldData.hide == false ? Colors.white : Colors.grey[400],
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
