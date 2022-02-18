import 'package:github_game/entity.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';
import 'package:flame/sprite.dart';
import 'dart:collection';

enum LaserState { ACTIVE, FLICKER, INACTIVE }

extension SpritePath on LaserState {
  static const String LASER_FILE_PATH =
      "${GithubGame.ANIMATION_FILE_PATH}/laser";

  String get spritePath {
    return "${LASER_FILE_PATH}/laser_${this.name.toLowerCase()}.png";
  }
}

class Laser extends Entity {
  static const double FLICKER_RATIO = 0.03;
  static const double ANIMATION_LENGTH = 3;

  double currentAnimLength = ANIMATION_LENGTH;
  double elapsed = 0.0;

  Laser(Position position, Level level, LaserState entryState)
      : super(position, level) {
    current = entryState;

    if (current == LaserState.FLICKER) {
      currentAnimLength *= FLICKER_RATIO;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprites = await _loadSprites;

    level.teleport(position, tilePosition);
  }

  @override
  bool get collision {
    return current != LaserState.INACTIVE;
  }

  @override
  void update(double dt) {
    super.update(dt);

    elapsed += dt;

    if (elapsed >= currentAnimLength) {
      switch (current) {
        case LaserState.ACTIVE:
          current = LaserState.FLICKER;
          currentAnimLength = FLICKER_RATIO * ANIMATION_LENGTH;
          break;
        case LaserState.FLICKER:
          current = LaserState.ACTIVE;
          currentAnimLength = ANIMATION_LENGTH;
          break;
      }

      elapsed = 0;
    }
  }

  void deactive() {
    current = LaserState.INACTIVE;
    level.collisionModule.setCollision(tilePosition, false);
  }

  Future<HashMap<LaserState, Sprite>> get _loadSprites async {
    HashMap<LaserState, Sprite> result = HashMap();
    for (LaserState laserState in LaserState.values) {
      result[laserState] = await Sprite.load(laserState.spritePath);
    }

    return result;
  }
}
