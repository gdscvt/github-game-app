import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'help_button_dropdown_buttons/AboutGame/aboutGame_button.dart';
import '../abstract/positional_values.dart';
import 'help_button_dropdown_buttons/Contents/contents_button.dart';
import 'help_button_dropdown_buttons/Faq/faq_button.dart';
/// HelpButton class -Justin
class HelpButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final ContentsButton contents;
  late final FaqButton faq;
  late final AboutGameButton aboutGame;
  /// This function initalizes the dropdown buttons and sets their properties.
  /// The screenWidth and screenHeight parameters are needed from github_game to
  /// then be passed to each individual dropdown in_level_buttons
  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async {
    contents = ContentsButton(text: "      Contents",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX * width,
            PositionalValues.nextY(0.0)), screenWidth: screenWidth, screenHeight: screenHeight);
    faq = FaqButton(text: "      FAQ",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(1.0)), screenWidth: screenWidth, screenHeight: screenHeight);
    aboutGame = AboutGameButton(text: "      About Game",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(2.0)), screenWidth: screenWidth, screenHeight: screenHeight);
  }

  /// Adds buttons to the screen
  Future<void> addDropDownButtons() async{
    await add(contents);
    await add(faq);
    await add(aboutGame);
  }

  /// Removes buttons from the screen
  Future<void> removeDropDownButtons() async{
    remove(contents);
    remove(faq);
    remove(aboutGame);
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
      print('Help Button clicked');
      !contains(contents) ? addDropDownButtons() : removeDropDownButtons();
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
      print('Help Button hovered');
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
      print('Help Button leaved');
        return true;

    }catch(err){
      print(err);
      return false;
    }
  }
}


