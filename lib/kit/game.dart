import 'dart:async';
import 'dart:math';

import 'package:decaris/kit/game_action.dart';
import 'package:decaris/kit/piece.dart';
import 'package:decaris/kit/pieces.dart';
import 'package:flutter/material.dart';
import 'package:scoped/scoped.dart';

class Piece {
  Point<int> offset;
  Body body;
  Piece({this.body, Point<int> offset})
      : assert(body != null),
        offset = offset ?? const Point<int>(0, 0);

  Piece rotateLeft() => Piece(body: body.rotateLeft(), offset: offset);
  Piece rotateRight() => Piece(body: body.rotateRight(), offset: offset);
  Piece move(Point<int> delta) => Piece(body: body, offset: offset + delta);
  Piece paint(Color color) => Piece(body: body.paint(color), offset: offset);

  bool intersects(Piece other) {
    if (other == null) return false;
    for (int y = 0; y < body.rows; y++) {
      for (int x = 0; x < body.cols; x++) {
        if (body.hitAt(x, y) && other.hitAt(x + offset.x, y + offset.y))
          return true;
      }
    }
    return false;
  }

  hitAt(int x, int y) {
    if (x < offset.x ||
        x > offset.x + body.cols ||
        y < offset.y ||
        y > offset.y + body.rows) return false;
    return body.hitAt(x - offset.x, y - offset.y);
  }
}

class Game extends Fluid {
  Game() {
    Timer.periodic(Duration(milliseconds: 1000), handleGameTick);
  }

  int value = 0;
  void handleGameTick(Timer timer) {
    dispatch(GameAction.frame);
  }

  final Piece scene = Pieces.board();
  Piece active;

  static defaultPieces() {
    return [
      Pieces.ship(color: Colors.black, offset: Point(5, 18)),
      Pieces.ship(color: Colors.black, offset: Point(3, 17)).rotateLeft(),
      Pieces.ship(color: Colors.black, offset: Point(8, 17)).rotateRight(),
      Pieces.ship(color: Colors.black, offset: Point(1, 18)),
    ];
  }

  List<Piece> other = defaultPieces();

  List<Piece> get pieces => [scene, if (active != null) active, ...other];

  dispatch(GameAction action) {
    switch (action) {
      case GameAction.frame:
        _onFrame();
        break;
      case GameAction.reset:
        _onReset();
        break;
      case GameAction.moveLeft:
        _onMoveLeft();
        break;
      case GameAction.moveRight:
        _onMoveRight();
        break;
      case GameAction.moveDown:
        _onMoveDown();
        break;
      case GameAction.rotateLeft:
        _onRotateLeft();
        break;
      case GameAction.rotateRight:
        _onRotateRight();
        break;
      default:
        break;
    }

    notify();
  }

  _onFrame() {
    if (active != null) {
      active = active.move(Point(0, 1));
      if (active.intersects(scene)) {
        active = active.paint(Colors.black);
      } else {
        active = active.paint(Colors.white);
      }
    }
  }

  _onReset() {
    active = Pieces.horse(offset: Point(2, 3));
    other = defaultPieces();
  }

  _onMoveLeft() {
    if (active == null) return;
    active = active.move(Point(-1, 0));
  }

  _onMoveRight() {
    if (active == null) return;
    active = active.move(Point(1, 0));
  }

  _onMoveDown() {
    if (active == null) return;
    active = active.move(Point(0, 1));
  }

  _onRotateLeft() {
    if (active == null) return;
    active = active.rotateLeft();
  }

  _onRotateRight() {
    if (active == null) return;
    active = active.rotateRight();
  }
}
