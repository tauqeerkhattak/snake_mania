import 'dart:developer' as dev;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter/services.dart';
import 'package:snake_mania/ui/components/game_over_component.dart';
import 'package:snake_mania/ui/components/snake.dart';
import 'package:snake_mania/utils/resources.dart';
import 'package:snake_mania/utils/vector2_utils.dart';

class SnakeGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef {
  late Snake snakeHead;
  late Snake snakeBody;
  late Snake snakeTail;

  // SnakeDirection headDirection = SnakeDirection.down;
  // SnakeDirection bodyDirection = SnakeDirection.down;
  // SnakeDirection tailDirection = SnakeDirection.down;
  //
  // int counter = -10;
  final speed = 50;

  void _onCollision() {
    add(GameOverComponent());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final position = size / 2;
    final image = await images.load('sheet.png');
    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(snakeSpriteSize, snakeSpriteSize),
    );
    final snakeBodySize = Vector2(snakeSize, snakeSize);
    snakeHead = Snake(
      onCollide: _onCollision,
      sprite: sheet.getSprite(0, 0),
    );
    snakeBody = Snake(sprite: sheet.getSprite(2, 2));
    snakeTail = Snake(sprite: sheet.getSprite(2, 1));

    snakeHead.position = position;
    snakeBody.position = position.minusY(snakeSize);
    snakeTail.position = position.minusY(snakeSize + snakeSize);

    snakeHead.size = snakeBodySize;
    snakeBody.size = snakeBodySize;
    snakeTail.size = snakeBodySize;
    snakeTail.flipVerticallyAroundCenter();

    add(snakeHead);
    add(snakeBody);
    add(snakeTail);
    add(
      ScreenHitbox(),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    changeSnakePosition(dt);
  }

  void changeSnakePosition(double dt) {
    final newSpeed = -dt * speed;
    final newPosition = snakeHead.position.minusY(newSpeed);
    snakeHead.position = newPosition;
    snakeBody.position = snakeBody.position.minusY(newSpeed);
    snakeTail.position = snakeTail.position.minusY(newSpeed);

    // if (counter == 0) {
    //   bodyDirection = headDirection
    // }
    //
    // if (counter > 2) {
    //   counter = -10;
    // }
    // else {
    //   counter++;
    // }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      dev.log('hehe');
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      dev.log('Arrow Left');
      camera.viewfinder.angle = -pi;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {}
    return super.onKeyEvent(event, keysPressed);
  }
}
