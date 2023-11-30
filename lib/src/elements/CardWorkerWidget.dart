import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:slider_button/slider_button.dart';
import 'package:structurepublic/src/controler/DemandController.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/models/DemandData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/UserDemand.dart';
import 'package:structurepublic/src/models/WorkerData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/CategorizePage.dart';
import 'package:structurepublic/src/pages/InfoDemandPage.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWorkerdWidget extends StatefulWidget {
  const CardWorkerdWidget(
      this.demandData, this.workerData, this.demandController);

  final DemandData demandData;
  final WorkerData workerData;
  final DemandController demandController;

  @override
  _CardWorkerdWidgetState createState() {
    return _CardWorkerdWidgetState(
        this.demandData, this.workerData, this.demandController);
  }
}

class _CardWorkerdWidgetState extends State<CardWorkerdWidget> {
  _CardWorkerdWidgetState(
      this.demandData, this.workerData, this.demandController);

  final DemandData demandData;
  final WorkerData workerData;
  final DemandController demandController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 220,
      width: double.maxFinite,
      child: Card(
        semanticContainer: true,
        color: demandData.done ? Colors.grey : Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    workerData.visible ? "online" : "offline",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: workerData.visible ? Colors.green : Colors.red,fontSize: 10,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      demandData.idWorker = workerData.id;
                      demandController.acceptDemand(demandData);
                      Navigator.pop(context);
                    },
                    minWidth: 5,
                    child: Icon(
                      Icons.send,
                      size: 20,
                      color:
                      workerData.visible ? Colors.blue : Colors.redAccent,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                backgroundImage: CachedNetworkImageProvider(
                  workerData.image,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                workerData.name,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Userss userss = new Userss(
                          lat: workerData.lat, long: workerData.long);
                      demandController.showLocation(userss);
                    },
                    minWidth: 5,
                    child: Icon(
                      Icons.location_history,
                      color: Colors.green,
                    ),
                  ),
                  MaterialButton(
                    height: double.minPositive,
                    onPressed: () {
                      launch(('tel://${workerData.phone}'));
                    },
                    minWidth: 5,
                    child: Icon(
                      Icons.call,
                      color: Colors.red,
                    ),
                  ),
                  MaterialButton(
                    height: double.minPositive,
                    onPressed: () {
                      demandController.launchURL("mailto:" + workerData.email);
                    },
                    minWidth: 5,
                    child: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
