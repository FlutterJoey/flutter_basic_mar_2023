// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:story_gen/story_gen.dart';

main() {
  runApp(const EventCardApp());
}

class EventCardApp extends StatelessWidget {
  const EventCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: StoryScreen(),
      ),
    );
  }
}

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  List<StoryBeatEvent> events = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            for (var event in events) ...[
              EventCard(
                iconData: Icons.electric_bolt_rounded,
                characterName: event.mainActor.name,
                message: event.message,
              ),
            ]
          ],
        ),
        FilledButton(
          onPressed: () {
            events.clear();
            var generator = HorrorStoryGenerator();
            generator.setScene(
              Scene(
                width: 10,
                length: 10,
                visibility: 3,
                characters: [
                  Character(
                    name: 'Joey',
                    archetype: Archetype.funny,
                  ),
                ],
              ),
            );
            generator.addStoryEventListener((event) {
              if (context.mounted) {
                setState(() {
                  events.add(event);
                });
              }
            });
            generator.generate(speed: Duration(seconds: 1));
          },
          child: Text('Start'),
        ),
      ],
    );
  }
}

class EventCard extends StatefulWidget {
  const EventCard({
    required this.iconData,
    required this.characterName,
    required this.message,
    super.key,
  });

  final IconData iconData;
  final String characterName;
  final String message;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isRead = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    if (isRead) {
      color = Colors.red.shade200;
    }
    var navigator = Navigator.of(context);
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(widget.iconData),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.characterName),
                Text('Message: ${widget.message}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton.icon(
              onPressed: () {
                setState(() {
                  isRead = true;
                });
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return DetailScreen(
                      characterName: widget.characterName,
                    );
                  }),
                  (route) => route.isFirst,
                );
              },
              icon: const Icon(Icons.chevron_right_rounded),
              label: const Text(
                'More',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    required this.characterName,
    Key? key,
  }) : super(key: key);

  final String characterName;

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(characterName),
      ),
      body: ElevatedButton(
        onPressed: () {
          navigator.pop();
        },
        child: Text('back'),
      ),
    );
  }
}
