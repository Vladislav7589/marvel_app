
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  late int color = Colors.blue.value;

  void changeColor(int? newColor) {
    color = newColor!;
    notifyListeners();
  }
  void update() =>  notifyListeners();
}