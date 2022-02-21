import 'package:flame/game.dart';
import 'package:github_game/level.dart';
import 'package:flame/input.dart';

/*
  This class represents the game with a specified level
*/
class GithubGame extends FlameGame with HasKeyboardHandlerComponents {
  // The directory holding animation assets
  static const String ANIMATION_FILE_PATH = "animations";

  // The size in pixels of each tile
  static final Vector2 TILE_SIZE = Vector2.all(48.0);

  // Reference to the loaded level
  late final Level level;

  // The file path to the tile map
  late final String _mapPath;

  GithubGame(this._mapPath);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(level = Level(_mapPath, Position(5, 5)));
  }
}
