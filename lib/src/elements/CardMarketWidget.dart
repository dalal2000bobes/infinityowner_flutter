import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:slider_button/slider_button.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/user.dart';
import 'package:structurepublic/src/pages/CategorizePage.dart';

class CardMarketWidget extends StatefulWidget {
  const CardMarketWidget(this.marketData, this.pageMarketController,this.admins);

  final Userss admins;
  final MarketData marketData;
  final PageMarketController pageMarketController;

  @override
  _CardMarketWidgetState createState() {
    return _CardMarketWidgetState(this.marketData, this.pageMarketController,this.admins);
  }
}

class _CardMarketWidgetState extends State<CardMarketWidget> {
  _CardMarketWidgetState(this.marketData, this.pageMarketController,this.admins);

  final Userss admins;
  final MarketData marketData;
  final PageMarketController pageMarketController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 300,
          width: double.maxFinite,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  new SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                        image: CachedNetworkImageProvider(marketData.image),
                        errorBuilder: (context, url, error) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: ListTile(
                      tileColor:
                      (marketData.hide == false)&&(marketData.active==true) ? Colors.white : Colors.grey,
                      leading: CircleAvatar(
                        backgroundColor: Colors.black12,
                        backgroundImage: CachedNetworkImageProvider(
                          marketData.imageIcon,
                        ),
                      ),
                      title: Text(
                        marketData.nameAr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        marketData.descriptionAr,
                      ),
                      trailing: GestureDetector(
                        child: MaterialButton(
                          onPressed: () {
                            pageMarketController.showEditDialog(
                                marketData, pageMarketController);
                          },
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.indigo,
                            size: 25,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Categorize(marketData,admins)));
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categorize(marketData,admins)));
                      },
                    ),
                  )
                ],
              ),
              onDoubleTap: () {
                setState(() {
                  marketData;
                });
              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Categorize(marketData,admins)));
              },
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Switch(
                value: !marketData.hide,
                onChanged: (value) {
                  pageMarketController.hideMarket(marketData);
                },
                activeColor: Colors.lightGreen,
                activeTrackColor: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
