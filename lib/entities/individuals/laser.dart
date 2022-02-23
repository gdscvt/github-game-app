import 'package:github_game/entities/groups/laser_group.dart';
import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/entities/entity.dart';
import 'package:github_game/level.dart';

/// This class represents one laser tile. By default it will have collision.
class Laser extends Entity {
  /// This is the group that this laser belongs to
  late final LaserGroup _group;

  /// This is the id of the lasers layer
  late final int _layerId;

  /// This is the gid of the laser sprite. It will be equal to the sprite at
  /// this lasers location on the 'Lasers' layer
  late final Gid _tileGid;

  /// This is the tile map object
  late final RenderableTiledMap _tiledMap;

  /// Initializes this laser at the given tile position.
  Laser(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _group = parent as LaserGroup;
    _loadLayerData();

    collision = true;
  }

  @override
  void onInteract() {
    _group.deactivate();
  }

  /// Activate this laser. This will add collision and draw the laser sprite.
  void activate() {
    collision = true;
    _tiledMap.setTileData(
        layerId: _layerId, x: tilePosition.x, y: tilePosition.y, gid: _tileGid);
  }

  /// Deactive this laser. This will remove collision and erase the laser
  /// sprite.
  void deactivate() {
    collision = false;
    _tiledMap.setTileData(
        layerId: _layerId,
        x: tilePosition.x,
        y: tilePosition.y,
        gid: const Gid(0, Flips.defaults()));
  }

  /// This will load the data from the 'Lasers' layer in the tile map.
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
