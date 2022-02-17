import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/player.dart';
import 'package:flutter/services.dart';

/*
  These are all of the input actions that need to be handled
*/
enum InputAction { UP, RIGHT, LEFT, DOWN }

/*
  This module handles input for the player
*/
class InputModule extends Component with KeyboardHandler {
  // This hash map is used to map key presses to input actions
  HashMap<LogicalKeyboardKey, InputAction> keyMap = HashMap();

  late final Player _player;

  InputModule(this._player);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Map the keybinds
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
    for (LogicalKeyboardKey key in keysPressed) {
      handleInput(keyMap[key]);
    }

    // Capture keyboard input
    return false;
  }

  void handleInput(InputAction? action) {
    if (action != null) {
      switch (action) {
        // Handle each input action
        case InputAction.DOWN:
          _player.locomotionModule.move(Direction.D);
          break;
        case InputAction.LEFT:
          _player.locomotionModule.move(Direction.L);
          break;
        case InputAction.RIGHT:
          _player.locomotionModule.move(Direction.R);
          break;
        case InputAction.UP:
          _player.locomotionModule.move(Direction.U);
          break;
      }
    }
  }
}
