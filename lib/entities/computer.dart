import 'dart:collection';
import 'package:flame/sprite.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/level.dart';

enum ComputerType { LAPTOP, PC, FLATSCREEN }

extension SpritePath on ComputerType {
  static const String COMPUTER_FILE_PATH =
      "${GithubGame.ANIMATION_FILE_PATH}/computer";
  String get spritePath =>
      "${COMPUTER_FILE_PATH}/computer_${name.toLowerCase()}.png";
}

class Computer extends Entity {
  Computer(Position position, Level level, ComputerType type)
      : super(position, level) {
    current = type;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  bool get collision => false;

  @override
  void onInteract() {
    print(current.toString());
  }

  @override
  Future<HashMap<ComputerType, Sprite>> loadSprites() async {
    HashMap<ComputerType, Sprite> result = HashMap();

    for (ComputerType type in ComputerType.values) {
      result[type] = await Sprite.load(type.spritePath);
    }

    return result;
  }
}
