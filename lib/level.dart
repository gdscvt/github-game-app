import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/level/collision_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'dart:ui';
import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'player.dart';

/*
  Represents a position as 2 integers. Useful for tile coordinates.
*/
class Position {
  late int x, y;

  Position(this.x, this.y);
}

/*
  Represents a level with a player and tile map
*/
class Level extends PositionComponent with HasGameRef<GitHubGame> {
  // Reference to the player model
  late final Player player;

  // Reference to the tile map component
  late final TiledComponent tileMapComponent;

  // Reference to the rendered tile map (member of the component)
  late final TiledMap tileMap;

  // Path to the tile map file
  late final String _mapPath;

  // Player starting location
  late final Position playerSpawnLocation;

  // This module loads and reads collision data from the level
  late CollisionModule collisionModule;

  // Set to true once all assets are loaded
  bool _loaded = false;

  Level(this._mapPath, this.playerSpawnLocation);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the tile map and add it to the game
    add(tileMapComponent =
        await TiledComponent.load(_mapPath, gameRef.tileSize));

    // Add the collision module
    add(collisionModule = CollisionModule());

    // Add the player to the level
    add(player = Player(this));

    player.position = getCanvasPosition(playerSpawnLocation);

    // Save a reference to the rendered tile map
    tileMap = tileMapComponent.tileMap.map;

    // Set the loaded flag to true
    _loaded = true;

    // Center the level in the middle of the canvas
    _center(gameRef.canvasSize);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    if (_loaded) {
      // Center the canvas
      _center(gameSize);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  /*
    Centers the level in the middle of the canvas
  */
  void _center(Vector2 canvasSize) {
    position.x = _getMiddle(canvasSize.x, tileMap.width * gameRef.tileSize.x);
    position.y = _getMiddle(canvasSize.y, tileMap.height * gameRef.tileSize.y);
  }

  /*
    Returns the midpoint for a given canvas
  */
  static double _getMiddle(double canvasSize, double width) {
    return (canvasSize / 2) - (width / 2);
  }

  /*
    Returns a converted coordinate vector from tile space to canvas space.
  */
  Vector2 getCanvasPosition(Position tilePosition) {
    return Vector2(tilePosition.x.toDouble(), tilePosition.y.toDouble())
      ..multiply(gameRef.tileSize);
  }
}
