import 'package:flame/components.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:tiled/tiled.dart';
import 'package:github_game/level.dart';
import 'package:github_game/modules/level/map_module.dart';

/*
  This collision module transforms the tile matrix into a column major array, 
  with one bit representing the collision of each tile.
*/
class CollisionModule extends Component with HasLevelRef {
  /*
    Returns whether or not there is collision at the given coordinate
  */
  bool getCollision(Position tilePosition) {
    MapModule mapModule = level.mapModule;
    return mapModule.tiledComponent.tileMap
            .getTileData(
                layerId: mapModule.map.layerByName("Collision").id ?? 0,
                x: tilePosition.x,
                y: tilePosition.y)
            ?.tile !=
        0;
  }

  /*
    Sets the collision of a given tile position 
  */
  void setCollision(Position tilePosition, bool coll) {
    MapModule mapModule = level.mapModule;
    mapModule.tiledComponent.tileMap.setTileData(
        layerId: mapModule.map.layerByName("Collision").id ?? 0,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: const Gid(1, Flips.defaults()));
  }
}
