import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';
import 'package:github_game/level.dart';

/*
  This collision module transforms the tile matrix into a column major array, 
  with one bit representing the collision of each tile.
*/
class CollisionModule extends Component {
  // Column major collision bit matrix
  late List<bool> _collisionMatrix;

  // The tile component for this level
  late final TiledComponent _tiledComponent;

  CollisionModule(this._tiledComponent);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    TiledMap tileMap = _tiledComponent.tileMap.map;

    Layer layer = tileMap.layerByName("Collision");
    int _width = tileMap.width;

    // Hide the collision layer
    _tiledComponent.tileMap.setLayerVisibility(layer.id ?? 0, false);

    // Generate a column major list view of the collision matrix
    _collisionMatrix = List.generate(tileMap.width * tileMap.height, (index) {
      int col = index % _width;
      int row = ((index - col) / _width).round();

      return _tiledComponent.tileMap
              .getTileData(layerId: layer.id ?? 0, x: col, y: row)
              ?.tile !=
          0;
    });
  }

  /*
    Returns whether or not there is collision at the given coordinate
  */
  bool collision(Position tilePosition) {
    return _collisionMatrix[
        (tilePosition.y * _tiledComponent.tileMap.map.width) + tilePosition.x];
  }

  /*
    Sets the collision of a given tile position 
  */
  void setCollision(Position tilePosition, bool coll) {
    _collisionMatrix[(tilePosition.y * _tiledComponent.tileMap.map.width) +
        tilePosition.x] = coll;
  }
}
