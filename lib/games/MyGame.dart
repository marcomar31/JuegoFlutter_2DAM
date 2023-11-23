import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../players/EmberPlayer.dart';
import '../elementos/Estrella.dart';

class MyGame extends FlameGame {
  MyGame();

  late EmberPlayer _ember;
  double objectSpeed = 0.0;

  @override
  final world = World();
  late final CameraComponent cameraComponent;
  late TiledComponent mapComponent;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'reading.png',
      //'nature-platformer-tileset-16x16.png'
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa.tmx', Vector2.all(16));
    world.add(mapComponent);

    /*
    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for (final estrella in estrellas!.objects) {
      Estrella spriteEstrella = Estrella(position: Vector2(estrella.x, estrella.y),
          size: Vector2.all(64));
      add(spriteEstrella);
    }
    */

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 300),
    );

    world.add(_ember);


  }
}