import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/modules/button/abstract/positional_values.dart';

import '../dropdown_button.dart';
// -Justin
class MenuButton extends SpriteComponent with Tappable,Hoverable{
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final DropDownButton restartLevel;
  late final DropDownButton goToPreviousLevel;
  late final DropDownButton restartGame;

  Future<void> setDropDownButtons() async{
    restartLevel = DropDownButton(text: " Restart Level", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(0.0)));
    goToPreviousLevel = DropDownButton(text: "Go To Previous Level", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.leftSideButtonX, position.y+PositionalValues.nextY(1.0)));
    restartGame = DropDownButton(text: "  Restart Game", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
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