// ignore_for_file: slash_for_doc_comments
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/modules/level/map_module.dart';
import 'package:github_game/mixins/has_level_ref.dart';

/**
 * This module queries the collision channel in the level file. In order for 
 * this to function properly, the tile layer id's need to be in order starting 
 * from 0.
 */
class CollisionModule extends Component with HasLevelRef {
  /// Returns whether or not there is collision at the given coordinate.
  bool getCollision(Position tilePosition) {
    final MapModule mapModule = level.mapModule;
    return mapModule.tiledComponent.tileMap
            .getTileData(
                layerId: mapModule.map.layerByName("Collision").id ?? 0,
                x: tilePosition.x,
                y: tilePosition.y)
            ?.tile !=
        0;
  }

  /// Sets the collision of a given tile position.
  void setCollision(Position tilePosition, bool coll) {
    final MapModule mapModule = level.mapModule;
    mapModule.tiledComponent.tileMap.setTileData(
        layerId: mapModule.map.layerByName("Collision").id ?? 0,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: const Gid(1, Flips.defaults()));
  }
}
