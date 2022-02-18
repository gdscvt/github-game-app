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
  static const double MOVEMENT_SPEED = 50;
  static const double MOVEMENT_JUMP_THRESHOLD = 0.5;

  Direction direction = Direction.D;
  LocomotionState locomotionState = LocomotionState.IDLE;

  late final Level _level;
  late Position tilePosition, _destTilePosition;

  late int _width, _height;

  LocomotionModule(this._level) {
    _width = _level.tileMap.width;
    _height = _level.tileMap.height;
    tilePosition = _level.playerSpawnLocation;
  }

  /*
    This will cause a player to begin moving in a direction if they are 
    not already moving (or are about to stop moving).
  */
  void move(Direction dir) {
    switch (locomotionState) {
      // If the player is already moving:
      case LocomotionState.WALKING:
        Vector2 currentPosition = _level.player.position;
        Vector2 targetPosition = _level.getCanvasPosition(_destTilePosition);

        // If the player is within an acceptable radius from their destination:
        if (currentPosition.distanceTo(targetPosition) <
            MOVEMENT_JUMP_THRESHOLD) {
          // Teleport the player to their destination
          _level.teleport(currentPosition, _destTilePosition);

          // Update their movement state (resets state to idle because they have
          // arrived at their destination)
          tilePosition = _destTilePosition;
          locomotionState = LocomotionState.IDLE;

          // Call the move function again, and move in the direction specified
          move(dir);
        }

        break;

      // If the player is not already moving
      case LocomotionState.IDLE:
        direction = dir;

        // Get the tile in the new facing direction
        _destTilePosition = forwardTile();

        // Check the collision of the destination coordinate
        if (!_level.collisionModule.collision(_destTilePosition)) {
          // If there is no collision, enter the walking state
          locomotionState = LocomotionState.WALKING;
        }

        break;
    }
  }

  /*
    This function gets the tile position directly in front of the player currently
  */
  Position forwardTile() {
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
  void updatePosition(Vector2 currentPosition, double dt) {
    switch (locomotionState) {
      case LocomotionState.WALKING:
        Vector2 targetPosition = _level.getCanvasPosition(_destTilePosition);
        if (currentPosition != targetPosition) {
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
