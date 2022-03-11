import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../abstract/positional_values.dart';
import 'menu_button_dropdown_buttons/GoToPreviousLevel/goToPreviousLevel_button.dart';
import 'menu_button_dropdown_buttons/RestartGame/restartGame_button.dart';
import 'menu_button_dropdown_buttons/RestartLevel/restartLevel_button.dart';
/// MenuButton class -Justin
class MenuButton extends SpriteComponent with Tappable,Hoverable{
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final RestartLevelButton restartLevel;
  late final GoToPreviousLevelButton goToPreviousLevel;
  late final RestartGameButton restartGame;

  /// This function initalizes the dropdown buttons and sets their properties.
  /// The screenWidth and screenHeight parameters are needed from github_game to
  /// then be passed to each individual dropdown in_level_buttons
  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async{
    restartLevel = RestartLevelButton(text: " Restart Level",
        style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(0.0)),
        screenWidth: screenWidth, screenHeight: screenHeight);
    goToPreviousLevel = GoToPreviousLevelButton(text: "Go To Previous Level",
        style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(1.0)),
        screenWidth: screenWidth, screenHeight: screenHeight);
    restartGame = RestartGameButton(text: "  Restart Game",
        style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(2.0)),
        screenWidth: screenWidth, screenHeight: screenHeight);
  }

  /// Adds buttons to the screen
  Future<void> addDropDownButtons() async{
  await add(restartLevel);
  await add(goToPreviousLevel);
  await add(restartGame);
}
  /// Removes buttons from the screen
   void removeDropDownButtons(){
    remove(restartLevel);
    remove(goToPreviousLevel);
    remove(restartGame);
  }

  /// Note: icon in_level_buttons is not a parent class. This class contains the blueprint
  /// for the functionality and data of the icon on the screen.
  /// If the screen does not contain the dropdown buttons(all buttons are added and
  /// removed together) then the in_level_buttons are added to the screen when this icon in_level_buttons is clicked.
  /// If buttons are already on the screen, they are then removed from the screen when
  /// this icon in_level_buttons is clicked.
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Menu Button clicked');
      !contains(restartLevel) ? addDropDownButtons() : removeDropDownButtons();
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }

  /// Unused
  @override
  bool onHoverEnter(PointerHoverInfo info){
    try{
      print('Menu Button hovered');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }

  /// Unused
  @override
  bool onHoverLeave(PointerHoverInfo info){
    try{
      print('Menu Button leaved');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}