import 'dart:math';

import 'package:decaris/kit/box.dart';
import 'package:decaris/kit/game.dart';
import 'package:decaris/kit/piece.dart';
import 'package:flutter/painting.dart';

class Pieces {
  static const Color white = const Color(0xFFFFFFFF);
  static const Color black = const Color(0x000000FF);

  static fill({int cols, int rows, color: white}) => Body(
      cols: cols,
      rows: rows,
      boxes: Iterable.generate(cols * rows)
          .map((_) => Box(color: color))
          .toList());

  static Piece checkers(
          {int cols = 10, int rows = 10, Color w = white, Color b = black}) =>
      Piece()
        ..body = Body(
            cols: cols,
            rows: rows,
            boxes: Iterable.generate(cols * rows)
                .map((i) => Box(
                    color: ((i % 2 == 0 && i ~/ cols % 2 == 0) ||
                            (i % 2 != 0 && i ~/ cols % 2 != 0))
                        ? w
                        : b))
                .toList());

  static Piece horse({color: white, Point<int> offset}) => Piece(
      offset: offset,
      body: Body(cols: 2, rows: 3, boxes: [
        Box.fill(color),
        Box.empty(),
        Box.fill(color),
        Box.empty(),
        Box.fill(color),
        Box.fill(color)
      ]));

  static Piece morse({color: white, Point<int> offset}) => Piece(
      offset: offset,
      body: Body(cols: 2, rows: 3, boxes: [
        Box.fill(color),
        Box.fill(color),
        Box.fill(color),
        Box.empty(),
        Box.fill(color),
        Box.empty()
      ]));

  static Piece ship({color: white, Point<int> offset}) => Piece(
      offset: offset,
      body: Body(cols: 3, rows: 2, boxes: [
        Box.empty(),
        Box.fill(color),
        Box.empty(),
        Box.fill(color),
        Box.fill(color),
        Box.fill(color)
      ]));

  static Piece snake({color: white, Point<int> offset}) => Piece(
      offset: offset,
      body: Body(cols: 3, rows: 2, boxes: [
        Box.fill(color),
        Box.fill(color),
        Box.empty(),
        Box.empty(),
        Box.fill(color),
        Box.fill(color)
      ]));

  static Piece smake({color: white, Point<int> offset}) => Piece(
      offset: offset,
      body: Body(cols: 3, rows: 2, boxes: [
        Box.empty(),
        Box.fill(color),
        Box.fill(color),
        Box.fill(color),
        Box.fill(color),
        Box.empty()
      ]));

  static Piece box({color: white, Point<int> offset}) =>
      Piece(offset: offset, body: fill(cols: 2, rows: 2, color: color));
  static Piece line({color: white, Point<int> offset}) =>
      Piece(offset: offset, body: fill(cols: 4, rows: 1, color: color));

  static Piece board({color, Point<int> offset}) =>
      Piece(offset: offset, body: fill(color: color, cols: 10, rows: 20));
}
