import 'package:github_game/entity.dart';
import 'package:github_game/level.dart';

class Computer extends Entity {
  Computer(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    collision = false;
  }

  @override
  void onInteract() {
    print("Interacted with computer at ($tilePosition)");
  }
}
