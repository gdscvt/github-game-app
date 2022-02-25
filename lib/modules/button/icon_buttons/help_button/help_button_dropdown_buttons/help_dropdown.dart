import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/button/icon_buttons/dropdown_button.dart';


import '../../../abstract/positional_values.dart';
import '../help_button.dart';

class HelpDropdownButton extends DropDownButton{
  HelpDropdownButton({required String text, style, box, positional}) : super(text: text, style: style, box: box, positional: positional);
  @override
  bool onHoverEnter(PointerHoverInfo e){
    try{
      print("Help Button Dropdown entered");
      return true;
    }catch(err){
      return false;
    }
  }
  @override
  bool onHoverLeave(PointerHoverInfo e){
    try{
      print("Help Button Dropdown leaved");
      return true;
    }catch(err){
      return false;
    }
  }

}