import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../players/EmberPlayer.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {

  final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayer _ember;
  late TiledComponent mapComponent;



  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'reading.png',
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.center; // Anclaje al centro
    addAll([cameraComponent, world]); // Agrega primero la cámara al juego y luego el mundo

    mapComponent = await TiledComponent.load('mapa2.tmx', Vector2.all(32));
    world.add(mapComponent);

    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for (final estrella in estrellas!.objects) {
      Estrella spriteStar = Estrella(
          position: Vector2(estrella.x, estrella.y),
          size: Vector2.all(64));
      world.add(spriteStar); // Agrega las estrellas al mundo
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(
          position: Vector2(gota.x,gota.y),
          size: Vector2.all(64));
      world.add(spriteGota); // Agrega las gotas al mundo
    }

    _ember = EmberPlayer(
      position: Vector2(canvasSize.x / 2, canvasSize.y / 2),
    );
    world.add(_ember);

    cameraComponent.follow(_ember);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}