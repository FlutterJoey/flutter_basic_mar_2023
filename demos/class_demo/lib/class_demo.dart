Person? joey = const Person(
  firstName: 'Joey',
  lastName: 'Boerwinkel',
  birthYear: 1994,
  weight: 100,
);

int calculate() {
  var fruit = Fruit()
    ..amount = 10
    ..name = 'grape';

  var list = [1, 2, 3, 5, 4]
    ..remove(4)
    ..add(4)
    ..add(4)
    ..remove(4)
    ..sort()
    ..addAll([1, 1]);
  print(list);

  print('hello'.exclamate());

  return 6 * 7;
}

class Person {
  final String firstName;
  final String lastName;
  final int? birthYear;
  final int _weight;

  const Person({
    required this.firstName,
    required this.lastName,
    required int weight,
    this.birthYear,
  }) : _weight = weight;

  bool isTooHeavy(int weight) {
    return _weight > weight;
  }
}

class Fruit {
  String? name;
  int? amount;
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

String rockPaperScissors(Rps player1, Rps player2) {
  if (player1 == player2) {
    return 'draw';
  }
  if (player1.winsFrom(player2)) {
    return 'Player 1 wins';
  }
  return 'Player 2 wins';
}

extension Exclamate on String {
  String exclamate() {
    return '$this!';
  }
}
