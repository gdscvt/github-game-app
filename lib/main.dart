import 'dart:convert';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_game/github_game.dart';

import 'level.dart';
import 'modules/size_config.dart';


abstract class CurrentLevel extends FlameGame{
  /// Declares game
  static GithubGame game = GithubGame('level_one.tmx');
  /// Pause Menu overlay. Needs to look nicer but is setup
  static Widget _pauseMenu(BuildContext context, Game game){
    /// SizeConfig is initialized based on screen
    SizeConfig().init(context);
    return Center(
        /// Builds blue menu box attached to AboutGame for now
        child: Container(
            width: SizeConfig.screenWidth!*(1/4),
            height: SizeConfig.screenHeight!*(1/4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2f62ba), Color(0xFF182c4f)])
            ),
            /// Wrapped in a column, creates 4 Textbuttons named "Change Level".
            /// To be changed.
            child: Column(
                children: [
                  Padding(
                    /// Padding value should be relative to screenHeight
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async{
                      try {
                        String json = await rootBundle.loadString("assets/levels/main_menu/main_menu.json");
                        CurrentLevel.game.newLevel(Level.fromJson(jsonDecode(json)));
                      }catch(err){
                        print(err);
                      }
                    }, child: const Text('Change Level',
                    style: const TextStyle(color: Color(0xFFFFAF3C)),),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.amber,
                      primary: Color(0xFF571370),
                      elevation: 50.0,
                    ),),
                  ),
                  Padding(
                    /// Padding value should be relative to screenHeight
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async{
                        try {
                          String json = await rootBundle.loadString("$GithubGame.LEVEL_PATH/main_menu/main_menu.json");
                          CurrentLevel.game.newLevel(Level.fromJson(jsonDecode(json)));
                        }catch(err){
                          print(err);
                        }
                      }, child: const Text('Change Level',
                      style: const TextStyle(color: Color(0xFFFFAF3C)),),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.amber,
                        primary: Color(0xFF571370),
                        elevation: 50.0,
                      ),),
                  ),
                  Padding(
                    /// Padding value should be relative to screenHeight
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async{
                        try {
                          String json = await rootBundle.loadString("$GithubGame.LEVEL_PATH/main_menu/main_menu.json");
                          CurrentLevel.game.newLevel(Level.fromJson(jsonDecode(json)));
                        }catch(err){
                          print(err);
                        }
                      }, child: const Text('Change Level',
                      style: const TextStyle(color: Color(0xFFFFAF3C)),),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.amber,
                        primary: Color(0xFF571370),
                        elevation: 50.0,
                      ),),
                  ),
                  Padding(
                    /// Padding value should be relative to screenHeight
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async{
                        try {
                          String json = await rootBundle.loadString("$GithubGame.LEVEL_PATH/main_menu/main_menu.json");
                          CurrentLevel.game.newLevel(Level.fromJson(jsonDecode(json)));
                        }catch(err){
                          print(err);
                        }
                      }, child: const Text('Change Level',
                      style: const TextStyle(color: Color(0xFFFFAF3C)),),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.amber,
                        primary: Color(0xFF571370),
                        elevation: 50.0,
                      ),),
                  ),
                ]
            )
        )
    );
  }
  /// Declares GameWidget
  static GameWidget gameWidget = GameWidget(game: game,
  /// The map(String, Widget Function) for overlay map
    /// See the aboutGame_button.dart file to understand how to add overlay to screen
  overlayBuilderMap: const{
    'PauseMenu': _pauseMenu,
  },);
}
void main() {
  //runApp(CurrentLevel.gameWidget);
  runApp(MaterialApp(
    home: CurrentLevel.gameWidget
  ));
}

/*
class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();

}
class _GameState extends State<Game>{
  GithubGame game2 = GithubGame('level_one.tmx');
  _GameState();
  void changeOverlay(){
    game2.overlay.add('Pause Menu');
  }
  Widget MainMenu(BuildContext buildContext, GithubGame game){
    return Center(
      child: Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Column(
          children: [
        FlatButton(onPressed: (){
            try {
              game2.mapPath = 'main_menu.tmx';
              game2.update(3.0);
            }catch(err){
              print(err);
            }
        }, child: const Text('Change tmx'))
          ]
        )
      )
    );
  }
  @override
  Widget build(BuildContext  context) {
    return GameWidget(
      game: game2,
      overlayBuilderMap: {
        'MainMenu': MainMenu,
        },
      initialActiveOverlays: const ['MainMenu'],
    );
  }
  }
*/

