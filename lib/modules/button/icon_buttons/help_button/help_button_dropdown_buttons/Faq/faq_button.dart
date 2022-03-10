import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_game/modules/button/icon_buttons/model/dropdown_button.dart';
import '../../../abstract/positional_values.dart';
import 'faq_popUp.dart';
/// FaqButton class -Justin
class FaqButton extends DropDownButton{
  /// This button's constructor contains the same parameters as
  /// the DropDownButton parent class. The parent class then passes those parameters
  /// to the TextBoxComponent class
  late final data;
  FaqButton({required String text, style, box, positional, screenWidth, screenHeight}) :
        super(text: text, style: style, box: box, positional: positional, screenWidth: screenWidth, screenHeight: screenHeight) {
        /// data is a boilerplate for setting the associated button's popUp
        data = FaqPopUp(text: 'test',
        box: TextBoxConfig(margins: const EdgeInsets.all(8.0), maxWidth: 150.0),
        positional: Vector2(-screenWidth/4, screenHeight/4));
  }

  /// If the screen does not contain the associated button's popUp
  /// then the popUp is added to the screen when this DropDown button is clicked.
  /// If the popUp is already on the screen, then the popUp is removed when this
  /// DropDown button is clicked.
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print("Faq Button Tapped");
      !contains(data) ? add(data) : remove(data);
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}