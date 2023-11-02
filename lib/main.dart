import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:snake_mania/ui/snake_game.dart';

void main() {
  runApp(
    GameWidget(
      game: SnakeGame(),
    ),
  );
}
