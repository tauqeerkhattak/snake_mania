import 'package:flame/components.dart';

extension Vector2Utils on Vector2 {
  Vector2 minusX(double x) {
    return Vector2(this.x - x, y);
  }

  Vector2 minusY(double y) {
    return Vector2(x, this.y - y);
  }
}
