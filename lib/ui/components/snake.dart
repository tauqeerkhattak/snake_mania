import 'dart:developer';
import 'dart:math' hide log;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:snake_mania/ui/snake_game.dart';
import 'package:snake_mania/utils/resources.dart';

import '../../models/snake_position.dart';

class Snake extends SpriteAnimationComponent
    with HasGameRef<SnakeGame>, CollisionCallbacks, KeyboardHandler {
  final speed = 100;
  bool hasCollided = false;
  final VoidCallback onCollide;
  List<SnakePosition> snakeParts = [];

  Snake({
    required this.onCollide,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = game.images.fromCache('sheet.png');
    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(snakeSpriteSize, snakeSpriteSize),
    );
    final head1 = sheet.getSprite(0, 0);
    final head2 = sheet.getSprite(1, 0);
    final head3 = sheet.getSprite(2, 0);

    animation = SpriteAnimation.spriteList(
      [
        head3,
        head2,
        head1,
        head2,
        head3,
      ],
      stepTime: 0.25,
    );
    add(
      SpriteComponent(
        sprite: sheet.getSprite(2, 2),
        position: Vector2(0, -snakeSize),
        size: Vector2(snakeSize, snakeSize),
      ),
    );
    add(
      SpriteComponent(
        sprite: sheet.getSprite(2, 1),
        position: Vector2(snakeSize, -snakeSize),
        angle: pi,
        size: Vector2(snakeSize, snakeSize),
      ),
    );
    angle = -pi / 2;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!hasCollided) {
      position = Vector2(
        position.x + (dt * speed),
        position.y,
      );
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      if (!hasCollided) {
        log('Game should stop here!');
        hasCollided = true;
        onCollide();
        animation = null;
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      log('DOWN');
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      log('UP');
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      log('LEFT');
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      log('RIGHT');
    }
    return true;
  }
}
