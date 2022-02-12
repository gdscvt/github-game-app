import 'dart:ui';
import 'package:flame/game.dart';
import 'level.dart';
import 'player.dart';
import 'package:flutter/material.dart';

class GitHubGame extends FlameGame {
  late final Level level;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    level = Level(Player(), "level_one.tmx", Vector2.all(32.0));
    add(level);
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
