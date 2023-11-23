import 'package:flame/components.dart';
import 'package:juego_flutter/games/MyGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<MyGame> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2(170, 300), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('reading.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        amountPerRow: 5,
        textureSize: Vector2(60, 88),
        stepTime: 0.12,
      ),
    );
  }
}