import 'package:github_game/entities/entity.dart';
import 'package:github_game/level.dart';

class Terminal extends Entity {
  Terminal(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    collision = true;
  }

  @override
  void onInteract() {
    print("Interacted with computer at ($tilePosition)");
  }
}
