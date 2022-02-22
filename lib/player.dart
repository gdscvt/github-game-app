import 'package:flame/components.dart';
import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/input_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';

/// Represents a player in a level.
class Player extends PositionComponent with HasLevelRef {
  /// Controls the movement of the player.
  late final LocomotionModule _locomotionModule;

  /// Controls animation of the player.
  late final AnimationModule _animationModule;

  /// Handles all input.
  late final InputModule _inputModule;

  /// Gets the locomotion module which is responsible for all player movement.
  LocomotionModule get locomotionModule => _locomotionModule;

  /// Gets the animation module which is responsible for all player animation.
  AnimationModule get animationModule => _animationModule;

  /// Gets the innput module which is responsible for all player input.
  InputModule get inputModule => _inputModule;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set the sprite size
    size = GithubGame.TILE_SIZE;

    // Set the priority (z-axis) of the sprite
    changePriorityWithoutResorting(1);

    add(_animationModule = AnimationModule());
    add(_locomotionModule = LocomotionModule());
    add(_inputModule = InputModule());
  }

  /// Calls the interact function on the entity in front of this player.
  void interact() {
    Position pos = _locomotionModule.forwardTile;
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
