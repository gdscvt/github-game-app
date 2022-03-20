import 'package:flame/components.dart';
import 'package:flame/input.dart';
import '../../../../../main.dart';

/// MenuButton class -Justin
class MenuButton extends SpriteComponent with Tappable,Hoverable{


  /// Note: icon in_level_buttons is not a parent class. This class contains the blueprint
  /// for the functionality and data of the icon on the screen.
  /// If the screen does not contain the dropdown buttons(all buttons are added and
  /// removed together) then the in_level_buttons are added to the screen when this icon in_level_buttons is clicked.
  /// If buttons are already on the screen, they are then removed from the screen when
  /// this icon in_level_buttons is clicked.
  @override
  bool onTapDown(TapDownInfo e){
    try{
      print('Menu Button clicked');
      /// Removes menu from screen if active. Else adds menu to screen
      CurrentLevel.gameWidget.game.overlays.isActive('PauseMenu') ?
      CurrentLevel.gameWidget.game.overlays.remove('PauseMenu') :
      CurrentLevel.gameWidget.game.overlays.add('PauseMenu');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }

  /// Unused
  @override
  bool onHoverEnter(PointerHoverInfo info){
    try{
      print('Menu Button hovered');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }

  /// Unused
  @override
  bool onHoverLeave(PointerHoverInfo info){
    try{
      print('Menu Button leaved');
      return true;
    }catch(err){
      print(err);
      return false;
    }
  }
}