import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  Random random = Random();
  int index = random.nextInt(colors.length);

  return colors[index];
}