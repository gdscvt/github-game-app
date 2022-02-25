import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// -Justin
class DropDownButton extends TextBoxComponent with Tappable, Hoverable{

  late final String text;
  late final style;
  late final box;
  late final positional;


  DropDownButton({required this.text, this.style, this.box, this.positional}) : super(text: text, textRenderer: style, boxConfig: box, position: positional);
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