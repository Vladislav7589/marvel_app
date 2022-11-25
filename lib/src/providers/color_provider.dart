import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends StateNotifier<int> {
  ColorProvider() : super(Colors.blue.value);

  void change(int? color) => state = color!;
}

final colorProvider = StateNotifierProvider<ColorProvider, int>((ref) => ColorProvider());
