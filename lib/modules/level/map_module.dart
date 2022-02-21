import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/level.dart';
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';

class MapModule extends Component with HasLevelRef {
  late final TiledComponent tiledComponent;
  late final TiledMap map;

  late final Position dimensions;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    tiledComponent =
        await TiledComponent.load(level.mapPath, GithubGame.TILE_SIZE);

    map = tiledComponent.tileMap.map;

    dimensions = Position(map.width, map.height);

    add(tiledComponent);
  }
}
