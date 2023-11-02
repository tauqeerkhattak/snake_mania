import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:snake_mania/ui/components/game_over_component.dart';
import 'package:snake_mania/ui/components/snake.dart';
import 'package:snake_mania/utils/resources.dart';

class SnakeGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Vector2 position;

  void _onCollision() {
    add(GameOverComponent());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.loadAll([
      'sheet.png',
    ]);
    position = size / 2;
    final snake = Snake(
      onCollide: _onCollision,
    );
    snake.position = position;
    snake.size = Vector2(snakeSize, snakeSize);
    add(snake);
    add(
      ScreenHitbox(),
    );
  }
}
