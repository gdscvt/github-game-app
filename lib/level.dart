import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/map_module.dart';
import 'package:github_game/modules/level/collision_module.dart';
import 'package:tiled/tiled.dart';
import 'package:quiver/core.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/player.dart';
import 'package:github_game/entities/laser.dart';
import 'dart:collection';
import 'package:github_game/entity.dart';

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
  Represents a level with a player and tile map
*/
class Level extends PositionComponent with HasGameRef<GithubGame> {
  // Reference to the player model
  late final Player player;

  late final MapModule mapModule;

  // Path to the tile map file
  late final String mapPath;

  // Player starting location
  late final Position spawnLocation;

  // This module loads and reads collision data from the level
  late CollisionModule collisionModule;

  // This is a set of all the entities in the level
  HashSet<Entity> entities = HashSet();

  Level(this.mapPath, this.spawnLocation);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the tile map and add it to the game
    add(mapModule = MapModule());

    // Add the collision module
    add(collisionModule = CollisionModule());

    // Add the player to the level
    add(player = Player());
    teleport(player.position, spawnLocation);

    // Make the camera follow the player
    gameRef.camera.followComponent(player, relativeOffset: Anchor.center);
    gameRef.camera.zoom = 0.8;
  }

  /*
    Used to transform a vector position to a given tile position
  */
  void teleport(Vector2 from, Position to) {
    Vector2 pos = getCanvasPosition(to);
    from.x = pos.x;
    from.y = pos.y;
  }

  /*
    Returns a converted coordinate vector from tile space to canvas space.
  */
  Vector2 getCanvasPosition(Position tilePosition) {
    return Vector2(tilePosition.x.toDouble(), tilePosition.y.toDouble())
      ..multiply(GithubGame.TILE_SIZE);
  }
}
