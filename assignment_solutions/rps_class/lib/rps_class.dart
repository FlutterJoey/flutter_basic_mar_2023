class RpsGame {
  final String player1;
  final String player2;

  RpsGame({
    required this.player1,
    required this.player2,
  });

  Rps? _player1Pick;
  Rps? _player2Pick;

  void pick({
    Rps? player1,
    Rps? player2,
  }) {
    _player1Pick = player1 ?? _player1Pick;
    _player2Pick = player2 ?? _player2Pick;
  }

  String play() {
    if (_player1Pick == null || _player2Pick == null) {
      return 'Not everyone picked yet...';
    }
    if (_player1Pick == _player2Pick) {
      return 'Its a draw, Both $player1 and $player2 picked $_player1Pick';
    }
    if (_player1Pick!.winsFrom(_player2Pick!)) {
      return '$player1 won! They picked ${_player1Pick?.name} whilst $player2 picked ${_player2Pick?.name}';
    }

    return '$player2 won! They picked ${_player2Pick?.name} whilst $player1 picked ${_player1Pick?.name}';
  }
}

enum Rps {
  rock,
  paper,
  scissors;

  bool winsFrom(Rps other) {
    if (index - other.index == 1 || index - other.index == -2) {
      return true;
    }
    return false;
  }
}
