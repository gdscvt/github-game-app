import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/input_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/level.dart';
import 'package:github_game/entity.dart';

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

  @override
  void update(double dt) {
    super.update(dt);

    // update the animation state based on the locomotion state
    animationModule.current = AnimationState.values.byName(
        "${locomotionModule.locomotionState.name}_${locomotionModule.direction.name}");

    // update the players position based on their movement in the locomotion module.
    locomotionModule.updateMovement(position, dt);
  }

  /*
    Calls the interact function on the entity in front of this player
  */
  void interact() {
    Position pos = locomotionModule.forwardTile;
    for (Entity entity in level.entities) {
      if (pos == entity.tilePosition) {
        entity.onInteract();
        return;
      }
    }
  }
}
