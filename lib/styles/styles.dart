import 'package:flutter/material.dart';

TextStyle textStyle ( double size, FontWeight? fontWeight) {
  return TextStyle(
    color: Colors.white,
    fontSize: size,
    shadows: const [
      Shadow(
        blurRadius: 5.0,
        color: Colors.black,
        offset: Offset(2.0, 0.0),
      ),
    ],
    fontWeight: fontWeight?? FontWeight.normal,
  );
}