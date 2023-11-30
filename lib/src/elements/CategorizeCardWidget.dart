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
import 'package:structurepublic/src/pages/ProductPage.dart';

// ignore: must_be_immutable
class CardCategorizeWidget extends StatelessWidget {
  const CardCategorizeWidget(
      this.categorizeData, this.categorizeController, this.marketData);

  final PageCategorizeController categorizeController;
  final CategorizeData categorizeData;
  final MarketData marketData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 200,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Container(
                color:
                    categorizeData.hide == false ? Colors.white : Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Switch(
                      value: !categorizeData.hide,
                      onChanged: (value) {
                        categorizeController.hideCategorize(
                            categorizeController.marketData, categorizeData);
                      },
                      activeColor: Colors.blue[200],
                      activeTrackColor: Colors.white70,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Products(categorizeData)));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      padding: EdgeInsets.all(0.5),
                      color: Colors.white70,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 100.0, minHeight: 40.0, maxHeight: 50),
                        alignment: Alignment.center,
                        child: Text(
                          categorizeData.nameAr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      onError: (url, error) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      image: CachedNetworkImageProvider(
                        categorizeData.image,
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Container(
                color:
                    categorizeData.hide == false ? Colors.white : Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 10,
                      height: 10,
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.blue[200],
                        size: 25,
                      ),
                      onPressed: () {
                        categorizeController.showEditDialog(
                            marketData, categorizeData, categorizeController);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Products(categorizeData)));
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
