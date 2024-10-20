import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We are team Histora'),
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                  )
                ]),
            child: Text(
              'At Histora, we believe that history isn’t just found in textbooks or famous landmarks—it’s all around us, waiting to be discovered. Our mission is to bring the stories of lesser-known historical places to life, giving everyone the chance to uncover the hidden gems scattered across the world.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                  )
                ]),
            child: Text(
              "Join us in celebrating history that’s often overlooked but no less important. Because every place has a story—it just needs someone to find it.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          Text("Made with ♥️ by Ayan, Ayush and Arti"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
