import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// Super class for each dropdown in_level_buttons
class DropDownButton extends TextBoxComponent with Tappable, Hoverable{

  late final String text;
  late final style;
  late final box;
  late final positional;
  late final screenWidth;
  late final screenHeight;

  /// Constructor is used to set properties from a TextBoxComponent. screenWidth and
  /// screenHeight are not related to any of the TextBoxComponents. They are used for
  /// centering each DropDownButton's popUp relative to the screen's dimensions
  DropDownButton({required this.text, this.style, this.box, this.positional, this.screenWidth, this.screenHeight}) :
        super(text: text, textRenderer: style, boxConfig: box, position: positional);

  /// This builds the oval shape with a gradient for each dropdown in_level_buttons
  @override
  void drawBackground(Canvas c){
    Rect rect = Rect.fromLTWH(0, 0, width/1.1, height*1.1);
    final paint = Paint()
    //..color = Color(0xFF182c4f)
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
    colors: [Color(0xFF2f62ba), Color(0xFF182c4f)]).createShader(rect);
    c.drawOval(
        rect,//rect.deflate(box.margins.right),//could be left,top,right or bottom
        paint);
  }



}