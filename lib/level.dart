import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/level/entity_manager_module.dart';
import 'package:github_game/player.dart';
import 'package:github_game/modules/level/map_module.dart';
import 'package:github_game/modules/level/collision_module.dart';
import 'package:quiver/core.dart';

/// Represents a position as 2 integers. Useful for tile coordinates.
class Position {
  late int x, y;

  Position(this.x, this.y);

  bool operator ==(o) => o is Position && x == o.x && y == o.y;
  int get hashCode => hash2(x.hashCode, y.hashCode);

  String toString() => "$x, $y";
}

/// Represents a level with a player and tile map.
class Level extends Component with HasGameRef<GithubGame> {
  /// Reference to the player
  late final Player _player;

  /// Loads and manages the tile map
  late final MapModule _mapModule;

  /// Loads and manages collision data
  late final CollisionModule _collisionModule;

  /// Loads and manages the entities
  late final EntityManagerModule _entityManagerModule;

  /// Path to the map file
  late final String _mapPath;

  /// Player spawn location
  late final Position _spawnLocation;

  /// Initializes the level with the map path and spawn location.
  Level(this._mapPath, this._spawnLocation);

  /// Returns a reference to the player.
  Player get player => _player;

  /// Returns the map module which is responsible for the tile map data.
  MapModule get mapModule => _mapModule;

  /// Returns the collision module which is responsible for all collision data.
  CollisionModule get collisionModule => _collisionModule;

  /// Returns the entity manager module which handles all entities in the level.
  EntityManagerModule get entityManagerModule => _entityManagerModule;

  /// Returns the path to the map file.
  String get mapPath => _mapPath;

  /// Returns the player spawn location.
  Position get spawnLocation => _spawnLocation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(_mapModule = MapModule());
    add(_collisionModule = CollisionModule());
    add(_entityManagerModule = EntityManagerModule());

    add(_player = Player());

    // Teleport the player to their spawn location
    teleport(_player.position, _spawnLocation);

    // Make the camera follow the player
    gameRef.camera.followComponent(_player, relativeOffset: Anchor.center);
    gameRef.camera.zoom = 0.8;
  }

  /// Used to teleport a vector position to a given tile position.
  void teleport(Vector2 from, Position to) {
    Vector2 pos = getCanvasPosition(to);
    from.x = pos.x;
    from.y = pos.y;
  }

  /// Returns a vector converted from tile coordinates to canvas coordinates.
  Vector2 getCanvasPosition(Position tilePosition) {
    return Vector2(tilePosition.x.toDouble(), tilePosition.y.toDouble())
      ..multiply(GithubGame.TILE_SIZE);
  }
}
