import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/modules/buttons/in_level_buttons/icon_buttons/menu_button/menu_button.dart';
import 'package:flame/src/game/mixins/game.dart';


abstract class CurrentLevel extends FlameGame{
  static GithubGame game = GithubGame('level_one.tmx');
  static GameWidget gameWidget = GameWidget(game: game);
}
void main() {


  runApp(CurrentLevel.gameWidget);

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

