import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histora/view/auth/auth/login_button.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset('assets/images/statue.jpg'),
          ),
          const SizedBox(height: 20),
          const Text(
            "Let's uncover some mysteries",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rosarivo',
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const LoginButton()
        ],
      ),
    );
  }
}

