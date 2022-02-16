import 'package:github_game/level.dart';
import 'package:flame/components.dart';
import 'dart:math';

enum Direction { U, R, L, D }

enum LocomotionState { IDLE, WALKING }

class LocomotionModule extends Component {
  static const double MOVEMENT_SPEED = 0.2;

  Direction direction = Direction.D;
  LocomotionState locomotionState = LocomotionState.IDLE;

  late Level level;
  late Position tilePosition, _destTilePosition;

  late int _width, _height;

  LocomotionModule(this.level) {
    _width = level.tileMap.width;
    _height = level.tileMap.height;
    tilePosition = level.playerSpawnLocation;
  }

  void move(Direction dir) {
    if (locomotionState == LocomotionState.IDLE) {
      direction = dir;
      _destTilePosition = Position(tilePosition.x, tilePosition.y);

      switch (dir) {
        case Direction.U:
          _destTilePosition.y = max(_destTilePosition.y - 1, 0);
          break;
        case Direction.R:
          _destTilePosition.x = min(_destTilePosition.x + 1, _width - 1);
          break;
        case Direction.L:
          _destTilePosition.x = max(_destTilePosition.x - 1, 0);
          break;
        case Direction.D:
          _destTilePosition.y = min(_destTilePosition.y + 1, _height - 1);
          break;
      }

      if (!level.collisionModule.collision(_destTilePosition)) {
        locomotionState = LocomotionState.WALKING;
      }
    }
  }

  void updatePosition(Vector2 currentPosition) {
    switch (locomotionState) {
      case LocomotionState.WALKING:
        Vector2 targetPosition = level.getCanvasPosition(_destTilePosition);
        if (currentPosition != targetPosition) {
          switch (direction) {
            case Direction.U:
              currentPosition.y =
                  max(currentPosition.y - MOVEMENT_SPEED, targetPosition.y);
              break;
            case Direction.R:
              currentPosition.x =
                  min(currentPosition.x + MOVEMENT_SPEED, targetPosition.x);
              break;
            case Direction.L:
              currentPosition.x =
                  max(currentPosition.x - MOVEMENT_SPEED, targetPosition.x);
              break;
            case Direction.D:
              currentPosition.y =
                  min(currentPosition.y + MOVEMENT_SPEED, targetPosition.y);
              break;
          }
        } else {
          locomotionState = LocomotionState.IDLE;
          tilePosition = _destTilePosition;
        }
        break;
      case LocomotionState.IDLE:
        break;
    }
  }
}
