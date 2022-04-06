import 'package:github_game/entities/entity.dart';
import 'package:github_game/level.dart';

import '../../main.dart';

class Computer extends Entity {
  Computer(Position tilePosition) : super(tilePosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    collision = true;
  }

  @override
  void onInteract() {
    print("Interacted with computer at ($tilePosition)");
    App.terminalScreen!.state.setState(() {
      App.terminalScreen!.state.isDisplayed = true;
    });
  }
}
