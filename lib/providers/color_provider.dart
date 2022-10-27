
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  late Color color = Colors.blue;

  void changeColor(Color? newColor) {
    color = newColor!;
    notifyListeners();
  }
  void update() =>  notifyListeners();
}