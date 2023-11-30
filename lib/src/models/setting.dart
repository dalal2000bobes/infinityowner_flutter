import 'package:flutter/material.dart';

import '../helpers/custom_trace.dart';

class Setting {
  String appName = '';
  double defaultTax;
  String defaultCurrency;
  String distanceUnit;
  bool currencyRight = false;
  bool payPalEnabled = true;
  bool stripeEnabled = true;
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  String appVersion;
  bool enableVersion = true;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

}
