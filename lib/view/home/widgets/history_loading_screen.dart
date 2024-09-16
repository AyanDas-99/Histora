import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:pulsator/pulsator.dart';

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
              return Loader(allGifs[0], 'Getting your location', 0.1);
            case NearestStructureLoading():
              return Loader(allGifs[1], 'Finding things in your location', 0.5);
            case MatchingImages():
              return Loader(allGifs[2], 'Comparing images with AI...', 0.7);
            case DetailLoading():
              return Loader(allGifs[3], 'Getting details for you', 0.9);
            default:
              return const Center(child: Text('All Done'));
          }
        },
      ),
    );
  }
}

class Loader extends StatelessWidget {
  final String image;
  final String text;
  final double progress;
  const Loader(this.image, this.text, this.progress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 500,
            child: Pulsator(
              style: const PulseStyle(color: Colors.blue),
              count: 3,
              child: CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage(image),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: progress,
              ),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 10,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
