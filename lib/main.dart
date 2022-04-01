import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_game/github_game.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: App())));
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var size, height, width;
  String display = "1";
  final TextEditingController _controller = TextEditingController();
  final game = GithubGame();
  late final _focusNode = FocusNode(onKey: (FocusNode node, RawKeyEvent evt) {
    if (evt.logicalKey.keyLabel == "Enter") {
      if (evt is RawKeyDownEvent) {
        display += _controller.text;
      }
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Stack(
      children: <Widget>[
        GameWidget(game: game),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: FractionallySizedBox(
        //     widthFactor: 0.4,
        //     heightFactor: 0.5,
        //     child: Container(
        //       color: Colors.blueGrey,
        //       margin: const EdgeInsets.only(right: 50),
        //       child: Column(
        //         children: <Widget>[
        //           Expanded(
        //             flex: 3,
        //             child: SizedBox.expand(
        //               child: Container(
        //                 color: Colors.black,
        //                 margin: const EdgeInsets.all(20),
        //                 child: Text(
        //                   display,
        //                   style: TextStyle(color: Colors.green),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             flex: 1,
        //             child: SizedBox.expand(
        //               child: Container(
        //                   color: Colors.black,
        //                   margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        //                   padding: const EdgeInsets.all(10),
        //                   child: TextField(
        //                     focusNode: _focusNode,
        //                     controller: _controller,
        //                     // textInputAction: TextInputAction.next,
        //                     autofocus: true, // Not working
        //                     cursorColor: Colors.green,
        //                     decoration:
        //                         InputDecoration(border: InputBorder.none),
        //                     style: TextStyle(color: Colors.green),
        //                   )),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
