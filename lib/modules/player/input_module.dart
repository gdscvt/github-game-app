import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:github_game/modules/player/locomotion_module.dart';
import 'package:github_game/player.dart';
import 'package:flutter/services.dart';

/*
  These are all of the input actions that need to be handled
*/
enum InputAction { UP, RIGHT, LEFT, DOWN, INTERACT }

/*
  This module handles input for the player
*/
class InputModule extends Component with KeyboardHandler, HasLevelRef {
  // This hash map is used to map key presses to input actions
  HashMap<LogicalKeyboardKey, InputAction> keyMap;

  late final Player _player;

  InputModule() : keyMap = HashMap();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _player = level.player;

    _loadInputMap();
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    for (LogicalKeyboardKey key in keysPressed) {
      _handleInput(keyMap[key]);
    }

    // Capture keyboard input
    return false;
  }

  void _loadInputMap() {
    // Map the keybinds
    keyMap[LogicalKeyboardKey.keyW] = InputAction.UP;
    keyMap[LogicalKeyboardKey.keyA] = InputAction.LEFT;
    keyMap[LogicalKeyboardKey.keyD] = InputAction.RIGHT;
    keyMap[LogicalKeyboardKey.keyS] = InputAction.DOWN;
    keyMap[LogicalKeyboardKey.enter] = InputAction.INTERACT;
  }

  void _handleInput(InputAction? action) {
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
      case InputAction.INTERACT:
        _player.interact();
        break;
      default:
        break;
    }
  }
}
