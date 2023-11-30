import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:structurepublic/src/controler/MarketController.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/ProductData.dart';
import 'package:structurepublic/src/pages/ProductPage.dart';

class CardProductWidget extends StatelessWidget {
  final ProductData productData;
  final CategorizeData categorizeData;
  final PageProductController productController;

  const CardProductWidget(
      this.categorizeData, this.productData, this.productController);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(7, 7, 7, 0),
          height: 280,
          width: double.maxFinite,
          child: Card(
              elevation: 5,
              //  color: Colors.orange,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Container(
                    color:
                        productData.hide == false ? Colors.white : Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.red[300],
                            size: 25,
                          ),
                          onPressed: () {
                            productController.showEditDialog(
                                productData, categorizeData, productController);
                          },
                        ),
                        Switch(
                          value: !productData.hide,
                          onChanged: (value) {
                            productController.hideProduct(productData);
                          },
                          activeColor: Colors.red[300],
                          activeTrackColor: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    // child:Image.network('https://dbq8hrmshvuto.cloudfront.net/a2d/f98c8/0803/4c93/9ebe/05596a8ed7a9/normal/516995.jpg',fit: BoxFit.cover,),
                    child: Image(
                      errorBuilder: (context, url, error) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      image: CachedNetworkImageProvider(productData.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      tileColor: productData.hide == false
                          ? Colors.white
                          : Colors.grey,
                      //   leading: CircleAvatar(backgroundColor: Colors.black12,backgroundImage:NetworkImage('https://arab-rate.com/media/reviews/photos/original/cd/77/3e/309-309-79-1578342205.jpg',),),
                      title: Text(
                        productData.nameAr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        productData.description_ar ?? " ",
                      ),

                      trailing: GestureDetector(
                        child: Text(
                          productData.price.toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        // child:Icon(Icons.access_time, color: Colors.grey,),
                        onTap: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductDetail(productData,categorizeData)) );
                        },
                      ),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductDetail(productData,categorizeData)) );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              )),
        )),
      ]),
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductDetail(productData,categorizeData)) );

        // navigetor("");
      },
    );
  }
}
