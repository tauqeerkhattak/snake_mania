import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flame/text.dart';

class GameOverComponent extends TextComponent with HasGameRef {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 48.0,
        fontFamily: 'Awesome Font',
      ),
    );
    text = 'Game Over';
    textRenderer = textPaint;
    anchor = Anchor.center;
    position = game.size / 2;
  }
}
