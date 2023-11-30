
import 'package:flutter/material.dart';

import 'src/pages/mainView.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/MainStateWidget':
        return MaterialPageRoute(builder: (_) => MainStateWidget());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
