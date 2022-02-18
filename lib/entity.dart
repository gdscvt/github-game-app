import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/github_game.dart';

abstract class Entity extends SpriteGroupComponent {
  late final Level level;
  late Position tilePosition;

  Entity(this.tilePosition, this.level);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = GithubGame.TILE_SIZE;

    if (collision) {
      level.collisionModule.setCollision(tilePosition, true);
    }

    level.entities.add(this);
  }

  bool get collision;

  void onInteract();
}
