import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:github_game/github_game.dart';
import 'level.dart';

enum AnimationState {
  IDLE_U,
  IDLE_L,
  IDLE_R,
  IDLE_D,
  WALKING_U,
  WALKING_L,
  WALKING_R,
  WALKING_D
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<GitHubGame> {
  static const AnimationState defaultState = AnimationState.IDLE_D;

  late final Level level;

  late Vector2 tilePosition;

  Player(this.level, this.tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = gameRef.tileSize;
    current = defaultState;

    animations = await loadAnimationMap();
  }

  Future<Map<AnimationState, SpriteAnimation>> loadAnimationMap() async {
    Map<AnimationState, SpriteAnimation> animMap = {};

    for (AnimationState state in AnimationState.values) {
      final String filePath = "player_${state.name.toLowerCase()}.png";

      int sampleSize = 1;
      if (filePath.contains("walking")) {
        sampleSize = 3;
      }

      final SpriteAnimationData data = SpriteAnimationData.sequenced(
          amount: sampleSize, stepTime: 0.15, textureSize: gameRef.tileSize);
      final SpriteAnimation animation = SpriteAnimation.fromFrameData(
          await Flame.images.load(filePath), data);
      animMap.putIfAbsent(state, () => animation);
    }

    return animMap;
  }
}
