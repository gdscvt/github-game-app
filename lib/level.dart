import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'player.dart';

class Level extends PositionComponent {
  late final Player player;
  late final String mapPath;
  late final Vector2 tileSize;

  late final TiledComponent tileMap;

  bool loaded = false;

  Level(this.player, this.mapPath, this.tileSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    tileMap = await TiledComponent.load(mapPath, tileSize);
    loaded = true;

    add(tileMap);
  }

  @override
  void onGameResize(canvasSize) {
    super.onGameResize(canvasSize);

    if (loaded) {
      // Center the canvas
    }
  }
}
