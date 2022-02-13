import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'dart:ui';
import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'player.dart';

class Level extends PositionComponent with HasGameRef<GitHubGame> {
  late final Player player;
  late final Vector2 tileSize;
  late final TiledComponent tileMapComponent;

  late final TiledMap _tileMap;
  late final String _mapPath;
  bool _loaded = false;

  Level(this.player, this._mapPath, this.tileSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    tileMapComponent = await TiledComponent.load(_mapPath, tileSize);
    _tileMap = tileMapComponent.tileMap.map;

    _loaded = true;

    add(tileMapComponent);

    _resize(gameRef.canvasSize);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    if (_loaded) {
      // Center the canvas
      _resize(gameSize);
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

  void _resize(Vector2 canvasSize) {
    position.x = _getMiddle(canvasSize.x, _tileMap.width * tileSize.x);
    position.y = _getMiddle(canvasSize.y, _tileMap.height * tileSize.y);
  }

  double _getMiddle(double canvasSize, double width) {
    return (canvasSize / 2) - (width / 2);
  }
}
