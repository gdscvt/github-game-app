import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'abstract/positional_values.dart';
import 'dropdown_button.dart';
// -Justin
class SettingsButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final DropDownButton userSpeed;
  late final DropDownButton userAppearance;

  Future<void> setDropDownButtons() async{
    userSpeed = DropDownButton("     User Speed", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(0.0)));
    userAppearance = DropDownButton("     User Appearance", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(1.0)));
  }
  Future<void> addDropDownButtons() async{
    await add(userSpeed);
    await add(userAppearance);
  }
  void removeDropDownButtons(){
    remove(userSpeed);
    remove(userAppearance);
  }
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Settings Button clicked');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
  @override
  bool onHoverEnter(PointerHoverInfo info){
    try{
      print('Settings Button hovered');
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
      print('Settings Button leaved');
      removeDropDownButtons();
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}