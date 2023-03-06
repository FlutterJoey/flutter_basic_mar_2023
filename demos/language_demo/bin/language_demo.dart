void main(List<String> arguments) {
  var a = 2;
  var b = 5;

  print('The value of a = $a');
  print('A($a) + B($b) = ${a + b}');

  String story = 'Dit is regel een\n'
      'Dit is regel twee\n'
      'Dit is de rest.';
  print(story);

  const moodKey = 'mood';

  var myMap = <String, String>{
    'name': 'Vick',
    moodKey: 'Slaperig',
  };

  print(myMap[moodKey]);

  print(helloWithNamed());
  print(helloWithNamed(name: 'Joey'));

  var list = ['apples', 'bananas', 'oranges'];
  for (var item in list) {
    print('${list.indexOf(item)}: $item');
  }

  num myNum = 1;
  if (myNum is int) {
    int myInt = myNum;
    print(myInt);
  }
}

String myFunction(String name) {
  return 'Hello I am $name';
}

String helloWithNamed({String name = 'Unknown'}) {
  return 'Hello $name';
}
