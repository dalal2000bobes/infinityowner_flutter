import 'package:flutter/material.dart';

void showSnakBar(String note,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      content: Text(note),
      backgroundColor: Colors.white70,
      width: double.maxFinite,
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}