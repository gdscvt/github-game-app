import 'dart:collection';

import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/level.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:github_game/mixins/has_player_ref.dart';

/*
  These are the directions the player can face
*/
enum Direction { U, R, L, D }

/*
  These are the movement states a player can have
*/
enum LocomotionState { IDLE, WALKING }

/*
  This module is used to handle the movement of the player.
*/
class LocomotionModule extends Component with HasLevelRef, HasPlayerRef {
  static const double MOVEMENT_SPEED = 95; // pixels per second

  // input will unlock when you are this far from your current target tile
  static const double MOVEMENT_QUEUE_THRESHOLD = 2;

  late final ListQueue<Direction>
      _movements; // holds the queued movement directions

  // the current tile position, and the tile position you are moving towards
  late Position tilePosition, targetPosition;

  Direction direction = Direction.D; // current facing direction
  LocomotionState locomotionState =
      LocomotionState.IDLE; // current movement state

  LocomotionModule() : _movements = ListQueue(); // create the movement queue

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    tilePosition = level.spawnLocation;
    targetPosition = tilePosition;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _updateMovement(dt);
  }

  /*
    Returns whether or not the player's movement is within the distance 
    threshold to their target tile.
  */
  bool get _withinQueueThreshold {
    return level.player.position
            .distanceTo(level.getCanvasPosition(targetPosition)) <=
        MOVEMENT_QUEUE_THRESHOLD;
  }

  /*
    This will cause a player to begin moving in a direction if they are 
    not already moving.
  */
  void move(Direction dir) {
    // if there are 2 movement directions in queue, remove the last one and
    // replace it.
    if (_movements.length == 2) {
      _movements.removeLast();
      _addMovement(dir);
    }
    // if there are no movements in queue, queue the movement.
    // if there is only one movement in queue, and the player is within the
    // queue threshold, then queue a second movement.
    else if (_movements.isEmpty || _withinQueueThreshold) {
      _addMovement(dir);
    }
  }

  /*
    Initiate movement and update locomotion state to walking
  */
  void _addMovement(Direction dir) {
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
    If the player is at their destination, they will enter their idle state or
    begin targeting their next movement direction.
  */
  void _updateMovement(double dt) {
    if (_movements.isNotEmpty) {
      if (_updateTargetPosition()) {
        Vector2 currentPosition = player.position;
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

  /*
    Updates the target movement tile position
  */
  bool _updateTargetPosition() {
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
