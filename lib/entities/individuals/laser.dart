import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/level.dart';

class Laser extends Entity {
  late final int _layerId;
  late final Gid _tileGid;
  late final RenderableTiledMap _tiledMap;

  Laser(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _loadLayerData();

    collision = true;
  }

  @override
  void onInteract() {
    print("Interacted with laser at ($tilePosition)");
  }

  void _loadLayerData() {
    _layerId = mapModule.map.layerByName("Lasers").id ??
        () {
          throw StateError(
              "This tile map does not have a layer titled 'Lasers'");
        }.call();

    _tiledMap = mapModule.tiledComponent.tileMap;
    _tileGid = _tiledMap.getTileData(
            layerId: _layerId, x: tilePosition.x, y: tilePosition.y) ??
        () {
          throw StateError(
              "There is no sprite at position $tilePosition on the layer titled 'Lasers'");
        }.call();
  }
}
