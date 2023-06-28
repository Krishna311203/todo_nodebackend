import 'package:flutter/material.dart';
import 'package:todo_nodebackend/widgets/mycolors.dart';

final textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors().green, width: 2)),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors().blue, width: 2)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors().blue, width: 2)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors().orange, width: 2)),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showsnackbar({context, color, message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "Ok",
      onPressed: (() {}),
      textColor: Colors.white,
    ),
  ));
}
