import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedGlobe extends StatelessWidget {
  const AnimatedGlobe({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              gradient: RadialGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.white60,
              ])),
        )
            .animate(
              onComplete: (controller) => controller.repeat(reverse: true),
            )
            .scale(
              duration: 1.seconds,
              begin: const Offset(0.8, 0.8),
              curve: Curves.elasticIn,
            ),
        Image.asset(
          'assets/images/magic-ball.png',
          height: 70,
        )
            .animate(
              onComplete: (controller) => controller.repeat(),
            )
            .rotate(duration: 6.seconds),
      ],
    );
  }
}
