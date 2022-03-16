import 'package:python_game/entities/entity.dart';
import 'package:python_game/level.dart';

class Computer extends Entity {
  Computer(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void onInteract() {
    print("Interacted with computer at ($tilePosition)");
  }
}
