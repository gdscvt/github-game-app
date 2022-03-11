import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:github_game/level.dart';
import 'package:flame/input.dart';
import 'dart:convert';

/*
  This class represents the game with a specified level
*/
class GithubGame extends FlameGame with HasKeyboardHandlerComponents {
  // The directory holding animation assets
  static const String ANIMATION_FILE_PATH = "animations";

  static const String LEVEL_FILE_PATH = "assets/levels";

  // The size in pixels of each tile
  static final Vector2 TILE_SIZE = Vector2.all(48.0);

  // Reference to the loaded level
  late final Level level;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    String json =
        await rootBundle.loadString("$LEVEL_FILE_PATH/level_one.json");
    add(level = Level.fromJson(jsonDecode(json)));
  }
}
