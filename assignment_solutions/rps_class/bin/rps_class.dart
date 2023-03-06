import 'package:rps_class/rps_class.dart' as rps_class;

void main(List<String> arguments) {
  var rpsGame = rps_class.RpsGame(
    player1: 'Joey',
    player2: 'Bram',
  );

  rpsGame.pick(
    player1: rps_class.Rps.rock,
    player2: rps_class.Rps.scissors,
  );

  print(
    rpsGame.play(),
  ); // Joey picked Rock and won from Bram who picked scissors
}
