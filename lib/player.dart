import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/input_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/level.dart';

class Player extends PositionComponent {
  // Reference to the current level
  late final Level level;

  // This module controls the movement of the player
  late LocomotionModule locomotionModule;

  // This module controls the animation of the player
  late AnimationModule animationModule;

  late InputModule inputModule;

  Player(this.level);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set sprite size
    size = GitHubGame.TILE_SIZE;

    add(animationModule = AnimationModule());
    add(locomotionModule = LocomotionModule(level));
    add(inputModule = InputModule(this));
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the animation state based on the locomotion state
    animationModule.current = AnimationState.values.byName(
        "${locomotionModule.locomotionState.name}_${locomotionModule.direction.name}");

    // Update the players position based on their movement in the locomotion module.
    locomotionModule.updatePosition(position);
  }
}
