import 'package:flutter/material.dart';

void main() {
  runApp(Container(
    color: Colors.green,
    child: const PinkContainer(),
  ));
}

class PinkContainer extends StatelessWidget {
  const PinkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.pink,
      ),
      alignment: Alignment.center,
      child: const StopLight(),
    );
  }
}

class StopLight extends StatefulWidget {
  const StopLight({super.key});

  @override
  State<StopLight> createState() => _StopLightState();
}

class _StopLightState extends State<StopLight> {
  bool isGreen = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    if (isGreen) {
      color = Colors.green;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          isGreen = !isGreen;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 100,
        width: 100,
        duration: const Duration(milliseconds: 500),
        child: const Text(
          'Stop',
          style: TextStyle(shadows: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5.0,
            ),
          ],),
        ),
      ),
    );
  }
}
