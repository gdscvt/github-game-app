import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/has_level_ref.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/input_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/level.dart';
import 'package:github_game/entity.dart';

class Player extends PositionComponent with HasLevelRef {
  // This module controls the movement of the player
  late LocomotionModule locomotionModule;

  // This module controls the animation of the player
  late AnimationModule animationModule;

  late InputModule inputModule;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set sprite size
    size = GithubGame.TILE_SIZE;
    changePriorityWithoutResorting(1);

    add(animationModule = AnimationModule());
    add(locomotionModule = LocomotionModule());
    add(inputModule = InputModule());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the animation state based on the locomotion state
    animationModule.current = AnimationState.values.byName(
        "${locomotionModule.locomotionState.name}_${locomotionModule.direction.name}");

    // Update the players position based on their movement in the locomotion module.
    locomotionModule.updateMovement(position, dt);
  }

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
