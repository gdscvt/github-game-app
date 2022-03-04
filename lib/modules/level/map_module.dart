import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/modules/level/map/collision_module.dart';
import 'package:github_game/modules/level/map/entity_manager_module.dart';

/// This module is responsible for the tile map in a level.
class MapModule extends Component with HasLevelRef {
  /// The tile map component
  late final TiledComponent _tiledComponent;

  /// The tile map itself
  late final TiledMap _map;

  /// Loads and manages the tile map
  late final MapModule _mapModule;

  /// Loads and manages collision data
  late final CollisionModule _collisionModule;

  /// Loads and manages the entities
  late final EntityManagerModule _entityManagerModule;

  /// The dimensions of the map in tile coordinates
  late final Position _dimensions;

  /// Returns the tiled map component.
  TiledComponent get tiledComponent => _tiledComponent;

  /// Returns the tiled map object.
  TiledMap get map => _map;

  /// Returns the map module which is responsible for the tile map data.
  MapModule get mapModule => _mapModule;

  /// Returns the collision module which is responsible for all collision data.
  CollisionModule get collisionModule => _collisionModule;

  /// Returns the entity manager module which handles all entities in the level.
  EntityManagerModule get entityManagerModule => _entityManagerModule;

  /// Returns the dimensions of this level.
  Position get dimensions => _dimensions;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the map
    _tiledComponent =
        await TiledComponent.load(level.mapPath, GithubGame.TILE_SIZE);

    _map = _tiledComponent.tileMap.map;

    _dimensions = Position(_map.width, _map.height);

    // Add the map to the level
    add(_tiledComponent);

    // Add the collision and entity manager modules
    add(_collisionModule = CollisionModule());
    add(_entityManagerModule = EntityManagerModule());
  }
}
