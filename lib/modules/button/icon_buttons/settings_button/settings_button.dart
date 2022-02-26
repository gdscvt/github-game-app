import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/modules/button/icon_buttons/settings_button/settings_button_dropdown_buttons/UserAppearance/userAppearance_button.dart';
import 'package:github_game/modules/button/icon_buttons/settings_button/settings_button_dropdown_buttons/UserSpeed/userSpeed_button.dart';
import '../abstract/positional_values.dart';
// -Justin
class SettingsButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final UserSpeedButton userSpeed;
  late final UserAppearanceButton userAppearance;

  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async{
    userSpeed = UserSpeedButton(text: "     User Speed", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(0.0)));
    userAppearance = UserAppearanceButton(text: "     User Appearance", style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(1.0)));
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
      if(!contains(userSpeed)){
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
      print('Settings Button hovered');
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
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}