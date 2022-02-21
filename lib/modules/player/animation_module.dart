import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:github_game/github_game.dart';
import 'dart:collection';

/*
  Each state corresponds to an animation
*/
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
  static const String PLAYER_FILE_PATH =
      "${GithubGame.ANIMATION_FILE_PATH}/player";

  // The length of time each frame in an animation lasts
  static const double FRAME_LENGTH = 0.15;

  String get spritePath =>
      "${PLAYER_FILE_PATH}/player_${name.toLowerCase()}.png";

  /*
    Generates a sprite animation data object for an animation
  */
  SpriteAnimationData getAnimationData() {
    return SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: FRAME_LENGTH,
        textureSize: GithubGame.TILE_SIZE);
  }

  /*
    Gets the number of frames for each animation
  */
  int get frameCount {
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
}

/*
  Runs the animation state machine
*/
class AnimationModule extends SpriteAnimationGroupComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = GithubGame.TILE_SIZE;
    await _loadAnimationMap();
    current = AnimationState.IDLE_D;
  }

  /*
    Loads and retuns a map of the animation assets
  */
  Future<void> _loadAnimationMap() async {
    animations = HashMap();

    for (AnimationState state in AnimationState.values) {
      final SpriteAnimationData data = state.getAnimationData();

      final SpriteAnimation animation = SpriteAnimation.fromFrameData(
          await Flame.images.load(state.spritePath), data);
      animations![state] = animation;
    }
  }
}
