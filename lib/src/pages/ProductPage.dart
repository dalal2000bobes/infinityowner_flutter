import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:structurepublic/src/controler/CategorizeController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/elements/CategorizeCardWidget.dart';
import 'package:structurepublic/src/elements/ProductCardWidget.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';

class Products extends StatefulWidget {
  final CategorizeData categorizeData;

  int c = 0;

  @override
  Products(
    this.categorizeData,
  );

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Products(this.categorizeData);
  }
}

class _Products extends StateMVC<Products> {
  final CategorizeData categorizeData;
  PageProductController _con;

  _Products(this.categorizeData)
      : super(PageProductController(categorizeData)) {
    _con = controller;
  }

  PageProductController _get() {
    return _con;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(categorizeData.nameAr),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _con.listProduct.length,
        itemBuilder: (context, i) {
          return CardProductWidget(categorizeData, _con.listProduct[i], _con);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() async {
            ProductData newProductData = new ProductData();
            newProductData.hide = false;
            newProductData.id_categorize = categorizeData.id;
            newProductData.image = "";
            newProductData.id ="";
            newProductData.description_ar = "";
            newProductData.description_en = "";
            newProductData.nameAr = "";
            newProductData.nameEn = "";
            newProductData.note = "";
            newProductData.price = 0;
            await _con.showEditDialog(newProductData, categorizeData, _con);
          });
        },
      ),
    );
  }
}
