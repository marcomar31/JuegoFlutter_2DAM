import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<FlameGame>, KeyboardHandler {
  int horizontalDirection = 0;
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;

  bool isJumping = false;
  double jumpVelocity = 0.0;
  double groundY = 0.0;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection = 1;
      scale.x = 1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection = -1;
      scale.x = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && !isJumping) {
      startJump();
    }

    return true;
  }

  void startJump() {
    isJumping = true;
    jumpVelocity = 500.0;
    groundY = position.y;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    position += velocidad * dt;

    if (isJumping) {
      position.y -= jumpVelocity * dt;
      jumpVelocity -= 1000.0 * dt;

      if (position.y >= groundY) {
        isJumping = false;
        position.y = groundY;
      }
    }

    super.update(dt);
  }
}
