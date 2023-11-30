import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/elements/DialogEditProductWidget.dart';
import 'package:structurepublic/src/elements/DialogEditSoldWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/models/SoldData.dart';
import 'package:structurepublic/src/repository/MarketRepository.dart' as repo;
import 'package:structurepublic/src/repository/ProductRepository.dart' as repo;
import 'package:structurepublic/src/repository/SoldRepository.dart' as repo;

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SoldController extends ControllerMVC {
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  final MarketData marketData;
  List<SoldData> listSold = [];

  TextEditingController _descriptionSoldAr = new TextEditingController();
  TextEditingController _descriptionSoldEn = new TextEditingController();
  TextEditingController _nameAr = new TextEditingController();
  TextEditingController _nameEn = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  TextEditingController _lastPrice = new TextEditingController();
  TextEditingController _longDaySold = new TextEditingController();

  TextEditingController get longDaySold => _longDaySold;
  TextEditingController get descriptionSoldAr => _descriptionSoldAr;
  TextEditingController get descriptionSoldEn => _descriptionSoldEn;
  TextEditingController get nameAr => _nameAr;
  TextEditingController get nameEn => _nameEn;
  TextEditingController get price => _price;
  TextEditingController get lastPrice => _lastPrice;

  String imageUrl;

  SoldController(this.marketData) {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }



  @override
  void initState() {
    super.initState();
    getSolds();
  }



  getSolds() async {
    setState(() {
      listSold.clear();
    });
    await repo.getSoldNode(this.marketData).then((value) {
      setState(() {
        listSold.addAll(value);
      });
    });
  }


  Future getImage() async {
    File _image;
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        _image = await File(pickedFile.path);
        imageUrl = await repo.upLoadImage(_image);
      } else {
        print('No image selected.');
      }
      imageUrl;
    });
  }

  showEditDialog(MarketData marketData, SoldData soldData,
      SoldController soldController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddSold(soldData, soldController, marketData);
        });
  }

  Future addSold(MarketData marketData, SoldData soldData) async {
    soldData.id = Uuid().generateV4();
    soldData.idMarket=marketData.id;
    soldData.descriptionAr = descriptionSoldAr.text;
    soldData.descriptionEn = descriptionSoldEn.text;
    soldData.nameAr = nameAr.text;
    soldData.nameEn = nameEn.text;
    soldData.nameMarketEn = marketData.nameEn;
    soldData.nameMarketAr = marketData.nameAr;
    soldData.price=int.parse(price.text);
    soldData.hide=false;
    soldData.longDay=int.parse(longDaySold.text);
    var date=DateTime.now();
    soldData.timeSend=date.toString();
    soldData.timesTamp=date.millisecondsSinceEpoch;
    soldData.image = imageUrl.toString();
    await repo.postSoldNode(soldData,true);
    setState(() {
      soldData;
      listSold.add(soldData);
      listSold;
    });
    print("loooooooooooooooooooooooooooooooooooooooooooooooool");
    print("hidehidehidehidehide");
  }
}
