import 'package:flame/components.dart';
import 'package:python_game/entities/entity_group.dart';
import 'package:python_game/python_game.dart';
import 'package:python_game/modules/player_module.dart';
import 'package:python_game/modules/level/map_module.dart';
import 'package:python_game/modules/level/entity_manager_module.dart';
import 'package:quiver/core.dart';

/// Represents a position as 2 integers. Useful for tile coordinates.
class Position {
  late int x, y;

  Position(this.x, this.y);

  bool operator ==(o) => o is Position && x == o.x && y == o.y;
  int get hashCode => hash2(x.hashCode, y.hashCode);

  String toString() => "$x, $y";
}

/// This is used to load levels from json files.
extension _LevelLoader on Level {
  /// This function loads the data into the level from the json file.
  void _loadJson(Map<String, dynamic> json) {
    String title = json["title"];
    String mapPath = json["mapPath"];
    Map<String, dynamic> spawnPosMap = json["spawnLocation"];
    List<dynamic> entityGroups = json["entityGroups"];

    _title = title;
    _mapModule = MapModule.fromFile(mapPath);
    _spawnLocation = Position(spawnPosMap["x"], spawnPosMap["y"]);

    _entityManagerModule = EntityManagerModule(
        entityGroups.map((groupJson) => EntityGroup.fromJson(groupJson)));
  }
}

/// Represents a level with a player and tile map.
class Level extends Component with HasGameRef<PythonGame> {
  /// Title of the level
  late final String _title;

  /// Reference to the player
  late final PlayerModule _player;

  /// Loads and manages the tile map
  late final MapModule _mapModule;

  /// Loads and manages the entities
  late final EntityManagerModule _entityManagerModule;

  /// Player spawn location
  late final Position _spawnLocation;

  /// Initializes the level.
  Level.fromJson(Map<String, dynamic> json) {
    _loadJson(json);
  }

  /// Returns a reference to the title string.
  String get title => _title;

  /// Returns a reference to the player.
  PlayerModule get player => _player;

  /// Returns a reference to the map module.
  MapModule get mapModule => _mapModule;

  /// Returns the entity manager module which handles all entities in the level.
  EntityManagerModule get entityManagerModule => _entityManagerModule;

  /// Returns the player spawn location.
  Position get spawnLocation => _spawnLocation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(_mapModule);
    add(_entityManagerModule);
    add(_player = PlayerModule());

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
      ..multiply(PythonGame.TILE_SIZE);
  }
}
