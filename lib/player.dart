import 'package:flame/components.dart';
import 'package:github_game/entity_group.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/input_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';

/*
  Represents a player in a level.
*/
class Player extends PositionComponent with HasLevelRef {
  late LocomotionModule locomotionModule; // controls the movement of the player
  late AnimationModule animationModule; // controls animation of the player
  late InputModule inputModule; // handles all input

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = GithubGame.TILE_SIZE; // set the sprite size
    changePriorityWithoutResorting(
        1); // set the priority (z-axis) of the sprite

    add(animationModule = AnimationModule());
    add(locomotionModule = LocomotionModule());
    add(inputModule = InputModule());
  }

  /*
    Calls the interact function on the entity in front of this player
  */
  void interact() {
    Position pos = locomotionModule.forwardTile;
    for (EntityGroup group in level.entityManagerModule.groups) {
      for (Entity entity in group.entities) {
        if (pos == entity.tilePosition) {
          entity.onInteract();
          return;
        }
      }
    }
  }
}
