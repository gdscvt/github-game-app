import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/button/abstract/positional_values.dart';
import 'package:github_game/modules/button/icon_buttons/help_button/help_button_dropdown_buttons/AboutGame/aboutGame_button.dart';
import 'package:github_game/modules/button/icon_buttons/help_button/help_button_dropdown_buttons/help_dropdown.dart';

import '../dropdown_button.dart';
// -Justin
class HelpButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final DropDownButton contents;
  late final DropDownButton faq;
  late final AboutGameButton aboutGame;
  Future<void> setDropDownButtons() async {
    contents = HelpDropdownButton(text: "      Contents",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX * width,
            PositionalValues.nextY(0.0)));
    faq = HelpDropdownButton(text: "      FAQ",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(1.0)));
    aboutGame = AboutGameButton(text: "      About Game",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(2.0)));
  }
  Future<void> addDropDownButtons() async{
    await add(contents);
    await add(faq);
    await add(aboutGame);
  }
  Future<void> removeDropDownButtons() async{
    remove(contents);
    remove(faq);
    remove(aboutGame);
  }
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Help Button clicked');

      if(!contains(contents)){
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
      print('Help Button hovered');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
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


