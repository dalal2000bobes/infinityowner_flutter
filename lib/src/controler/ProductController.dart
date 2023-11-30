import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/elements/DialogEditProductWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/repository/MarketRepository.dart' as repo;
import 'package:structurepublic/src/repository/ProductRepository.dart' as repo;

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageProductController extends ControllerMVC {
  //User user = new User();
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  int z;
  List<ProductData> listProduct = [];
  final CategorizeData categorizeData;

  TextEditingController _nameProductAr = new TextEditingController();
  TextEditingController _nameProductEn = new TextEditingController();
  TextEditingController _descriptionProductAr = new TextEditingController();
  TextEditingController _descriptionProductEn = new TextEditingController();
  TextEditingController _priceProduct = new TextEditingController();

  TextEditingController get nameProductAr => _nameProductAr;
  TextEditingController get nameProductEn => _nameProductEn;

  TextEditingController get descriptionProductAr => _descriptionProductAr;
  TextEditingController get descriptionProductEn => _descriptionProductEn;

  TextEditingController get priceProduct => _priceProduct;

  String imageUrl;

  PageProductController(this.categorizeData) {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
    getProducts();
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

  Future editProduct(ProductData productData) async {
    bool addToList=false;
    if(productData.id.isEmpty){
      addToList=true;
      productData.id=Uuid().generateV4();
    }
    productData.price = int.parse(priceProduct.text);
    productData.nameAr = nameProductAr.text;
    productData.nameEn = nameProductEn.text;
    productData.description_ar = descriptionProductAr.text;
    productData.description_en = descriptionProductEn.text;
    productData.image = imageUrl.toString();
    await repo.postProductNode(productData);
    setState(() {
      productData;
      if(addToList){
        listProduct.add(productData);
      }
      listProduct;
    });
    print("loooooooooooooooooooooooooooooooooooooooooooooooool");

    print("hidehidehidehidehide");
  }

  Future hideProduct(ProductData productData) async {
    productData.hide = !productData.hide;
    await repo.postProductNode(productData);
    setState(() {
      productData.hide;
    });
    print("hidehidehidehidehide");
  }


  showEditDialog(ProductData productData, CategorizeData categorizeData,
      PageProductController productController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditProduct(productData, categorizeData, productController);
        });
  }

  getProducts() async {
    setState(() {
      listProduct.clear();
    });
    await repo.getProductNode(this.categorizeData).then((value) {
      setState(() {
        listProduct.addAll(value);
      });
    });
    // await repo.getProduct(this.categorizeData).then((value) {
    //   setState(() {
    //     listProduct.addAll(value);
    //   });
    // });
  }
}
