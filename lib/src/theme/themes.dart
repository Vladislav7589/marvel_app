import 'package:flutter/material.dart';


final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
        shadows: [
          Shadow(
            blurRadius: 8.0,
            color: Colors.white,
            offset: Offset(0.0, 0.0),
          ),
        ],
      )
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffe2e2e2),
  highlightColor: Colors.black38,
);
final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 8.0,
            color: Colors.black,
            offset: Offset(0.0, 0.0),
          ),
        ],
      )
  ),
  brightness: Brightness.dark,
  highlightColor: Colors.white10,
  scaffoldBackgroundColor: const Color(0xff2a262b),
);