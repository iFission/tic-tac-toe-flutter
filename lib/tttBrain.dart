import 'dart:io';
import 'package:flutter/material.dart';

class TicTacToeGame extends ChangeNotifier {
  List<int> _grid = new List<int>.filled(9, 0);
  List<List<int>> combinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  int turn = 1;

  List<List<bool>> _scoreList = [[], []];

  List<int> get grid => _grid;
  List<List<bool>> get scoreList => _scoreList;

  bool checkWin(int player) {
    combinations.forEach(
      (combination) {
        if (belongToPlayer(combination[0], player) &&
            belongToPlayer(combination[1], player) &&
            belongToPlayer(combination[2], player)) {
          print('player $player win');
          _scoreList[player - 1].add(true);
          _grid = new List<int>.filled(9, 0);
        }
      },
    );
    return false;
  }

  bool checkStalemate() {
    return !_grid.contains(0);
  }

  bool belongToPlayer(int gridIndex, int player) {
    return _grid[gridIndex] == player;
  }

  void move(int gridIndex) {
    if (_grid[gridIndex] == 0) {
      _grid[gridIndex] = turn;
      checkWin(turn);
      turn = turn % 2 + 1;
    }
  }

  void updatePlayer(int gridIndex) {
    move(gridIndex);
    notifyListeners();

    if (checkStalemate()) {
      sleep(Duration(microseconds: 100));
      _grid = new List<int>.filled(9, 0);
    }
  }
}
