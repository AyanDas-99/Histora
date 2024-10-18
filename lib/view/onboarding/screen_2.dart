import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Found a piece of history but unsure how it came to be?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rosarivo',
              fontSize: 20,
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset('assets/images/boy_looking.jpeg')),
          const Text(
            "Take a picture and we'll tell you about it",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rosarivo',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
