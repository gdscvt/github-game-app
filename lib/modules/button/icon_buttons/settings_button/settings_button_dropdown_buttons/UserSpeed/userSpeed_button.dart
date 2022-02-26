import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_game/modules/button/icon_buttons/model/dropdown_button.dart';
import '../../../abstract/positional_values.dart';
import 'userSpeed_popUp.dart';

class UserSpeedButton extends DropDownButton{
  UserSpeedButton({required String text, style, box, positional}) : super(text: text, style: style, box: box, positional: positional);
  static final data = UserSpeedPopUp(text: 'test', box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
      positional: Vector2(100,
          PositionalValues.nextY(0.0)));

  @override
  bool onTapDown(TapDownInfo e){
    try{
      print("User Speed Button Tapped");
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