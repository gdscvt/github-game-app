import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:github_game/github_game.dart';

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
        amount: getAnimationFrameCount(),
        stepTime: FRAME_LENGTH,
        textureSize: frameSize);
  }

  /*
    Gets the number of frames for each animation
  */
  int getAnimationFrameCount() {
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
class AnimationModule extends SpriteAnimationGroupComponent
    with HasGameRef<GitHubGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = gameRef.tileSize;
    animations = await loadAnimationMap();
    current = AnimationState.IDLE_D;
  }

  /*
    Loads and retuns a map of the animation assets
  */
  Future<Map<AnimationState, SpriteAnimation>> loadAnimationMap() async {
    Map<AnimationState, SpriteAnimation> animMap = {};

    for (AnimationState state in AnimationState.values) {
      final String filePath =
          "${GitHubGame.ANIMATION_FILE_PATH}/player_${state.name.toLowerCase()}.png";

      final SpriteAnimationData data = state.getAnimationData(gameRef.tileSize);

      final SpriteAnimation animation = SpriteAnimation.fromFrameData(
          await Flame.images.load(filePath), data);
      animMap.putIfAbsent(state, () => animation);
    }

    return animMap;
  }
}
