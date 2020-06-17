import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tttBrain.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: TicTacToeScreen())),
    ),
  );
}

class TicTacToeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider(
      create: (_) => TicTacToeGame(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RotatedBox(
            quarterTurns: -2,
            child: Container(
              height: 40,
              color: Colors.red,
              child: Center(
                child: Text(
                  "Player 1",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Board(),
          Container(
            height: 10,
          ),
          Container(
            height: 40,
            color: Colors.blue,
            child: Center(
              child: Text(
                "Player 2",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Widget buildScore(tttGame, player) {
    List<Widget> scoreWidgets = [];
    print(tttGame.scoreList);
    tttGame.scoreList[player].forEach((score) {
      scoreWidgets.add(Icon(Icons.stars, color: Colors.yellowAccent[400]));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: scoreWidgets,
    );
  }

  Widget buildGrid(tttGame) {
    List<Widget> grid = [];
    for (var i = 0; i < 9; i++) {
      grid.add(
        GestureDetector(
          child: AnimatedContainer(
            color: tttGame.grid[i] == 0
                ? Colors.grey
                : tttGame.grid[i] == 1 ? Colors.red : Colors.blue,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInSine,
          ),
          onTap: () {
            print(i);
            setState(() {
              tttGame.updatePlayer(i);
              print(tttGame.grid);
            });
          },
        ),
      );
    }
    return GridView.count(
      physics: new NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: grid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RotatedBox(
          quarterTurns: -2,
          child: Container(
            height: 40,
            child: Consumer<TicTacToeGame>(builder: (context, tttGame, child) {
              return buildScore(tttGame, 0);
            }),
          ),
        ),
        SizedBox(
          height: 400,
          width: 400,
          child: Consumer<TicTacToeGame>(builder: (context, tttGame, child) {
            return buildGrid(tttGame);
          }),
        ),
        Container(
          height: 40,
          child: Consumer<TicTacToeGame>(builder: (context, tttGame, child) {
            return buildScore(tttGame, 1);
          }),
        ),
      ],
    );
  }
}
