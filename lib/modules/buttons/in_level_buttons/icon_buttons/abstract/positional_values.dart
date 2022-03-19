/*
  Used to encapsulate values of x and y coordinates of dropDownButtons
  Could be used for additional values -Justin
 */
abstract class PositionalValues {
  /*
    firstRelativeY is a set y for the dropdown buttons from the icons.
    leftSideButtonX and rightButtonX define relative x positions for the dropdown
    buttons from the icons
   */
  static double firstRelativeY = 45.0;
  static double leftSideButtonX = -5.0;
  static double rightSideButtonX = -2.0;

  static double nextY(double row) {
    return firstRelativeY + (35.0 * row);
  }
}