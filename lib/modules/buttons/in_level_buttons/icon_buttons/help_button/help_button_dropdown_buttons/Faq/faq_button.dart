import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import '../../../model/dropdown_button.dart';
import 'faq_popUp.dart';
/// FaqButton class -Justin
class FaqButton extends DropDownButton{
  /// This in_level_buttons's constructor contains the same parameters as
  /// the DropDownButton parent class. The parent class then passes those parameters
  /// to the TextBoxComponent class
  late final data;
  FaqButton({required String text, style, box, positional, screenWidth, screenHeight}) :
        super(text: text, style: style, box: box, positional: positional, screenWidth: screenWidth, screenHeight: screenHeight) {
        this.positionType = PositionType.widget;
        /// data is a boilerplate for setting the associated in_level_buttons's popUp
        data = FaqPopUp(text: 'test',
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
      print("Faq Button Tapped");
      !contains(data) ? add(data) : remove(data);
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}