import 'package:flame/components.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/level.dart';

/*
  Represents a dynamic object in a level.
*/
abstract class Entity extends PositionComponent with HasLevelRef {
  late Position tilePosition; // the tile coordinates of this entity

  Entity(this.tilePosition); // set the tile position in constructor

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // update the collision of the level based on this entity
    if (collision) {
      level.collisionModule.setCollision(tilePosition, true);
    }

    level.teleport(position, tilePosition); // teleport to the tile position
  }

  /*
    Returns whether or not this entity has collision.
  */
  bool get collision;

  /*
    Called when the player interacts with this entity.
  */
  void onInteract();
}
