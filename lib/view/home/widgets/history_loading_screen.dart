import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';

class HistoryLoadingScreen extends StatelessWidget {
  const HistoryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            switch (state) {
              case HistoryLoading():
                return const Text('History loading...');
              case GPSLoading():
                return const Text('GPS Loading...');
              case NearestStructureLoading():
                return const Text('Nearest structure loading...');
              case MatchingImages():
                return const Text('Matching images');
              case DetailLoading():
                return const Text('Found match..Getting details');
              default:
                return const Text('Done');
            }
          },
        ),
      ),
    );
  }
}
