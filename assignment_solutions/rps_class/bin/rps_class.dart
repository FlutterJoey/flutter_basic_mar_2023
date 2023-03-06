import 'package:rps_class/rps_class.dart' as rps_class;

void main(List<String> arguments) {
  var rpsGame = rps_class.RpsGame(
    player1: 'Joey',
    player2: 'Bram',
  );

  rpsGame.pick(
    player1: rpsGame.rps.rock,
    player2: rpsGame.rps.scissors,
  );

  print(rpsGame.play);
}
