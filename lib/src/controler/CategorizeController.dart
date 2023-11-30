import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/elements/DialogEditCategorizeWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/repository/MarketRepository.dart' as repo;
import 'package:structurepublic/src/repository/ProductRepository.dart' as repo;
import 'package:structurepublic/src/repository/CategorizeRepository.dart'
    as repo;

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageCategorizeController extends ControllerMVC {
  //User user = new User();
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  List<CategorizeData> listCategorize = [];
  final MarketData marketData;



  TextEditingController _nameProductAr = new TextEditingController();
  TextEditingController _nameProductEn = new TextEditingController();

  TextEditingController get nameProductAr => _nameProductAr;
  TextEditingController get nameProductEn => _nameProductEn;

  String imageUrl;


  PageCategorizeController(this.marketData) {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
    getCategorizes();
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

  showEditDialog(MarketData marketData, CategorizeData categorizeData,
      PageCategorizeController categorizeController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditCategorize(marketData, categorizeData, categorizeController);
        });
  }


  Future editCategorize(MarketData marketData,CategorizeData categorizeData) async {
    bool addToList=false;
    if(categorizeData.id.isEmpty){
      addToList=true;
      categorizeData.id=Uuid().generateV4();
    }
    categorizeData.nameAr = nameProductAr.text;
    categorizeData.nameEn = nameProductEn.text;
    categorizeData.image = imageUrl.toString();
    await repo.postCategorizeNode(marketData,categorizeData);
    setState(() {
      categorizeData;
      if(addToList){
        listCategorize.add(categorizeData);
      }
      listCategorize;
    });
    print("loooooooooooooooooooooooooooooooooooooooooooooooool");

    print("hidehidehidehidehide");
  }

  getCategorizes() async {
    setState(() {
      listCategorize.clear();
    });
    await repo.getCategorizeNode(this.marketData).then((value) {
      setState(() {
        listCategorize.addAll(value);
      });
    });
  }

  Future hideCategorize(
      MarketData marketData, CategorizeData categorizeData) async {
    categorizeData.hide = !categorizeData.hide;
    await repo.postCategorizeNode(marketData, categorizeData);
    setState((){categorizeData.hide;});
    print("hidehidehidehidehide");
  }
}
