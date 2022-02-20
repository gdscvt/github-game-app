import 'dart:collection';
import 'dart:html';

import 'package:github_game/level.dart';
import 'package:flame/components.dart';
import 'dart:math';

/*
  These are the directions the player can face
*/
enum Direction { U, R, L, D }

/*
  These are the movement states a player can have
*/
enum LocomotionState { IDLE, WALKING }

/*
  This module is used to handle the movement of the player
*/
class LocomotionModule extends Component {
  static const double MOVEMENT_SPEED = 75;
  static const double MOVEMENT_QUEUE_THRESHOLD = 12;

  Direction direction = Direction.D;
  LocomotionState locomotionState = LocomotionState.IDLE;

  late final Level _level;
  late Position tilePosition;

  ListQueue<Direction> _movements = ListQueue();
  late Position _targetPosition;

  late int _width, _height;

  LocomotionModule(this._level) {
    _width = _level.tileMap.width;
    _height = _level.tileMap.height;
    tilePosition = _level.playerSpawnLocation;
  }

  bool get withinQueueThreshold {
    return _level.player.position
            .distanceTo(_level.getCanvasPosition(_targetPosition)) <=
        MOVEMENT_QUEUE_THRESHOLD;
  }

  /*
    This will cause a player to begin moving in a direction if they are 
    not already moving (or are about to stop moving).
  */
  void move(Direction dir) {
    if (_movements.isEmpty) {
      _initMovement(dir);
    } else if (_movements.length == 1) {
      if (withinQueueThreshold) {
        _initMovement(dir);
      }
    } else {
      _movements.removeLast();
      _initMovement(dir);
    }
  }

  void _initMovement(Direction dir) {
    _movements.add(dir);
    if (locomotionState == LocomotionState.IDLE) {
      locomotionState = LocomotionState.WALKING;
    }
  }

  /*
    This function gets the tile position directly in front of the player currently
  */
  Position get forwardTile {
    Position forward = Position(tilePosition.x, tilePosition.y);

    switch (direction) {
      case Direction.U:
        forward.y = max(forward.y - 1, 0);
        break;
      case Direction.R:
        forward.x = min(forward.x + 1, _width - 1);
        break;
      case Direction.L:
        forward.x = max(forward.x - 1, 0);
        break;
      case Direction.D:
        forward.y = min(forward.y + 1, _height - 1);
        break;
    }

    return forward;
  }

  /*
    This function moves the player towards their destination if they are walking. 
    If the player is at their destination, they will enter the idle state.
  */
  void updateMovement(Vector2 currentPosition, double dt) {
    if (_movements.isEmpty) {
      locomotionState = LocomotionState.IDLE;
    } else {
      if (direction != _movements.first) {
        direction = _movements.first;
      }

      _moveTowardTarget(dt);

      if (tilePosition == _targetPosition) {
        _movements.removeFirst();
      }
    }
  }

  void _moveTowardTarget(double dt) {
    _targetPosition = forwardTile;

    Vector2 currentPosition = _level.player.position;
    Vector2 targetPosition = currentPosition.clone();

    if (!_level.collisionModule.collision(_targetPosition)) {
      targetPosition = _level.getCanvasPosition(_targetPosition);
      double distance = MOVEMENT_SPEED * dt;

      switch (direction) {
        case Direction.U:
          currentPosition.y =
              max(currentPosition.y - distance, targetPosition.y);
          break;
        case Direction.R:
          currentPosition.x =
              min(currentPosition.x + distance, targetPosition.x);
          break;
        case Direction.L:
          currentPosition.x =
              max(currentPosition.x - distance, targetPosition.x);
          break;
        case Direction.D:
          currentPosition.y =
              min(currentPosition.y + distance, targetPosition.y);
          break;
      }

      if (currentPosition == targetPosition) {
        tilePosition = _targetPosition;
      }
    } else {
      _targetPosition = tilePosition;
    }
  }
}
