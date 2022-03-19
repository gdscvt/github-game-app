import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:github_game/main.dart';
import '../../../../../../../github_game.dart';
import '../../../model/dropdown_button.dart';
import 'restartGame_popUp.dart';
/// RestartGameButton class -Justin
class RestartGameButton extends DropDownButton{
  /// This in_level_buttons's constructor contains the same parameters as
  /// the DropDownButton parent class. The parent class then passes those parameters
  /// to the TextBoxComponent class
  late final data;
  RestartGameButton({required String text, style, box, positional, screenWidth, screenHeight}) :
        super(text: text, style: style, box: box, positional: positional, screenWidth: screenWidth, screenHeight: screenHeight) {
        /// data is a boilerplate for setting the associated in_level_buttons's popUp
        this.positionType = PositionType.widget;
        data = RestartGamePopUp(text: 'test',
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(-screenWidth/4, screenHeight/4));
  }

  /// If the screen does not contain the associated in_level_buttons's popUp
  /// then the popUp is added to the screen when this DropDown in_level_buttons is clicked.
  /// If the popUp is already on the screen, then the popUp is removed when this
  /// DropDown in_level_buttons is clicked.
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print("Restart Game Button Tapped");
      !contains(data) ? add(data) : remove(data);
      /// Changes level to main menu
      String json = getMainMenu() as String;
      CurrentLevel.game.newLevel(jsonDecode(json));

      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
  @override
  bool onHoverEnter(PointerHoverInfo e){
    try{
      print('Restart Game Button Hovered');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
  Future<String> getMainMenu() async{
    return await rootBundle.loadString("$GithubGame.LEVEL_PATH/level.json");
  }

}