import 'package:flame/components.dart';
import 'package:github_game/level.dart';
import 'package:github_game/github_game.dart';
import 'dart:collection';

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
    level.teleport(position, tilePosition);

    sprites = await loadSprites();
  }

  bool get collision;

  void onInteract();

  Future<HashMap<dynamic, Sprite>> loadSprites();
}
