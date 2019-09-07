import 'package:decaris/kit/game_action.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final GameActionDelegate onAction;

  ControlPanel({this.onAction});

  Function emitAction(GameAction action) {
    return onAction != null ? () => onAction(action) : null;
  }

  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            MaterialButton(
                child: Icon(Icons.rotate_left),
                onPressed: emitAction(GameAction.rotateLeft)),
            MaterialButton(
                child: Icon(Icons.keyboard_arrow_left),
                onPressed: emitAction(GameAction.moveLeft)),
          ],
        ),
        Column(
          children: <Widget>[
            MaterialButton(
                child: Icon(Icons.blur_circular), onPressed: emitAction(GameAction.reset)),
            MaterialButton(
                child: Icon(Icons.keyboard_arrow_down), onPressed: emitAction(GameAction.moveDown)),
          ],
        ),
        Column(
          children: <Widget>[
            MaterialButton(
                child: Icon(Icons.rotate_right),
                onPressed: emitAction(GameAction.rotateRight)),
            MaterialButton(
                child: Icon(Icons.keyboard_arrow_right),
                onPressed: emitAction(GameAction.moveRight)),
          ],
        ),
      ],
    ));
  }
}
