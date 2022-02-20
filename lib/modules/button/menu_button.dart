import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'dropdown_button.dart';
// -Justin
class MenuButton extends SpriteComponent with Tappable,Hoverable{
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final DropDownButton restartLevel;
  late final DropDownButton goToPreviousLevel;
  late final DropDownButton restartGame;

  Future<void> setDropDownButtons() async{
    restartLevel = DropDownButton("Restart Level", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(-5, position.y+35));
    goToPreviousLevel = DropDownButton("Go To Previous Level", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(-5, position.y+50));
    restartGame = DropDownButton("Restart Game", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(-5, position.y+65));
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
      addDropDownButtons();
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
      removeDropDownButtons();
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}