import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';
import 'package:flame/components.dart';
import 'dart:math';

enum Direction { U, R, L, D }

enum LocomotionState { IDLE, WALKING }

class LocomotionModule extends Component with HasGameRef<GitHubGame> {
  Direction direction = Direction.D;
  LocomotionState locomotionState = LocomotionState.IDLE;
  late Position tilePosition, _destTilePosition;

  late int _width, _height;

  LocomotionModule(this.tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _width = gameRef.level.tileMap.width;
    _height = gameRef.level.tileMap.height;
  }

  void move(Direction dir) {
    if (locomotionState == LocomotionState.IDLE) {
      direction = dir;
      _destTilePosition = Position(tilePosition.x, tilePosition.y);

      switch (dir) {
        case Direction.U:
          _destTilePosition.y = min(_destTilePosition.y + 1, _height - 1);
          break;
        case Direction.R:
          _destTilePosition.x = min(_destTilePosition.x + 1, _width - 1);
          break;
        case Direction.L:
          _destTilePosition.x = max(_destTilePosition.x - 1, 0);
          break;
        case Direction.D:
          _destTilePosition.y = max(_destTilePosition.y - 1, 0);
          break;
      }

      if (!gameRef.level.collisionModule.collision(_destTilePosition)) {
        locomotionState = LocomotionState.WALKING;
      }
    }
  }
}
