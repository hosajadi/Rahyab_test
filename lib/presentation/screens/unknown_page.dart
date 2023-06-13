import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        "Not Found",
        style: TextStyle(
            fontSize: 24
        ),
      ),
    );
  }
}