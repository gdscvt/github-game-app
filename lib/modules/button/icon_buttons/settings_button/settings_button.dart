import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/modules/button/icon_buttons/settings_button/settings_button_dropdown_buttons/UserAppearance/userAppearance_button.dart';
import 'package:github_game/modules/button/icon_buttons/settings_button/settings_button_dropdown_buttons/UserSpeed/userSpeed_button.dart';
import '../abstract/positional_values.dart';
/// SettingsButton class -Justin
class SettingsButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final UserSpeedButton userSpeed;
  late final UserAppearanceButton userAppearance;
  /// This function initalizes the dropdown buttons and sets their properties.
  /// The screenWidth and screenHeight parameters are needed from github_game to
  /// then be passed to each individual dropdown button
  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async{
    userSpeed = UserSpeedButton(text: "     User Speed",
        style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(0.0)),
        screenWidth: screenWidth, screenHeight: screenHeight);
    userAppearance = UserAppearanceButton(text: "     User Appearance",
        style: reg, box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(1.0)),
        screenWidth: screenWidth, screenHeight: screenHeight);
  }

  /// Adds buttons to the screen
  Future<void> addDropDownButtons() async{
    await add(userSpeed);
    await add(userAppearance);
  }

  /// Removes buttons from the screen
  void removeDropDownButtons(){
    remove(userSpeed);
    remove(userAppearance);
  }

  /// Note: icon button is not a parent class. This class contains the blueprint
  /// for the functionality and data of the icon on the screen.
  /// If the screen does not contain the dropdown buttons(all buttons are added and
  /// removed together) then the button are added to the screen when this icon button is clicked.
  /// If buttons are already on the screen, they are then removed from the screen when
  /// this icon button is clicked.
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Settings Button clicked');
      !contains(userSpeed) ? addDropDownButtons() : removeDropDownButtons();
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
      print('Settings Button hovered');
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
      print('Settings Button leaved');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}