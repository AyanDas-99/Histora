import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';

class HistoryLoadingScreen extends StatelessWidget {
  const HistoryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> allGifs = [
      'assets/images/whatt-where.gif',
      'assets/images/joe_finding.gif',
      'assets/images/images_slideshow.gif',
      'assets/images/downloading.gif',
    ];
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          switch (state) {
            case GPSLoading():
              return loader(allGifs[0], 'Getting your location');
            case NearestStructureLoading():
              return loader(allGifs[1], 'Finding things in your location');
            case MatchingImages():
              return loader(allGifs[2], 'Comparing images with AI...');
            case DetailLoading():
              return loader(allGifs[3], 'Getting details for you');
            default:
              return const Center(child: Text('All Done'));
          }
        },
      ),
    );
  }

  Widget loader(String image, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 20),
          Text(
            '$text ...',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
