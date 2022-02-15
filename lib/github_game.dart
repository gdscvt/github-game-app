import 'dart:ui';
import 'package:flame/game.dart';
import 'level.dart';
import 'package:flutter/material.dart';

/*
  This class represents the game with a specified level
*/
class GitHubGame extends FlameGame {
  // Reference to the loaded level
  late final Level level;

  // The size in pixels of each tile
  late final Vector2 tileSize;

  // The file path to the tile map
  late final String _mapPath;

  GitHubGame(this._mapPath, this.tileSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(level = Level(_mapPath, Vector2.all(5)));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onGameResize(canvasSize) {
    super.onGameResize(canvasSize);
  }
}
