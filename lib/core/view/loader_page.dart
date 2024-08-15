import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  static const String path = '/loader';
  static const String name = 'loader';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [Text('Loading....'), CircularProgressIndicator()],
        ),
      ),
    );
  }
}
