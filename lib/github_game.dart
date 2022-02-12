import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class GitHubGame extends FlameGame {
  late final TiledComponent map;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Do game start logic

    map = await TiledComponent.load("level_one.tmx", Vector2.all(32.0));

    add(map);
  }
}
