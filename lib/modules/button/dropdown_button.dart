import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
// -Justin
class DropDownButton extends TextBoxComponent with Tappable{

  late final String text;
  late final style;
  late final box;
  late final positional;


  DropDownButton(this.text, this.style, this.box, this.positional) : super(text: text, textRenderer: style, boxConfig: box, position: positional);
  @override
  void drawBackground(Canvas c){
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(
        rect.deflate(box.margins.right),//could be left,top,right or bottom
        Paint()
          ..color = BasicPalette.black.color
          ..style = PaintingStyle.fill);

  }
}