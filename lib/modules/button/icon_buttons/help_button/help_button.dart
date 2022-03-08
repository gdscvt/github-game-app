import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:github_game/modules/button/icon_buttons/help_button/help_button_dropdown_buttons/AboutGame/aboutGame_button.dart';
import 'package:github_game/modules/button/icon_buttons/help_button/help_button_dropdown_buttons/Faq/faq_button.dart';
import '../abstract/positional_values.dart';
import '../model/dropdown_button.dart';
import 'help_button_dropdown_buttons/Contents/contents_button.dart';
// -Justin
class HelpButton extends SpriteComponent with Tappable,Hoverable {
  static final TextStyle style = TextStyle(color:Colors.white);
  static final TextPaint reg = TextPaint(style: style);
  late final ContentsButton contents;
  late final FaqButton faq;
  late final AboutGameButton aboutGame;

  Future<void> setDropDownButtons({required int screenWidth, required int screenHeight}) async {
    contents = ContentsButton(text: "      Contents",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX * width,
            PositionalValues.nextY(0.0)));
    faq = FaqButton(text: "      FAQ",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(1.0)));
    aboutGame = AboutGameButton(text: "      About Game",
        style: reg,
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(PositionalValues.rightSideButtonX*width,
            0 + PositionalValues.nextY(2.0)), screenWidth: screenWidth, screenHeight: screenHeight);
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
      !contains(contents) ? addDropDownButtons() : removeDropDownButtons();
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


