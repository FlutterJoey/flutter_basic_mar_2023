import 'package:rps/rps.dart' as rps;

void main(List<String> arguments) {
  var p1 = rps.rock;
  if (arguments.isNotEmpty) {
    p1 = int.tryParse(arguments.first) ?? p1;
  }
  // print(rps.rockPaperScissors(player1: rps.rock, player2: rps.paper));
  // print(rps.rockPaperScissors(player1: rps.rock, player2: rps.scissors));
  // print(rps.rockPaperScissors(player1: rps.rock, player2: rps.rock));
  // print(rps.rockPaperScissors(player1: rps.paper));
  // print(rps.rockPaperScissors(player1: rps.rock));
  // print(rps.rockPaperScissors(player1: rps.scissors));
  print(rps.rockPaperScissors(player1: p1));
}
