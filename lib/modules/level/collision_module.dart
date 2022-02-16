import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';
import '../../level.dart';

class CollisionModule extends Component {
  // Column major collision bit matrix
  late List<bool> collisionMatrix;

  // The tile component for this level
  late TiledComponent tiledComponent;

  CollisionModule(this.tiledComponent);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    TiledMap tileMap = tiledComponent.tileMap.map;

    Layer layer = tileMap.layerByName("Collision");
    int _width = tileMap.width;

    // Hide the collision layer
    tiledComponent.tileMap.setLayerVisibility(layer.id ?? 0, false);

    // Generate a column major list view of the collision matrix
    collisionMatrix = List.generate(tileMap.width * tileMap.height, (index) {
      int col = index % _width;
      int row = ((index - col) / _width).round();

      return tiledComponent.tileMap
              .getTileData(layerId: layer.id ?? 0, x: col, y: row)
              ?.tile !=
          0;
    });
  }

  /*
    Returns whether or not there is collision at the given coordinate
  */
  bool collision(Position tilePosition) {
    return collisionMatrix[
        (tilePosition.y * tiledComponent.tileMap.map.width) + tilePosition.x];
  }
}
