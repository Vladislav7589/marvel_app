
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  late Color color = Colors.blue;
  late String url;

  void changeColor(Color? newColor) {
    color = newColor!;
    //notifyListeners();
  }

   updateColor()  {
    notifyListeners();
  }
}