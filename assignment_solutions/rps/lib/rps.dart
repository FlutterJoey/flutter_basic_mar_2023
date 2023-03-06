import 'dart:math' as math;

const rock = 0;
const paper = 1;
const scissors = 2;

const String win = 'Player 1 Wins';
const String lose = 'Player 2 Wins';
const String draw = 'Both players had the same answer';

String _printChoice(int choice) {
  if (choice == rock) {
    return 'rock';
  }
  if (choice == paper) {
    return 'paper';
  }
  return 'scissors';
}

void _printPlayerChoice(int player, int choice) {
  print('Player $player has chosen ${_printChoice(choice)}');
}

String rockPaperScissors({required int player1, int? player2}) {
  player2 ??= math.Random().nextInt(3);
  _printPlayerChoice(1, player1);
  _printPlayerChoice(2, player2);
  return _calculateResult(player1, player2);
}

String _calculateResult(int player1, int player2) {
  if (player1 == player2) {
    return draw;
  }
  if (player1 - player2 == 1 || player1 - player2 == -2) {
    return win;
  }
  return lose;
}
