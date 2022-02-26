import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../abstract/positional_values.dart';
import 'menu_button_dropdown_buttons/GoToPreviousLevel/goToPreviousLevel_button.dart';
import 'menu_button_dropdown_buttons/RestartGame/restartGame_button.dart';
import 'menu_button_dropdown_buttons/RestartLevel/restartLevel_button.dart';
// -Justin
class MenuButton extends SpriteComponent with Tappable,Hoverable{
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final RestartLevelButton restartLevel;
  late final GoToPreviousLevelButton goToPreviousLevel;
  late final RestartGameButton restartGame;

  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async{
    restartLevel = RestartLevelButton(text: " Restart Level", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(0.0)));
    goToPreviousLevel = GoToPreviousLevelButton(text: "Go To Previous Level", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(1.0)));
    restartGame = RestartGameButton(text: "  Restart Game", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(2.0)));
  }
  Future<void> addDropDownButtons() async{
  await add(restartLevel);
  await add(goToPreviousLevel);
  await add(restartGame);
}
   void removeDropDownButtons(){
    remove(restartLevel);
    remove(goToPreviousLevel);
    remove(restartGame);
  }
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Menu Button clicked');
      if(!contains(restartLevel)){
        addDropDownButtons();
      }
      else{
        removeDropDownButtons();
      }
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
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