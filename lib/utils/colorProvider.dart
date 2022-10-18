
import 'dart:math';
import 'package:flutter/material.dart';


class ColorProvider extends ChangeNotifier {
  Color color = Colors.blue;

  void changeColor() {
    color = Color(Random().nextInt(0xffffffff));
    notifyListeners();
  }
}