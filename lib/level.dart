import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/main.dart';
import 'package:github_game/modules/player_module.dart';
import 'package:github_game/modules/level/map_module.dart';
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
  late final PlayerModule _player;

  /// Loads and manages the tile map
  late final MapModule _mapModule;

  /// Path to the map file
  late String _mapPath;

  /// Player spawn location
  late final Position _spawnLocation;

  /// Old map Path
  late String oldMapPath;

  /// Initializes the level with the map path and spawn location.
  Level(this._mapPath, this._spawnLocation);
  set mapPath(String newPath){
    _mapPath = newPath;
  }
  /// Returns a reference to the player.
  PlayerModule get player => _player;

  /// Returns a reference to the map module.
  MapModule get mapModule => _mapModule;

  /// Returns the path to the map file.
  String get mapPath => _mapPath;

  /// Returns the player spawn location.
  Position get spawnLocation => _spawnLocation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(_mapModule = MapModule());
    /// If not main menu(Position for main menu set to (-1, -1))
    // if(this._spawnLocation.x != -1 && this._spawnLocation.y != -1) {
      await add(_player = PlayerModule());

      // Teleport the player to their spawn location
      teleport(_player.position, _spawnLocation);

      // Make the camera follow the player
      gameRef.camera.followComponent(_player, relativeOffset: Anchor.center);
      gameRef.camera.zoom = 0.8;
    //}
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
