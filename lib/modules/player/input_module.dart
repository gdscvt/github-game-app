import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/player.dart';
import 'package:flutter/services.dart';

enum InputAction { UP, RIGHT, LEFT, DOWN }

class InputModule extends Component with KeyboardHandler {
  Map<LogicalKeyboardKey, InputAction> keyMap = {};

  late Player _parent;

  InputModule(this._parent);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    keyMap[LogicalKeyboardKey.keyW] = InputAction.UP;
    keyMap[LogicalKeyboardKey.keyA] = InputAction.LEFT;
    keyMap[LogicalKeyboardKey.keyD] = InputAction.RIGHT;
    keyMap[LogicalKeyboardKey.keyS] = InputAction.DOWN;
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    handleInput(keyMap[event.logicalKey]);

    // Capture keyboard input
    return false;
  }

  void handleInput(InputAction? action) {
    if (action != null) {
      switch (action) {
        case InputAction.DOWN:
          _parent.locomotionModule.move(Direction.D);
          break;
        case InputAction.LEFT:
          _parent.locomotionModule.move(Direction.L);
          break;
        case InputAction.RIGHT:
          _parent.locomotionModule.move(Direction.R);
          break;
        case InputAction.UP:
          _parent.locomotionModule.move(Direction.U);
          break;
      }
    }
  }
}
