import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/modules/button/abstract/positional_values.dart';

import 'dropdown_button.dart';
// -Justin
class HelpButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final DropDownButton contents;
  late final DropDownButton faq;
  late final DropDownButton aboutGame;

  Future<void> setDropDownButtons() async{
    contents = DropDownButton("      Contents", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(0.0)));
    faq = DropDownButton("      FAQ", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(1.0)));
    aboutGame = DropDownButton("      About Game", reg, TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        Vector2(PositionalValues.rightSideButtonX*width, position.y+PositionalValues.nextY(2.0)));
  }
  Future<void> addDropDownButtons() async{
    await add(contents);
    await add(faq);
    await add(aboutGame);
  }
  void removeDropDownButtons(){
    remove(contents);
    remove(faq);
    remove(aboutGame);
  }
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Help Button clicked');
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
      print('Help Button leaved');
      removeDropDownButtons();
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}
