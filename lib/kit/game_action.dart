enum GameAction { moveLeft, moveRight, moveDown, rotateLeft, rotateRight, reset, frame }
typedef GameActionDelegate = Function(GameAction action);
