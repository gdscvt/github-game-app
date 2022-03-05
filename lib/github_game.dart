import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_game/level.dart';
import 'package:flame/input.dart';
import 'package:github_game/modules/button/icon_buttons/model/dropdown_button.dart';
import 'package:github_game/modules/button/icon_buttons/help_button/help_button.dart';
import 'package:github_game/modules/button/icon_buttons/menu_button/menu_button.dart';
import 'modules/button/icon_buttons/settings_button/settings_button.dart';

/*
  This class represents the game with a specified level. Added HasTappables -Justin
*/
class GithubGame extends FlameGame with HasKeyboardHandlerComponents, HasTappables, HasHoverables {
  // The directory holding animation assets
  static const String ANIMATION_FILE_PATH = "animations";

  // Directory for button sprites -Justin
  static const String BUTTON_SPRITES_FILE_PATH = "button_sprites";

  // Button sizes -Justin
  static const double BUTTON_SIZE = 50.0;

  // The size in pixels of each tile
  static final Vector2 TILE_SIZE = Vector2.all(48.0);

  // Reference to the loaded level
  late final Level level;

  // The file path to the tile map-
  late final String _mapPath;

  //Instantiates Menu Button and associated size -Justin
  MenuButton menuButton = MenuButton();
  static final Vector2 MENUBUTTON_SIZE = Vector2.all(BUTTON_SIZE);

  //Instantiates Help Button and associated size -Justin
  HelpButton helpButton = HelpButton();
  static final Vector2 HELPBUTTON_SIZE = Vector2.all(BUTTON_SIZE);

  //Instantiates Help Button and associated size -Justin
  SettingsButton settingsButton = SettingsButton();
  static final Vector2 SETTINGSBUTTON_SIZE = Vector2.all(BUTTON_SIZE);



  GithubGame(this._mapPath);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(level = Level(_mapPath, Position(5, 5)));

    // First value is how many tiles fill map in width. Second value
    // is width of a single tile. Multiplying them gets us the screenWidth. -Justin
    int screenWidth = level.mapModule.map.width*level.mapModule.map.tileWidth;
    int screenHeight = level.mapModule.map.height*level.mapModule.map.tileHeight;

    //Sets properties of buttons. -Justin
    menuButton
      ..sprite = await loadSprite('$BUTTON_SPRITES_FILE_PATH/home_grey.png')
      ..size = MENUBUTTON_SIZE
      ..position = Vector2((1/140)*screenWidth, (1/150)*screenHeight);
    helpButton
      ..sprite = await loadSprite('$BUTTON_SPRITES_FILE_PATH/help_grey.png')
      ..size = HELPBUTTON_SIZE
      ..position = Vector2((1/1.3)*screenWidth, (1/150)*screenHeight);
    settingsButton
      ..sprite = await loadSprite('$BUTTON_SPRITES_FILE_PATH/settings_grey.png')
      ..size = SETTINGSBUTTON_SIZE
      ..position = Vector2((1/1.135)*screenWidth, (1/150)*screenHeight);

    menuButton.setDropDownButtons(screenWidth: screenWidth, screenHeight: screenHeight);
    helpButton.setDropDownButtons(screenWidth: screenWidth, screenHeight: screenHeight);
    settingsButton.setDropDownButtons(screenWidth: screenWidth, screenHeight: screenHeight);
    // Await needed to load one component at a time otherwise they
    // won't load on same screen. -Justin
    await add(menuButton);
    await add(helpButton);
    await add(settingsButton);

  }
}
