import 'dart:collection';
import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/level/entity_manager_module.dart';
import 'package:github_game/player.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/modules/level/map_module.dart';
import 'package:github_game/modules/level/collision_module.dart';
import 'package:quiver/core.dart';

/*
  Represents a position as 2 integers. Useful for tile coordinates.
*/
class Position {
  late int x, y;

  Position(this.x, this.y);

  bool operator ==(o) => o is Position && x == o.x && y == o.y;
  int get hashCode => hash2(x.hashCode, y.hashCode);

  String toString() => "$x, $y";
}

/*
  Represents a level with a player and tile map.
*/
class Level extends PositionComponent with HasGameRef<GithubGame> {
  late final Player player; // reference to the player
  late final MapModule mapModule; // loads and manages the tile map
  late final CollisionModule
      collisionModule; // loads and manages collision data
  late final EntityManagerModule
      entityManagerModule; // loads and manages the entities

  late final String mapPath; // path to the map file
  late final Position spawnLocation; // spawn location for the player

  Level(this.mapPath, this.spawnLocation);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(mapModule = MapModule());
    add(collisionModule = CollisionModule());
    add(entityManagerModule = EntityManagerModule());

    add(player = Player());
    teleport(player.position,
        spawnLocation); // send the player to the spawn location

    // Make the camera follow the player
    gameRef.camera.followComponent(player, relativeOffset: Anchor.center);
    gameRef.camera.zoom = 0.8;
  }

  /*
    Used to transform a vector position to a given tile position.
  */
  void teleport(Vector2 from, Position to) {
    Vector2 pos = getCanvasPosition(to);
    from.x = pos.x;
    from.y = pos.y;
  }

  /*
    Returns a vector converted from tile coordinates to canvas coordinates.
  */
  Vector2 getCanvasPosition(Position tilePosition) {
    return Vector2(tilePosition.x.toDouble(), tilePosition.y.toDouble())
      ..multiply(GithubGame.TILE_SIZE);
  }
}
