import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/level.dart';
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';

class MapModule extends Component with HasLevelRef {
  late final TiledComponent tiledComponent; // the tile map component
  late final TiledMap map; // the tile map itself

  late final Position
      dimensions; // the dimensions of the map in tile coordinates

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // load the map
    tiledComponent =
        await TiledComponent.load(level.mapPath, GithubGame.TILE_SIZE);

    map = tiledComponent.tileMap.map;

    dimensions = Position(map.width, map.height);

    add(tiledComponent); // add the map to the level
  }
}
