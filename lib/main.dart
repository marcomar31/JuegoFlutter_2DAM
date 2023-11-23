import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:juego_flutter/games/MyGame.dart';

void main() {
  runApp(
    const GameWidget<MyGame>.controlled(
      gameFactory: MyGame.new,
    ),
  );
}