import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/mixins/has_level_ref.dart';

/*
  Represents a dynamic object in a level.
*/
abstract class Entity extends PositionComponent with HasLevelRef {
  /// The tile coordinates of this entity
  late final Position _tilePosition;

  /// Gets the tile coordinates of this entity.
  Position get tilePosition => _tilePosition;

  /// Returns whether or not this entity has collision.
  bool get collision;

  /// Sets the collision for this entity and updates the collision module.
  set collision(bool coll) {
    level.collisionModule.setCollision(_tilePosition, coll);
  }

  /// Initializes the entity with the given tile coordinates.
  Entity(this._tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Update the collision of the level based on this entity
    if (collision) {
      level.collisionModule.setCollision(_tilePosition, true);
    }

    // Teleport to the tile position
    level.teleport(position, _tilePosition);
  }

  /// Called when the player interacts with this entity.
  void onInteract();
}
