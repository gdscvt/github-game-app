import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';
import '../../level.dart';
import 'package:github_game/github_game.dart';

class CollisionModule extends Component with HasGameRef<GitHubGame> {
  // Column major collision bit matrix
  late List<bool> collisionMatrix;

  // Width of the tile map
  late int width;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Level level = gameRef.level;
    TiledMap tileMap = level.tileMap;
    Layer layer = tileMap.layerByName("Collision");
    width = tileMap.width;

    // Hide the collision layer
    level.tileMapComponent.tileMap.setLayerVisibility(layer.id ?? 0, false);

    // Generate a column major list view of the collision matrix
    collisionMatrix = List.generate(tileMap.width * tileMap.height, (index) {
      int col = index % width;
      int row = ((index - col) / width).round();

      return level.tileMapComponent.tileMap
              .getTileData(layerId: layer.id ?? 0, x: col, y: row)
              ?.tile !=
          0;
    });
  }

  /*
    Returns whether or not there is collision at the given coordinate
  */
  bool collision(Position tilePosition) {
    return collisionMatrix[(tilePosition.y * width) + tilePosition.x];
  }
}
