import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector_math;

import 'package:flutter_animate/flutter_animate.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: 20,
          child: Image.asset('assets/images/clock.png')
              .animate(
                onComplete: (controller) => controller.repeat(reverse: true),
              )
              .rotate(
                  end: math.pi / 100,
                  begin: -math.pi / 100,
                  alignment: Alignment.topCenter,
                  duration: 1.seconds,
                  curve: Curves.easeInOut),
        ),
        Column(
          children: [
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'HISTORA',
                    style: TextStyle(fontFamily: 'Rosarivo', fontSize: 45),
                  ),
                  Text(
                    'Your local AI tour guide',
                    style: TextStyle(fontFamily: 'Rosarivo', fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Transform(
                          transform: Matrix4.translation(
                            vector_math.Vector3(-100, 80, 0),
                          ),
                          child: Image.asset(
                            'assets/images/tree.png',
                            height: 1000,
                          ))
                      .animate(delay: 1.seconds)
                      .slideY(
                        begin: 4,
                        end: 0,
                        duration: 1.seconds,
                        curve: Curves.easeIn,
                      )
                      .then()
                      .shakeY(duration: 150.ms),
                  Positioned(
                    bottom: -40,
                    right: 10,
                    child: Transform.rotate(
                      angle: math.pi / 8,
                      child: Image.asset(
                        'assets/images/g144.png',
                        scale: 0.8,
                      ),
                    ),
                  )
                      .animate(
                        delay: 1.seconds,
                      )
                      .slideY(
                          begin: 4,
                          end: 0,
                          duration: 1.5.seconds,
                          curve: Curves.easeIn)
                      .then()
                      .shakeY(duration: 150.ms),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
