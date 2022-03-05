// ignore_for_file: slash_for_doc_comments
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/mixins/has_map_ref.dart';

/// This module queries the collision channel in the level file. In order for
/// this to function properly, the tile layer id's need to be in order starting
/// from 0.
class CollisionModule extends Component with HasMapRef {
  /// This is the layer id of the collision layer
  late final int _layerId;

  /// This is the tile map object that the collision module reads and writes to
  late final RenderableTiledMap _tileMap;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the collision layer id
    _layerId = mapModule.map.layerByName("Collision").id ??
        () {
          throw StateError(
              "This tile map does not have a layer titled 'Collision'");
        }.call();
    _tileMap = mapModule.tiledComponent.tileMap;
  }

  /// Returns whether or not there is collision at the given coordinate.
  bool getCollision(Position tilePosition) {
    return _tileMap
            .getTileData(
                layerId: _layerId, x: tilePosition.x, y: tilePosition.y)
            ?.tile !=
        0;
  }

  /// Sets the collision of a given tile position.
  void setCollision(Position tilePosition, bool coll) {
    _tileMap.setTileData(
        layerId: _layerId,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: Gid(
            () {
              if (coll) return 1;
              return 0;
            }.call(),
            const Flips.defaults()));
  }
}
