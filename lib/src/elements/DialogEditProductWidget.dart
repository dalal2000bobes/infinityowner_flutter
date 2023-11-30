import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:structurepublic/src/controler/ProductController.dart';
import 'package:structurepublic/src/models/CategorizeData.dart';
import 'package:structurepublic/src/models/ProductData.dart';

import 'SnakBar.dart';

class EditProduct extends StatefulWidget {
  final ProductData productData;
  final CategorizeData categorizeData;
  final PageProductController productController;

  const EditProduct(
      this.productData, this.categorizeData, this.productController);

  @override
  _EditProductState createState() {
    return _EditProductState(
        this.productData, this.categorizeData, this.productController);
  }
}

class _EditProductState extends State<EditProduct> {
  final ProductData productData;
  final CategorizeData categorizeData;
  final PageProductController productController;

  _EditProductState(
      this.productData, this.categorizeData, this.productController) {
    productController.imageUrl = productData.image;
    productController.nameProductAr.text = productData.nameAr;
    productController.nameProductEn.text = productData.nameEn;
    productController.descriptionProductAr.text = productData.description_ar;
    productController.descriptionProductEn.text = productData.description_en;
    if (productData.id.isEmpty) {
      productController.priceProduct.text = "";
    } else {
      productController.priceProduct.text = productData.price.toString();
    }
  }

  final _formkey = GlobalKey<FormState>();
  bool imageError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(7, 7, 7, 0),
                          height: 210,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            //  color: Colors.orange,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                new SizedBox(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  // child:Image.network('https://dbq8hrmshvuto.cloudfront.net/a2d/f98c8/0803/4c93/9ebe/05596a8ed7a9/normal/516995.jpg',fit: BoxFit.cover,),
                                  child: Image(
                                    errorBuilder: (context, url, error) =>
                                        Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    image: CachedNetworkImageProvider(
                                      productController.imageUrl,
                                    ),
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      productData.description_ar ?? " ",
                                    ),

                                    trailing: Container(
                                      child: Text(
                                        productData.price.toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: EdgeInsets.all(15),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              this.productController.getImage();
                            });
                          },
                          minWidth: 0.0,
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (imageError)
              Center(
                child: Text(
                  "الرجاء التأكد من ادخال صورة عن المنتج",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: productController.nameProductAr,
                      decoration: InputDecoration(
                        labelText: ' اسم المنتج بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          productData.nameAr =
                              productController.nameProductAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال اسم المنتج بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: productController.nameProductEn,
                      decoration: InputDecoration(
                        labelText: 'Product Name In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          productData.nameEn =
                              productController.nameProductEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Product Name In English';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: productController.descriptionProductAr,
                      decoration: InputDecoration(
                        labelText: 'وصف المنتج بالعربي',
                      ),
                      onChanged: (text) {
                        setState(() {
                          productData.description_ar =
                              productController.descriptionProductAr.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال وصف المنتج بالعربي';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: productController.descriptionProductEn,
                      decoration: InputDecoration(
                        labelText: 'Product Description In English',
                      ),
                      onChanged: (text) {
                        setState(() {
                          productData.description_en =
                              productController.descriptionProductEn.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Product Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: productController.priceProduct,
                      decoration: InputDecoration(
                        labelText: 'سعر المنتج',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال سعر المنتج';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          productData.price =
                              int.parse(productController.priceProduct.text);
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.refresh,
                            color: Colors.red[300],
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              this.productController.imageUrl;
                            });
                            // dispose();
                            // Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          minWidth: 10,
                          height: 10,
                          child: Icon(
                            Icons.send,
                            color: Colors.indigo[500],
                            size: 30,
                          ),
                          onPressed: () async {
                            if (productController.imageUrl.isEmpty ||
                                productController.imageUrl == null) {
                              setState(() {
                                imageError = true;
                              });
                            } else if (productController.imageUrl.isNotEmpty ||
                                productController.imageUrl != null) {
                              setState(() {
                                imageError = false;
                              });
                            }
                            if (_formkey.currentState.validate()) {
                              await productController.editProduct(productData);
                              dispose();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
