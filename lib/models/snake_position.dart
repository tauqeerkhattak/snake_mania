import 'package:flame/components.dart';

enum SnakeDirection { up, down, left, right }

class SnakePosition {
  final SnakeDirection direction;
  final Vector2 position;
  final Sprite bodyPart;

  const SnakePosition({
    required this.direction,
    required this.position,
    required this.bodyPart,
  });
}
