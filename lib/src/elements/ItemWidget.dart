import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key key, @required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("item $index",style: TextStyle(color: Colors.white),),
    );
  }
}
