import 'package:flutter/widgets.dart';
/// This class was adapted from an older project of mine. It essentially
/// gets the size of the screen for the device. -Justin
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  /// Sets the static variables of SizeConfig
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
  }
}