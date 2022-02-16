import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/player/animation_module.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'level.dart';
import 'dart:ui';

class Player extends PositionComponent with HasGameRef<GitHubGame> {
  // Reference to the current level
  late final Level level;

  // This module controls the movement of the player
  late LocomotionModule locomotionModule;

  // This module controls the animation of the player
  late AnimationModule animationModule;

  Player(this.level);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = gameRef.tileSize;

    add(animationModule = AnimationModule());
    add(locomotionModule = LocomotionModule(level.playerSpawnLocation));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    animationModule.current = AnimationState.values.byName(
        "${locomotionModule.locomotionState.name}_${locomotionModule.direction.name}");
  }
}
