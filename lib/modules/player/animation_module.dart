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
  // The length of time each frame in an animation lasts
  static const double FRAME_LENGTH = 0.15;

  /*
    Generates a sprite animation data object for an animation
  */
  SpriteAnimationData getAnimationData(Vector2 frameSize) {
    return SpriteAnimationData.sequenced(
        amount: _frameCount, stepTime: FRAME_LENGTH, textureSize: frameSize);
  }

  /*
    Gets the number of frames for each animation
  */
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
}

/*
  Runs the animation state machine
*/
class AnimationModule extends SpriteAnimationGroupComponent {
  static const String PLAYER_FILE_PATH =
      "${GithubGame.ANIMATION_FILE_PATH}/player";

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = GithubGame.TILE_SIZE;
    animations = await _loadAnimationMap();
    current = AnimationState.IDLE_D;
  }

  /*
    Loads and retuns a map of the animation assets
  */
  Future<Map<AnimationState, SpriteAnimation>> _loadAnimationMap() async {
    HashMap<AnimationState, SpriteAnimation> animMap = HashMap();

    for (AnimationState state in AnimationState.values) {
      final String filePath =
          "${PLAYER_FILE_PATH}/player_${state.name.toLowerCase()}.png";

      final SpriteAnimationData data =
          state.getAnimationData(GithubGame.TILE_SIZE);

      final SpriteAnimation animation = SpriteAnimation.fromFrameData(
          await Flame.images.load(filePath), data);
      animMap[state] = animation;
    }

    return animMap;
  }
}
