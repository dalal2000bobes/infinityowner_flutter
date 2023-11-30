import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:structurepublic/src/elements/DialogEditMarketWidget.dart';
import 'package:structurepublic/src/models/MarketData.dart';
import 'package:structurepublic/src/models/SectionData.dart';
import 'package:structurepublic/src/models/SoldData.dart';
import 'package:structurepublic/src/repository/MarketRepository.dart' as repo;
import 'package:structurepublic/src/repository/ProductRepository.dart' as repo;

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageMarketController extends ControllerMVC {
  //User user = new User();

  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<MarketData> listMarket = [];
  final Userss admin;

  TextEditingController _nameAr = new TextEditingController();

  TextEditingController get nameAr => _nameAr;
  TextEditingController _nameEn = new TextEditingController();

  TextEditingController get nameEn => _nameEn;
  TextEditingController _descriptionAr = new TextEditingController();

  TextEditingController get descriptionAr => _descriptionAr;
  TextEditingController _descriptionEn = new TextEditingController();

  TextEditingController get descriptionEn => _descriptionEn;
  TextEditingController _timesTampClose = new TextEditingController();

  TextEditingController get timesTampClose => _timesTampClose;
  TextEditingController _timesTampOpen = new TextEditingController();

  TextEditingController get timesTampOpen => _timesTampOpen;

  String imageUrl;
  String imageUrlIcon;
  LocationResult locationResultMarket;
  LocationData locationMarket;
  double lat;
  double long;


  TimeOfDay open = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay close = TimeOfDay(hour: 00, minute: 00);

  DateTime openTime;
  DateTime closeTime;

  PageMarketController(this.admin) {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  // PageMarketController(this.sectionData) {
  //   loader = Helper.overlayLoader(context);
  //   this.scaffoldKey = new GlobalKey<ScaffoldState>();
  // }

  @override
  void initState() {
    super.initState();
    getMarkets();
  }


  void selectTimeOpen() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: open,
    );
    if (newTime != null) {
      setState(() {
        open = newTime;
      });
    }

    print('lllllllllllllllaaaaaaaaaaaaaaaaarrrrrrrrrrrgggggggggggg\t\t\t'+DateTime.utc(open.hour,open.minute).toString());
  }

  void selectTimeClose() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: close,
    );
    if (newTime != null) {
      setState(() {
        close = newTime;
      });
    }
  }

  void editLocation(MarketData marketData) async {
    //locationMarket = LocationData.fromMap(Location.instance.getLocation());
    LocationResult result = await showLocationPicker(
      context,
      "AIzaSyDO3WfoiEpkRKCiMePjGszgKZdHvycs_jI",
      //initialCenter: LatLng(31.1975844, 29.9598339),
      initialCenter: LatLng(marketData.lat.toDouble() , marketData.long.toDouble()),
      automaticallyAnimateToCurrentLocation: false,
      //mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
       requiredGPS: true,
      layersButtonEnabled: true,
      //countries: ['AE', 'NG'],
      resultCardAlignment: Alignment.bottomRight,
      resultCardPadding: EdgeInsets.only(right: 50,bottom: 10),
      //desiredAccuracy: LocationAccuracy.best,
    );
    print("result = $result");

    setState((){
      locationResultMarket = result;
      lat=result.latLng.latitude.toDouble();
      long=result.latLng.longitude.toDouble();
    });
  }

  getMarkets() async {
    setState(() {
      listMarket.clear();
    });
    
    await repo.getMarketNode(this.admin).then((value) {
      //await repo.getMarket(this.sectionData).then((value) {
      setState(() {
        print("kkkkkkkkkkkkkkkkkkkkkkkk000000000000000000000000000" + admin.id);
        listMarket.addAll(value);

        // for(int i=0;i<listMarket.length;i++)
        // {if(listMarket[i].idSection!=sectionData.id)
        // {listMarket.removeAt(i);}
        // }
      });
      print(listMarket.length.toString() +
          "444444444444444444444444444444444444444444444");
    }).catchError((e){print("ddoddodododooooddoododododdddddooooo"+e);});
  }

  Future hideMarket(MarketData marketData) async {
    marketData.hide = !marketData.hide;
    await repo.hideMarket(marketData);
    setState(() {
      marketData.hide;
    });
    print("hidehidehidehidehide");
  }

  Future editMarket(MarketData marketData) async {
    marketData.nameAr = nameAr.text;
    marketData.nameEn = nameEn.text;
    marketData.descriptionAr = descriptionAr.text;
    marketData.descriptionEn = descriptionEn.text;
    marketData.image = imageUrl.toString();
    marketData.imageIcon = imageUrlIcon.toString();
    marketData.lat=lat;
    marketData.long=long;
    // marketData.lat=locationResultMarket.latLng.latitude.toDouble();
    // marketData.long=locationResultMarket.latLng.longitude.toDouble();

    DateTime dateTime=DateTime.now();

    openTime=new DateTime(dateTime.year,dateTime.month,dateTime.day,open.hour,open.minute);
    closeTime=new DateTime(dateTime.year,dateTime.month,dateTime.day,close.hour,close.minute);

    marketData.timesTampOpen=openTime.millisecondsSinceEpoch;
    marketData.timesTampClose=closeTime.millisecondsSinceEpoch;

    await repo.postMarketNode(marketData,false);
    setState(() {
      marketData.image;
      marketData.imageIcon;
      listMarket;
      marketData;
    });
    print("loooooooooooooooooooooooooooooooooooooooooooooooool");

    print("hidehidehidehidehide");
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

  Future getImageIcon() async {
    File _image;
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        _image = await File(pickedFile.path);
        imageUrlIcon = await repo.upLoadImage(_image);
      } else {
        print('No image selected.');
      }
      imageUrlIcon;
    });
  }

  showEditDialog(MarketData marketData, PageMarketController marketController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditMarket(marketData, marketController);
        });
  }
}
