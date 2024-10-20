import 'package:flutter/material.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});
  static get path => '/travel-history';
  static get name => 'travel-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel History'),
      ),
      body: Center(child: Image.asset('assets/images/loading.gif')),
    );
  }
}
