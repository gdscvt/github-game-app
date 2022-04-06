import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_game/github_game.dart';
import 'package:github_game/terminal.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: Scaffold(body: App())));
}

class App extends StatefulWidget {
  static TerminalScreen? terminalScreen;
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final game = GithubGame();
  dynamic terminal;
  late Future _future;

  var size, height, width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = readJson();
  }

  Future<dynamic> readJson() async {
    final String response =
        await rootBundle.loadString('assets/levels/level_one/level1.json');

    final data = await jsonDecode(response);

    return data;
    // setState(() {
    //   terminal = Terminal(data);
    // });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Stack(
      children: <Widget>[
        GameWidget(game: game),
        FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                terminal ??= Terminal(snapshot.data, game);

                return App.terminalScreen ??=
                    TerminalScreen(terminal: terminal);
              }
              return Text('Loading');
            })
      ],
    );
  }
}

class TerminalScreen extends StatefulWidget {
  final terminal;
  // late dynamic focusNode;
  late _TerminalScreenState state;
  TerminalScreen({Key? key, required this.terminal}) : super(key: key);

  @override
  State<TerminalScreen> createState() {
    return state = _TerminalScreenState();
  }
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController _controller = TextEditingController(text: '> ');
  String display = "";
  bool isDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return isDisplayed
        ? Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.4,
              heightFactor: 0.5,
              child: Container(
                color: Colors.blueGrey,
                margin: const EdgeInsets.only(right: 50),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SizedBox.expand(
                        child: Container(
                          color: Colors.black,
                          margin: const EdgeInsets.all(20),
                          child: Text(
                            display,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox.expand(
                          child: Container(
                        color: Colors.black,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          focusNode: FocusNode(canRequestFocus: false),
                          controller: _controller,
                          onSubmitted: (value) {
                            widget.terminal.parse(_controller.text);
                            setState(() {
                              display = widget.terminal
                                  .display; // TODO: Just use terminal.display
                            });
                          },
                          cursorColor: Colors.green,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(color: Colors.green),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
