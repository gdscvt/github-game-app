import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:github_game/github_game.dart';

void main() {
  final game = GithubGame("level_one.tmx");

  runApp(GameWidget(game: game));
}
