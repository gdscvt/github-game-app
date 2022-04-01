// ignore_for_file: constant_identifier_names
import 'dart:collection';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:github_game/mixins/has_player_ref.dart';
import 'package:github_game/modules/player/locomotion_module.dart';

/// These are all of the input actions that need to be handled.
enum InputAction { UP, RIGHT, LEFT, DOWN, INTERACT }

/// This module handles input for the player.
class InputModule extends Component with KeyboardHandler, HasPlayerRef {
  /// Map key presses to input actions.
  late final HashMap<LogicalKeyboardKey, InputAction> _keyMap;

  /// Initializes the input module and the input map.
  InputModule() : _keyMap = HashMap();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the input map
    _loadInputMap();
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    for (LogicalKeyboardKey key in keysPressed) {
      _handleInput(_keyMap[key]);
    }

    // Capture keyboard input
    return false;
  }

  /// Loads the input mappings from settings.
  void _loadInputMap() {
    // Map the keybinds
    _keyMap[LogicalKeyboardKey.keyW] = InputAction.UP;
    _keyMap[LogicalKeyboardKey.keyA] = InputAction.LEFT;
    _keyMap[LogicalKeyboardKey.keyD] = InputAction.RIGHT;
    _keyMap[LogicalKeyboardKey.keyS] = InputAction.DOWN;
    _keyMap[LogicalKeyboardKey.enter] = InputAction.INTERACT;
  }

  /// Responds accordingly to the given input action.
  void _handleInput(InputAction? action) {
    switch (action) {
      // Handle each input action
      case InputAction.DOWN:
        player.locomotionModule.move(Direction.D);
        break;
      case InputAction.LEFT:
        player.locomotionModule.move(Direction.L);
        break;
      case InputAction.RIGHT:
        player.locomotionModule.move(Direction.R);
        break;
      case InputAction.UP:
        player.locomotionModule.move(Direction.U);
        break;
      case InputAction.INTERACT:
        player.interact();
        break;
      default:
        break;
    }
  }
}
