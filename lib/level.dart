import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/level/collision_module.dart';
import 'package:tiled/tiled.dart';
import 'package:quiver/core.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:github_game/player.dart';
import 'package:github_game/entities/laser.dart';

/*
  Represents a position as 2 integers. Useful for tile coordinates.
*/
class Position {
  late int x, y;

  Position(this.x, this.y);

  bool operator ==(o) => o is Position && x == o.x && y == o.y;
  int get hashCode => hash2(x.hashCode, y.hashCode);
}

/*
  Represents a level with a player and tile map
*/
class Level extends PositionComponent with HasGameRef<GithubGame> {
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
        await TiledComponent.load(_mapPath, GithubGame.TILE_SIZE));

    // Save a reference to the rendered tile map
    tileMap = tileMapComponent.tileMap.map;

    // Add the collision module
    add(collisionModule = CollisionModule(tileMapComponent));

    // Add the player to the level
    add(player = Player(this));

    for (int i = 5; i < 9; i++) {
      late Laser laser;
      add(laser = Laser(Position(i, 0), this, LaserState.ACTIVE));
    }

    for (int i = 5; i < 9; i++) {
      late Laser laser;
      add(laser = Laser(Position(i, 1), this, LaserState.FLICKER));
    }

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

  /*
    Used to transform a vector position to a given tile position
  */
  void teleport(Vector2 from, Position to) {
    Vector2 pos = getCanvasPosition(to);
    from.x = pos.x;
    from.y = pos.y;
  }

  /*
    Centers the level in the middle of the canvas
  */
  void _center(Vector2 canvasSize) {
    position.x =
        _getMiddle(canvasSize.x, tileMap.width * GithubGame.TILE_SIZE.x);
    position.y =
        _getMiddle(canvasSize.y, tileMap.height * GithubGame.TILE_SIZE.y);
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
      ..multiply(GithubGame.TILE_SIZE);
  }
}
