import 'package:flutter/material.dart';

Widget pageLoader(){
  return Positioned.fill(
    child: Align(
        alignment: Alignment.center,
        child: Container(
          width:300,
          height:300,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: customCircularLoading(30, Colors.lightBlue, strokeWidth: 7),
          ),
        )
    ),
  );
}

Widget customCircularLoading(double size, Color color, {double strokeWidth = 3.5}){
  return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      )
  );
}