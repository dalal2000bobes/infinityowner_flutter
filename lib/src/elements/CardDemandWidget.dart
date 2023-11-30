import 'package:cached_network_image/cached_network_image.dart';
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

class CardDemandWidget extends StatefulWidget {
  const CardDemandWidget(this.demandData, this.user, this.demandController);

  final DemandData demandData;
  final Userss user;
  final DemandController demandController;

  @override
  _CardDemanWidgetState createState() {
    return _CardDemanWidgetState(
        this.demandData, this.user, this.demandController);
  }
}

class _CardDemanWidgetState extends State<CardDemandWidget> {
  _CardDemanWidgetState(this.demandData, this.user, this.demandController);

  final DemandData demandData;
  final Userss user;
  final DemandController demandController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Card(
        semanticContainer: true,
        color: demandData.done?Colors.grey:Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black12,
                      backgroundImage: CachedNetworkImageProvider(
                        user.image,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(user.phone.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 10,
              ),
              if(demandData.done)
              SizedBox(
                width: 100,
              ),
              if(!demandData.done)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 5,
                    onPressed: () {
                      demandController.removeDemand(demandData);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 5,
                    onPressed: () {
                      demandController.showWorkerDialog(demandData, demandController);
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoDemand(demandData, user, demandController),
              ),
            );
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoDemand(demandData, user, demandController),
              ),
            );
          },
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
