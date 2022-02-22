import 'package:github_game/entity.dart';
import 'package:github_game/level.dart';

class Laser extends Entity {
  Laser(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    collision = true;
  }

  @override
  void onInteract() {
    print("Interacted with laser at ($tilePosition)");
  }
}
