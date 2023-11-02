import 'package:flame/components.dart';

enum SnakeDirection { up, down, left, right }

enum SnakeBodyType { head, body, tail }

class SnakePosition {
  final SnakeDirection direction;
  final Vector2 position;
  final Sprite bodyPart;
  final SnakeBodyType bodyType;

  const SnakePosition({
    required this.direction,
    required this.position,
    required this.bodyPart,
    required this.bodyType,
  });

  bool get isHead => bodyType == SnakeBodyType.head;

  bool get isTail => bodyType == SnakeBodyType.tail;
}
