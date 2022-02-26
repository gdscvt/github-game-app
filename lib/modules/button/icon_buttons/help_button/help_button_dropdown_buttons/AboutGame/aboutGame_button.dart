import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_game/modules/button/icon_buttons/model/dropdown_button.dart';
import '../../../abstract/positional_values.dart';
import 'aboutGame_popUp.dart';

class AboutGameButton extends DropDownButton{
  late final data;
  AboutGameButton({required String text, style, box, positional, screenWidth, screenHeight}) :

        super(text: text, style: style, box: box, positional: positional, screenWidth: screenWidth, screenHeight: screenHeight) {
        data = AboutGamePopUp(text: 'test',
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(-screenWidth/4, screenHeight/4));
  }

  @override
  bool onTapDown(TapDownInfo e){
    try{
      print("About Game Button Tapped");
      if(!contains(data)){
        add(data);
      }else{
        remove(data);
      }
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}