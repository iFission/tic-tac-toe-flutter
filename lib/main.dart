import 'package:flutter/material.dart';
import 'tttBrain.dart';

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
    return Column(
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
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  TicTacToeGame tttGame = TicTacToeGame();

  List<Widget> scoreBuilder(player) {
    List<Widget> scoreWidgets = [];
    tttGame.scoreList[player].forEach((score) {
      scoreWidgets.add(score
          ? Icon(Icons.check, color: Colors.green)
          : Icon(Icons.close, color: Colors.red));
    });
    return scoreWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RotatedBox(
          quarterTurns: -2,
          child: Container(
            height: 40,
            child: Row(
              children: scoreBuilder(0),
            ),
          ),
        ),
        SizedBox(
          height: 400,
          width: 400,
          child: GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: buildGrid(),
          ),
        ),
        Container(
          height: 40,
          child: Row(
            children: scoreBuilder(1),
          ),
        ),
      ],
    );
  }

  List<Widget> buildGrid() {
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
    return grid;
  }
}
