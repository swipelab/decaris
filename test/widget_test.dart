import 'package:decaris/kit/pieces.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('piece.rotate.left', () {
    final h = Pieces.morse();
    final h1 = h.rotateLeft();
    final h2 = h1.rotateLeft();
    final h3 = h2.rotateLeft();
    final h4 = h3.rotateLeft();
    print(h);
    print(h1);
    print(h2);
    print(h3);
    print(h4);
  });

  test('piece.rotate.right', () {
    final h = Pieces.morse();
    final c4 = h.rotateRight();
    final c3 = c4.rotateRight();
    final c2 = c3.rotateRight();
    final c1 = c2.rotateRight();
    print(h);
    print(c4);
    print(c3);
    print(c2);
    print(c1);
  });
}
