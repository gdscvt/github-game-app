// ignore_for_file: constant_identifier_names, slash_for_doc_comments
import 'dart:collection';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/mixins/has_player_ref.dart';
import 'package:github_game/mixins/has_level_ref.dart';

/// These are the directions the player can face
enum Direction { U, R, L, D }

/// These are the movement states a player can have
enum LocomotionState { IDLE, WALKING }

/// This module is used to handle the movement of the player.
class LocomotionModule extends Component with HasLevelRef, HasPlayerRef {
  /// Movement speed in pixels per second.
  static const double MOVEMENT_SPEED = 95;

  /// Input will unlock when you are this far from your current target tile.
  static const double MOVEMENT_QUEUE_THRESHOLD = 2;

  /// Holds the queue'd movement directions.
  late final ListQueue<Direction> _movements;

  /// The current tile position.
  late Position _tilePosition;

  /// The target tile position.
  late Position _targetPosition;

  /// The current facing direction.
  Direction _direction = Direction.D;

  /// The current movement state
  LocomotionState _locomotionState = LocomotionState.IDLE;

  /**
   * Returns whether or not the player's movement is within the distance 
   * threshold to their target tile.
   */
  bool get _withinQueueThreshold {
    return level.player.position
            .distanceTo(level.getCanvasPosition(_targetPosition)) <=
        MOVEMENT_QUEUE_THRESHOLD;
  }

  /// Gets the current tile position of the player.
  Position get tilePosition => _tilePosition;

  /// Gets the current facing direction of the player.
  Direction get direction => _direction;

  /// Gets the current movement state of the player.
  LocomotionState get locomotionState => _locomotionState;

  /// Gets the tile position directly in front of the player
  Position get forwardTile {
    final Vector2 forward =
        Vector2(_tilePosition.x.toDouble(), _tilePosition.y.toDouble());

    late final Vector2 move;

    switch (_direction) {
      case Direction.U:
        move = Vector2(0, -1);
        break;
      case Direction.R:
        move = Vector2(1, 0);
        break;
      case Direction.L:
        move = Vector2(-1, 0);
        break;
      case Direction.D:
        move = Vector2(0, 1);
        break;
      default:
        move = Vector2.zero();
        break;
    }

    forward.add(move);
    Position dimensions = level.mapModule.dimensions;

    forward.clamp(Vector2.zero(),
        Vector2(dimensions.x.toDouble(), dimensions.y.toDouble()));

    return Position(forward.x.round(), forward.y.round());
  }

  /// Creates the module and a movement queue.
  LocomotionModule() : _movements = ListQueue();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _tilePosition = level.spawnLocation;
    _targetPosition = _tilePosition;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _updatePosition(dt); // update player position
  }

  /** 
   * This will cause a player to begin moving in a direction if they are not
   * already moving.
   */
  void move(Direction dir) {
    // If there are 2 movement directions in queue, remove the last one and
    // replace it.
    if (_movements.length == 2) {
      _movements.removeLast();
      _addMovement(dir);
    }
    // If there are no movements in queue, queue the movement. Or, if there is
    // only one movement in queue, and the player is within the queue threshold,
    // then queue this movement.
    else if (_movements.isEmpty || _withinQueueThreshold) {
      _addMovement(dir);
    }
  }

  /// Queue movement and update locomotion state to walking
  void _addMovement(Direction dir) {
    if (_movements.isEmpty) {
      _direction = dir;
      _locomotionState = LocomotionState.WALKING;
    }

    _movements.add(dir);
  }

  /** 
   * This function moves the player towards their target if they are walking.
   * If the player is at their destination, they will enter their idle state or
   * begin targeting their next movement direction.
   */
  void _updatePosition(double dt) {
    // If there is a movement queue'd
    if (_movements.isNotEmpty) {
      // Update the target. Returns false if the movement is blocked by
      // collision.
      if (_updateTargetPosition()) {
        // Get the canvas coordinates of the player
        Vector2 currentPosition = player.position;

        // Get the distance between the player and their target tile
        final Vector2 distanceToTarget =
            level.getCanvasPosition(_targetPosition)..sub(currentPosition);

        // Make a movement vector
        final Vector2 movement = distanceToTarget.normalized()
          ..multiply(Vector2.all(MOVEMENT_SPEED * dt));

        // If the movement vector is greater than the distance to the target,
        // you must scale the movement vector down to match the distance
        final double ratio = distanceToTarget.length / movement.length;

        // If the ratio is a fraction, the movement vector must be scaled
        if (ratio < 1.0) {
          // Scale the movement vector
          movement.multiply(Vector2.all(ratio));
        }

        // Add the movement vector to the player position
        currentPosition.add(movement);

        // If you have reached the target tile, update your tile position and
        // remove the movement from the queue
        if (currentPosition == level.getCanvasPosition(_targetPosition)) {
          _tilePosition = _targetPosition;
          _movements.removeFirst();
        }
      } else {
        // If the movement collided, remove it from the queue
        _movements.removeFirst();
      }

      if (_movements.isEmpty) {
        // If the movement queue is empty, transition to idle
        _locomotionState = LocomotionState.IDLE;
      } else {
        // Otherwise, transition to next movement direction
        _direction = _movements.first;
      }
    }
  }

  /// Updates the position of the target and returns true if it is not collided.
  bool _updateTargetPosition() {
    if (_tilePosition == _targetPosition) {
      // Get the forward tile
      final Position forward = forwardTile;

      // If the tile is collided, return false. Otherwise, update target tile.
      if (level.collisionModule.getCollision(forward)) {
        return false;
      } else {
        _targetPosition = forward;
      }
    }

    // Return true if there was no collision.
    return true;
  }
}
