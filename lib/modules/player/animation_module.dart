// ignore_for_file: constant_identifier_names
import 'dart:collection';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/mixins/has_player_ref.dart';

/// Each state corresponds to an animation.
enum AnimationState {
  IDLE_U,
  IDLE_R,
  IDLE_L,
  IDLE_D,
  WALKING_U,
  WALKING_R,
  WALKING_L,
  WALKING_D
}

extension AnimationData on AnimationState {
  /// Path containing player animations
  static const String PLAYER_FILE_PATH =
      "${GithubGame.ANIMATION_FILE_PATH}/player";

  /// Length of time each frame in an animation lasts
  static const double FRAME_LENGTH = 0.15;

  /// Gets the number of frames for each animation.
  int get _frameCount {
    switch (this) {
      case AnimationState.IDLE_U:
      case AnimationState.IDLE_R:
      case AnimationState.IDLE_L:
      case AnimationState.IDLE_D:
        return 1;
      case AnimationState.WALKING_U:
      case AnimationState.WALKING_R:
      case AnimationState.WALKING_L:
      case AnimationState.WALKING_D:
        return 3;
    }
  }

  /// Returns the path to the sprite for this state.
  String get spritePath => "$PLAYER_FILE_PATH/player_${name.toLowerCase()}.png";

  /// Generates a sprite animation data object for an animation.
  SpriteAnimationData get animationData {
    return SpriteAnimationData.sequenced(
        amount: _frameCount,
        stepTime: FRAME_LENGTH,
        textureSize: GithubGame.TILE_SIZE);
  }
}

/// Runs the animation state machine.
class AnimationModule extends SpriteAnimationGroupComponent with HasPlayerRef {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Set the sprite size
    size = GithubGame.TILE_SIZE;

    // Load the animation map
    await _loadAnimations();

    // Set the default state
    current = AnimationState.IDLE_D;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the animation state based on the locomotion state
    current = AnimationState.values.byName(
        "${player.locomotionModule.locomotionState.name}_${player.locomotionModule.direction.name}");
  }

  /// Loads all animations for the player.
  Future<void> _loadAnimations() async {
    // Initialize the animation map
    animations = HashMap();

    for (AnimationState state in AnimationState.values) {
      final SpriteAnimationData data = state.animationData;

      final SpriteAnimation animation = SpriteAnimation.fromFrameData(
          await Flame.images.load(state.spritePath), data);

      // Map this state to the loaded animation
      animations![state] = animation;
    }
  }
}
