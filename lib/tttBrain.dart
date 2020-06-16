class TicTacToeGame {
  List<int> grid = new List<int>.filled(9, 0);
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

  List<List<bool>> scoreList = [[], []];

  bool checkWin(int player) {
    combinations.forEach(
      (combination) {
        if (belongToPlayer(combination[0], player) &&
            belongToPlayer(combination[1], player) &&
            belongToPlayer(combination[2], player)) {
          print('player $player win');
          scoreList[player - 1].add(true);
          this.grid = new List<int>.filled(9, 0);
        }
      },
    );
    return false;
  }

  bool belongToPlayer(int gridIndex, int player) {
    return grid[gridIndex] == player;
  }

  bool updatePlayer(int gridIndex) {
    if (grid[gridIndex] == 0) {
      grid[gridIndex] = turn;
      if (checkWin(turn)) {
        return true;
      }
      turn = turn % 2 + 1;
    }
  }
}
