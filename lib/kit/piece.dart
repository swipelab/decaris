import 'package:flutter/painting.dart';

import 'box.dart';

class Body {
  final int cols;
  final int rows;
  int get size => cols * rows;

  final List<Box> boxes;

  Body({this.cols, this.rows, List<Box> boxes})
      : assert(cols * rows > 0),
        boxes = boxes ?? List<Box>(cols * rows);

  bool hitAt(int x, int y) =>
      (x + y * cols) < boxes.length && !boxes[x + y * cols].isEmpty;

  Body rotateLeft() => Body(
      cols: rows,
      rows: cols,
      boxes: Iterable.generate(size)
          .map((i) => boxes[(cols - (i ~/ rows) - 1) + (i % rows) * cols])
          .toList());

  Body rotateRight() => Body(
      cols: rows,
      rows: cols,
      boxes: Iterable.generate(size)
          .map((i) => boxes[(i ~/ rows) + ((rows - i % rows - 1) * cols)])
          .toList());

  Body paint(Color color) => Body(
      cols: cols,
      rows: rows,
      boxes: boxes.map((box) => box.paint(color)).toList());

  @override
  String toString() {
    return boxes.map((i) => i.toString()).join() + "($cols,$rows)";
  }
}
