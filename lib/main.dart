import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_game/github_game.dart';

class CurrentLevel{
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

