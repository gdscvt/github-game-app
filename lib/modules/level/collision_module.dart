import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';
import 'package:github_game/level.dart';
import 'dart:collection';

/*
  This collision module transforms the tile matrix into a column major array, 
  with one bit representing the collision of each tile.
*/
class CollisionModule extends Component {
  // Hash set of collidable positions
  late HashSet<Position> collisionSet = HashSet();

  // The tile component for this level
  late final TiledComponent _tiledComponent;

  CollisionModule(this._tiledComponent);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    TiledMap tileMap = _tiledComponent.tileMap.map;

    Layer layer = tileMap.layerByName("Collision");

    // Hide the collision layer
    _tiledComponent.tileMap.setLayerVisibility(layer.id ?? 0, false);

    // Populate the collision hash set based on the collision layer
    for (int x = 0; x < tileMap.width; x++) {
      for (int y = 0; y < tileMap.height; y++) {
        if (_tiledComponent.tileMap
                .getTileData(layerId: layer.id ?? 0, x: x, y: y)
                ?.tile !=
            0) {
          collisionSet.add(Position(x, y));
        }
      }
    }
  }

  /*
    Returns whether or not there is collision at the given coordinate
  */
  bool collision(Position tilePosition) {
    return collisionSet.contains(tilePosition);
  }

  /*
    Sets the collision of a given tile position 
  */
  void setCollision(Position tilePosition, bool coll) {
    if (coll) {
      collisionSet.add(tilePosition);
    } else {
      collisionSet.remove(tilePosition);
    }
  }
}
