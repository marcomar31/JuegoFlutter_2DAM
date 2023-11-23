import 'package:flame/components.dart';
import 'package:juego_flutter/games/MyGame.dart';

class Estrella extends SpriteComponent with HasGameRef<MyGame>{


  Estrella({required super.position,required super.size});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite=Sprite(game.images.fromCache('star.png'));
    anchor=Anchor.center;
    return super.onLoad();
  }
}