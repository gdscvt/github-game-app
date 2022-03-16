import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:python_game/python_game.dart';

void main() {
  final game = PythonGame();

  runApp(GameWidget(game: game));
}
