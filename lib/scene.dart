import 'package:decaris/kit/control_panel.dart';
import 'package:decaris/kit/game.dart';
import 'package:flutter/material.dart';
import 'package:scoped/scoped.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scope(
      store: Store()..add(Game()),
      child: Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Bond<Game>(
              builder: (context, game) => CustomPaint(
                painter: PiecePainter(pieces: game.pieces),
              ),
            )),
            Bond<Game>(
              builder: (context, game) => ControlPanel(
                onAction: game.dispatch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PiecePainter extends CustomPainter {
  final List<Piece> pieces;

  PiecePainter({this.pieces = const []});

  void paint(Canvas canvas, Size size) {
    if (pieces == null) return;

    final boxSize = Size(24, 24);

    canvas.translate(64, 20);

    pieces.forEach((p) {
      final piece = p.body;
      for (int y = 0; y < piece.rows; y++) {
        for (int x = 0; x < piece.cols; x++) {
          final i = x + y * piece.cols;
          final box = piece.boxes[i];
          final a = Offset((x + p.offset.x) * boxSize.width,
              (y + p.offset.y) * boxSize.height);
          final b = a + Offset(boxSize.width, boxSize.height);
          canvas.drawRect(
              Rect.fromPoints(a, b).inflate(-1),
              box.color == null
                  ? (Paint()
                    ..color = Colors.black
                    ..style = PaintingStyle.stroke)
                  : (Paint()..color = box.color));
        }
      }
    });

    // canvas.drawRect(
    //     Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), redFill);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
