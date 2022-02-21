import 'dart:collection';

import 'package:github_game/has_level_ref.dart';
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
class LocomotionModule extends Component with HasLevelRef {
  static const double MOVEMENT_SPEED = 85;
  static const double MOVEMENT_QUEUE_THRESHOLD = 2;

  final ListQueue<Direction> _movements;

  late Position tilePosition, targetPosition;

  Direction direction = Direction.D;
  LocomotionState locomotionState = LocomotionState.IDLE;

  LocomotionModule() : _movements = ListQueue();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    tilePosition = level.spawnLocation;
    targetPosition = tilePosition;
  }

  bool get _withinQueueThreshold {
    return level.player.position
            .distanceTo(level.getCanvasPosition(targetPosition)) <=
        MOVEMENT_QUEUE_THRESHOLD;
  }

  /*
    This will cause a player to begin moving in a direction if they are 
    not already moving (or are about to stop moving).
  */
  void move(Direction dir) {
    if (_movements.length == 2) {
      _movements.removeLast();
      addMovement(dir);
    } else if (_movements.isEmpty || _withinQueueThreshold) {
      addMovement(dir);
    }
  }

  void addMovement(Direction dir) {
    if (_movements.isEmpty) {
      direction = dir;
      locomotionState = LocomotionState.WALKING;
    }

    _movements.add(dir);
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
        forward.x = min(forward.x + 1, level.mapModule.dimensions.x - 1);
        break;
      case Direction.L:
        forward.x = max(forward.x - 1, 0);
        break;
      case Direction.D:
        forward.y = min(forward.y + 1, level.mapModule.dimensions.y - 1);
        break;
    }

    return forward;
  }

  /*
    This function moves the player towards their destination if they are walking. 
    If the player is at their destination, they will enter the idle state.
  */
  void updateMovement(Vector2 currentPosition, double dt) {
    if (_movements.isNotEmpty) {
      if (updateTargetPosition()) {
        Vector2 distanceToTarget = level.getCanvasPosition(targetPosition)
          ..sub(currentPosition);

        Vector2 movement = distanceToTarget.normalized()
          ..multiply(Vector2.all(MOVEMENT_SPEED * dt));

        double ratio = distanceToTarget.length / movement.length;

        if (ratio < 1.0) {
          movement.multiply(Vector2.all(ratio));
        }

        currentPosition.add(movement);

        if (currentPosition == level.getCanvasPosition(targetPosition)) {
          tilePosition = targetPosition;
          _movements.removeFirst();
        }
      } else {
        _movements.removeFirst();
      }
      if (_movements.isEmpty) {
        locomotionState = LocomotionState.IDLE;
      } else {
        direction = _movements.first;
      }
    }
  }

  bool updateTargetPosition() {
    if (tilePosition == targetPosition) {
      Position forward = forwardTile;

      if (!level.collisionModule.getCollision(forward)) {
        targetPosition = forward;
        return true;
      }

      return false;
    }

    return true;
  }
}
