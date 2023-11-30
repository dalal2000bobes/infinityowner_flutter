import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:structurepublic/src/controler/DemandController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/CardWorkerWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/DemandData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/WorkerData.dart';

import 'SnakBar.dart';

class WorkerShow extends StatefulWidget {
  final DemandData demandData;
  final List<WorkerData> workerList;
  final DemandController demandController;

  const WorkerShow(this.demandData, this.workerList, this.demandController);

  @override
  _WorkerShowState createState() {
    return _WorkerShowState(
        this.demandData, this.workerList, this.demandController);
  }
}

class _WorkerShowState extends State<WorkerShow> {
  final DemandData demandData;
  final List<WorkerData> workerList;
  final DemandController demandController;

  _WorkerShowState(this.demandData, this.workerList, this.demandController);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 300,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30,),
            for (int i = 0; i < workerList.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (i > 0)
                    Divider(
                      color: Colors.grey,
                    ),
                  CardWorkerdWidget(demandData, workerList[i], demandController)
                ],
              ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
