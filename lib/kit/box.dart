import 'package:flutter/painting.dart';

class Box {
  final Color color;
  Box({this.color = const Color(0x00000000)});

  Box paint(Color color) => Box(color: isEmpty ? null : color);
  bool get isEmpty => color == null;

  factory Box.empty() => Box(color: null);
  factory Box.fill(Color color) => Box(color: color);

  @override
  String toString() {
    return color == null ? '.' : 'o';
  }
}
