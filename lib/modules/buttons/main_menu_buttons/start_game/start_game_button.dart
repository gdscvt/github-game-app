
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';

class StartGameButton extends TextBoxComponent {

  @override
  bool onTapDown(TapDownInfo e) {
    try {
      print('Start Game Button Clicked');
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width / 1.1, height * 1.1);
    final paint = Paint()
    //..color = Color(0xFF182c4f)
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
          colors: [Color(0xFF2f62ba), Color(0xFF182c4f)]).createShader(rect);
    c.drawOval(
        rect,
        //rect.deflate(box.margins.right),//could be left,top,right or bottom
        paint);
  }
}