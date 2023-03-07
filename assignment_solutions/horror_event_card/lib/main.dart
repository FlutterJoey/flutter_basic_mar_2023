// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
        body: Column(
          children: const [
            EventCard(
              iconData: Icons.event,
              characterName: 'Bram',
              message: 'Bram was scared to death by a little mouse',
            ),
            EventCard(
              iconData: Icons.electric_bolt_rounded,
              characterName: 'Joey',
              message: 'Joey fell of a mountain and died',
            ),
          ],
        ),
      ),
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
